import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app/routes/app_pages.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:flutter_app_log_desktop_app/utils/appwrite_client.dart';
import 'package:flutter_app_log_desktop_app/utils/log_zip_manager.dart';
import 'package:get/get.dart';

class ServerAppLoadController extends GetxController {
  /// 当前选中的搜索类型
  final Rx<ServerAppLoadKey> searchKey = ServerAppLoadKey.deviceId.obs;

  /// 搜索的关键词
  final TextEditingController searchController = TextEditingController();

  AppwriteClient get _appwriteClient => Get.find<AppwriteClient>();

  /// 当前查询出来的App启动事件
  final appLoads = Rxn<List<AppLoad>>();

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
    appLoads.value = documents
        .map((e) => AppLoad(
              appLoadId: e.$id,
              time: DateTime.parse(e.data['time']),
              deviceId: e.data['deviceId'],
              environment: e.data['environment'],
              isStoreVersion: e.data['isStoreVersion'],
            ))
        .toList();
  }

  /// 新建配置
  newConfig() {}

  Future<void> toAppLoadDetail(AppLoad object) async {
    final users = await _appwriteClient.queryUserByAppLoad(object.appLoadId);
    final sentrys =
        await _appwriteClient.querySentryByAppLoad(object.appLoadId);
    final logs = await _appwriteClient.queryLogsByAppLoad(object.appLoadId);
    LogZipManager logZipManager = LogZipManager();
    await logZipManager.clear();
    for (var i = 0; i < logs.length; i++) {
      final log = logs[i];
      final fileId = log.data['realmId'];
      final bytes = await _appwriteClient.downloadFile(fileId);
      final fileName = '$fileId.zip';
      await logZipManager.writeZip(bytes, fileName);
    }
    Get.toNamed(Routes.LOG_DETAIL, arguments: {
      'users': users
          .map(
            (e) => AppUserId(
              userId: e.data['userId'],
              time: DateTime.parse(e.data['time']),
            ),
          )
          .toList(),
      'sentrys': sentrys
          .map(
            (e) => AppSentryId(
              sentryId: e.data['sentryId'],
              title: e.data['title'],
              time: DateTime.parse(e.data['time']),
            ),
          )
          .toList(),
    });
  }

  logout() {}
}

enum ServerAppLoadKey {
  deviceId,
  userId,
  sentryId,
  sentryTitle,
}
