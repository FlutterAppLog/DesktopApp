import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/utils/realm_utils.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.lazyPut(() => RealmUtils());
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
