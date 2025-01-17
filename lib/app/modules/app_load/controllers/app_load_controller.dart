import 'package:flutter_app_log_desktop_app/app/routes/app_pages.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_app_log_desktop_app/utils/realm_utils.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

class AppLoadController extends GetxController {
  /// 当前APP启动列表
  final appLoads = <AppLoad>[].obs;

  late Realm _realm;

  @override
  void onInit() {
    String realmPath = Get.arguments['path'];
    String password = Get.arguments['password'];
    _realm = Get.find<RealmUtils>().getRealm(
      realmPath,
      password,
      closeOld: true,
    );
    super.onInit();

    /// 加载启动数据
    loadAppLoads();
  }

  void loadAppLoads() {
    appLoads.value = _realm.queryOffsetCount(1, 100);
  }

  void toAppLoadDetail(AppLoad object) {
    Get.toNamed(Routes.LOG_DETAIL, arguments: {
      'appLoad': object,
      'realm': _realm,
    });
  }
}
