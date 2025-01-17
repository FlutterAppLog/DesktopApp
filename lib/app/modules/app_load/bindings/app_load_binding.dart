import 'package:get/get.dart';

import '../controllers/app_load_controller.dart';

class AppLoadBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppLoadController());
  }
}
