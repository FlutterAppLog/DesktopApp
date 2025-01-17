import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app/enums/log_color.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';
import 'package:flutter_app_log_desktop_app/utils/realm_utils.dart';

class LogDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// 日志详情tab控制器
  late TabController tabController;

  /// 当前APP启动对象
  late AppLoad _appLoad;
  late Realm _realm;

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
    _realm = Get.arguments['realm'];
    super.onInit();
    loadData(0);
  }

  loadData(int index) {
    if (index == 0) {
      appLogs.value = _realm.queryByAppLoadId<AppLog>(_appLoad);
    } else if (index == 1) {
      appUsers.value = _realm.queryByAppLoadId<AppUserId>(_appLoad);
    } else if (index == 2) {
      appSentryIds.value = _realm.queryByAppLoadId<AppSentryId>(_appLoad);
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
