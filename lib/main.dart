import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/utils/appwrite_client.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.lazyPut(() => AppwriteClient());
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    ),
  );
}
