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
    appLogs.value = JSON(Get.arguments)['appLogs'].rawValue ?? [];
    appUsers.value = JSON(Get.arguments)['users'].rawValue ?? [];
    appSentryIds.value = JSON(Get.arguments)['sentrys'].rawValue ?? [];
    
  }

  

  loadData(int index) async {

  }

  Color getLogColor(String level) {
    return LogColor.values
            .firstWhereOrNull((element) => element.level == 'Level.$level')
            ?.color ??
        Colors.black;
  }

}
