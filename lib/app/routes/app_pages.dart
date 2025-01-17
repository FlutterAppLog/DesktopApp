import 'package:flutter_app_log_desktop_app/app/modules/log_detail/views/log_detail_view.dart';
import 'package:get/get.dart';

import '../modules/app_load/bindings/app_load_binding.dart';
import '../modules/app_load/views/app_load_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/log_detail/bindings/log_detail_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.APP_LOAD,
      page: () => const AppLoadView(),
      binding: AppLoadBinding(),
    ),
    GetPage(
      name: _Paths.LOG_DETAIL,
      page: () => const LogDetailView(),
      binding: LogDetailBinding(),
    ),
  ];
}
