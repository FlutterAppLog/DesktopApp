import 'package:flutter_app_log_desktop_app/app/routes/app_pages.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart';

class AppLoadController extends GetxController {
  /// 当前APP启动列表
  final appLoads = <AppLoad>[].obs;

  late Isar _isar;

  @override
  Future<void> onInit() async {
    String isarPath = Get.arguments['path'];
    super.onInit();
    _isar = await createIsarFromPath(isarPath);

    /// 加载启动数据
    loadAppLoads();
  }

  Future<void> loadAppLoads() async {
    appLoads.value =
        await _isar.appLoads.buildQuery<AppLoad>().findAll().catchError((e) {
      showToast(e.toString());
      throw e;
    });
    update();
  }

  void toAppLoadDetail(AppLoad object) {
    Get.toNamed(Routes.LOG_DETAIL, arguments: {
      'appLoad': object,
      'isar': _isar,
    });
  }

  @override
  void onClose() {
    _isar.close();
    super.onClose();
  }
}
