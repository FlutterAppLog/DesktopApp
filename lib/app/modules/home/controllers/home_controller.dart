import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app/modules/server_app_load/controllers/server_app_load_controller.dart';
import 'package:flutter_app_log_desktop_app/app/routes/app_pages.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:flutter_app_log_desktop_app/utils/appwrite_client.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  /// 本地日志路径控制器
  final localLogPathController = TextEditingController();

  /// 邮箱
  final emailController = TextEditingController();

  /// 密码
  final passwordController = TextEditingController();

  /// 是否需要登录
  final needLogin = true.obs;

  final serverAppLoadController = ServerAppLoadController();

  @override
  Future<void> onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    showHUD('正在初始化...');
    needLogin.value = await Get.find<AppwriteClient>().checkNeedLogin();
    update();
    hideHUD();
  }

  /// 选取日志文件
  Future<void> selectLogFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['isar'],
    );
    if (result == null) {
      return;
    }
    localLogPathController.text = result.files.first.path!;
  }

  openLogFile() {
    Get.toNamed(Routes.APP_LOAD, arguments: {
      'path': localLogPathController.text,
    });
  }

  login() async {
    final email = emailController.text;
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      showToast('请输入邮箱和密码');
      return;
    }
    showHUD('登录中...');
    await Get.find<AppwriteClient>().auth(email, password).catchError((e) {
      hideHUD();
      showToast(e.message);
      throw e;
    });
    hideHUD();
    log('登录成功');
    needLogin.value = false;
    update();
  }

  logout() async {
    needLogin.value = await Get.find<AppwriteClient>().logout().then((e) {
      return true;
    }).catchError((e) {
      showToast(e.message);
      return true;
    });
    update();
  }
}
