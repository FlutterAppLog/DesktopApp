import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  /// 本地日志路径控制器
  final localLogPathController = TextEditingController();

  /// 日志密码
  final logPasswordController = TextEditingController();

  @override
  void onInit() {
    if (kDebugMode) {
      logPasswordController.text =
          const String.fromEnvironment('realm_password');
    }
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  /// 选取日志文件
  Future<void> selectLogFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['realm'],
    );
    if (result == null) {
      return;
    }
    localLogPathController.text = result.files.first.path!;
  }

  openLogFile() {
    Get.toNamed(Routes.APP_LOAD, arguments: {
      'path': localLogPathController.text,
      'password': logPasswordController.text,
    });
  }
}
