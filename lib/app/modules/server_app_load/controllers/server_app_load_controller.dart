import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app/routes/app_pages.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:flutter_app_log_desktop_app/utils/appwrite_client.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ServerAppLoadController extends GetxController {
  /// 当前选中的搜索类型
  final Rx<ServerAppLoadKey> searchKey = ServerAppLoadKey.deviceId.obs;

  /// 搜索的关键词
  final TextEditingController searchController = TextEditingController();

  AppwriteClient get _appwriteClient => Get.find<AppwriteClient>();

  /// 当前查询出来的App启动事件
  final appLoads = Rxn<List<AppLoad>>();

  late Isar _isar;

  @override
  onInit() async {
    super.onInit();
    _isar = await createDefaultIsar();
  }

  /// 进行搜索
  search() async {
    final key = searchKey.value;
    final searchText = searchController.text;
    if (searchText.isEmpty) {
      showToast('请输入搜索关键词');
      return;
    }
    showHUD();
    List<Document> documents = [];
    if (key == ServerAppLoadKey.deviceId) {
      documents = await _appwriteClient.queryAppLoads(searchText);
    } else if (key == ServerAppLoadKey.userId) {
      documents = await _appwriteClient.queryUser(searchText);
    } else if (key == ServerAppLoadKey.sentryId) {
      documents = await _appwriteClient.querySentry(searchText);
    } else if (key == ServerAppLoadKey.sentryTitle) {
      documents = await _appwriteClient.querySentryByTitle(searchText);
    }

    hideHUD();
    if (documents.isEmpty) {
      return;
    }

    _clearIasrAllTable();

    List<AppLoad> appLoads = documents.map((e) {
      return AppLoad()
        ..appwriteId = e.$id
        ..time = DateTime.parse(e.data['time'])
        ..deviceId = e.data['deviceId']
        ..environment = e.data['environment']
        ..isSynced = true
        ..isStoreVersion = e.data['isStoreVersion'];
    }).toList();

    /// 写入数据
    await _isar.writeTxn(() async {
      await _isar.appLoads.putAll(appLoads);
    });
    this.appLoads.value = appLoads;
    update();
  }

  /// 新建配置
  newConfig() {}

  Future<void> toAppLoadDetail(AppLoad object) async {
    /// 查询当前关联的启动数据到本地
    showHUD('正在同步数据到本地');

    /// 移除数据库之前的数据
    await _isar.writeTxn(() async {
      await _isar.appSentryIds.clear();
      await _isar.appUserIds.clear();
      await _isar.appLogs.clear();
    });
    final userIds = _appwriteClient.queryUserByAppLoad(object.appwriteId);
    final logs = _appwriteClient.queryLogsByAppLoad(object.appwriteId);
    final sentries = _appwriteClient.querySentryByAppLoad(object.appwriteId);
    List<List<Document>> result =
        await Future.wait<List<Document>>([userIds, logs, sentries])
            .catchError((e) {
      hideHUD();
      showToast(e.toString());
      throw e;
    });

    await _isar.writeTxn(
      () async {
        for (final e in result[0]) {
          final user = AppUserId()
            ..userId = e.data['userId']
            ..time = DateTime.parse(e.data['time'])
            ..isSynced = true
            ..appLoad.value = object;
          await _isar.appUserIds.put(user);
          await user.appLoad.save();
        }

        for (final e in result[2]) {
          final sentry = AppSentryId()
            ..sentryId = e.data['sentryId']
            ..time = DateTime.parse(e.data['time'])
            ..title = e.data['title']
            ..isSynced = true
            ..appLoad.value = object;
          await _isar.appSentryIds.put(sentry);
          await sentry.appLoad.save();
        }
      },
    );

    for (var e in result[1]) {
      final realmId = e.data['realmId'];
      final file = await _appwriteClient.downloadFile(realmId);
      if (file != null) {
        Isar isar = await createIsarFromPath(file.path);
        List<AppLog> logs = await isar.appLogs.buildQuery<AppLog>().findAll();
        await _isar.writeTxn(() async {
          for (final e in logs) {
            final log = AppLog()
              ..level = e.level
              ..message = e.message
              ..time = e.time
              ..isSynced = true
              ..appLoad.value = object;
            await _isar.appLogs.put(log);
            await log.appLoad.save();
          }
        });
        await isar.close();
      }
    }
    hideHUD();
    Get.toNamed(Routes.LOG_DETAIL, arguments: {
      'appLoad': object,
      'isar': _isar,
    });
  }

  Future<void> _clearIasrAllTable() async {
    /// 移除数据库之前的数据
    await _isar.writeTxn(() async {
      _isar.appLoads.clear();
      _isar.appUserIds.clear();
      _isar.appSentryIds.clear();
      _isar.appLogs.clear();
    });
  }

  logout() {}

  @override
  Future<void> onClose() async {
    await _isar.close();
    super.onClose();
  }
}

enum ServerAppLoadKey {
  deviceId,
  userId,
  sentryId,
  sentryTitle,
}
