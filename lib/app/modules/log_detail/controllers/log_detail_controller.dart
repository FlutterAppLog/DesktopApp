import 'dart:io';

import 'package:darty_json_safe/darty_json_safe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:flutter_app_log_desktop_app/enums/log_color.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_app_log_desktop_app/utils/log_zip_manager.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:archive/archive.dart';

class LogDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// 日志详情tab控制器
  late TabController tabController;

  /// 展示日志详情
  final appLogs = <AppLog>[].obs;

  /// 用户详情
  final appUsers = <AppUserId>[].obs;

  /// Sentry ID
  final appSentryIds = <AppSentryId>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    appUsers.value = JSON(Get.arguments)['users'].rawValue ?? [];
    appSentryIds.value = JSON(Get.arguments)['sentrys'].rawValue ?? [];
    showHUD('解析日志文件...');
    parseLogFile().then((e) {
      hideHUD();
    }).catchError((e) {
      showToast(e.toString());
      hideHUD();
    });
  }

  /// 解析日志文件
  Future<void> parseLogFile() async {
    final logDir = await getLogDir();
    print('logDir: ${logDir.path}');
    final tempLogDir = Directory(join(logDir.path, 'temp'));
    if (await tempLogDir.exists()) {
      await tempLogDir.delete(recursive: true);
    }
    await tempLogDir.create(recursive: true);
    final logZipManager = LogZipManager();
    final zipFiles = await logZipManager.getZipFiles();
    for (var i = 0; i < zipFiles.length; i++) {
      final zipFile = zipFiles[i];
      final bytes = await zipFile.readAsBytes();
      await logZipManager.writeZip(bytes, basename(zipFile.path));
      if (!await unzipFile(zipFile.path, tempLogDir.path)) {
        throw Exception('日志解压失败!');
      }
    }

    appLogs.value = await getAppLogsFromLogDir(tempLogDir);
  }

  loadData(int index) async {
    if (index == 0) {
      // appLogs.value = await _isar.appLogs
      //     .filter()
      //     .appLoad((e) => e.idEqualTo(_appLoad.id))
      //     .findAll();
    } else if (index == 1) {
      // appUsers.value = await _isar.appUserIds
      //     .filter()
      //     .appLoad((e) => e.idEqualTo(_appLoad.id))
      //     .findAll();
    } else if (index == 2) {
      // appSentryIds.value = await _isar.appSentryIds
      //     .filter()
      //     .appLoad((e) => e.idEqualTo(_appLoad.id))
      //     .findAll();
    }
    update();
  }

  Color getLogColor(String level) {
    return LogColor.values
            .firstWhereOrNull((element) => element.level == 'Level.$level')
            ?.color ??
        Colors.black;
  }

  Future<bool> unzipFile(
      String zipFilePath, String destinationDirectory) async {
    try {
      // 读取 ZIP 文件的内容
      final bytes = File(zipFilePath).readAsBytesSync();

      // 解码 ZIP 文件
      final archive = ZipDecoder().decodeBytes(bytes);

      // 遍历 ZIP 文件中的每个文件
      for (final file in archive) {
        final filePath = join(destinationDirectory, basename(file.name));
        if (file.isFile) {
          final outputFile = File(filePath);
          if (!await outputFile.exists()) {
            await outputFile.create(recursive: true);
          }
          await outputFile.writeAsBytes(file.readBytes()!);
        }
      }
      return true;
    } catch (e) {
      showToast(e.toString());
      return false;
    }
  }
}
