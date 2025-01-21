import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/enums/log_color.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class LogDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// 日志详情tab控制器
  late TabController tabController;

  /// 当前APP启动对象
  late AppLoad _appLoad;
  late Isar _isar;

  /// 展示日志详情
  final appLogs = <AppLog>[].obs;

  /// 用户详情
  final appUsers = <AppUserId>[].obs;

  /// Sentry ID
  final appSentryIds = <AppSentryId>[].obs;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    _appLoad = Get.arguments['appLoad'];
    _isar = Get.arguments['isar'];
    super.onInit();
    loadData(0);
  }

  loadData(int index) async {
    if (index == 0) {
      appLogs.value = await _isar.appLogs
          .filter()
          .appLoad((e) => e.idEqualTo(_appLoad.id))
          .findAll();
    } else if (index == 1) {
      appUsers.value = await _isar.appUserIds
          .filter()
          .appLoad((e) => e.idEqualTo(_appLoad.id))
          .findAll();
    } else if (index == 2) {
      appSentryIds.value = await _isar.appSentryIds
          .filter()
          .appLoad((e) => e.idEqualTo(_appLoad.id))
          .findAll();
    }
    update();
  }

  Color getLogColor(String level) {
    return LogColor.values
            .firstWhereOrNull((element) => element.level == level)
            ?.color ??
        Colors.black;
  }
}
