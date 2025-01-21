import 'package:get/get.dart';

import '../controllers/server_app_load_controller.dart';

class ServerAppLoadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServerAppLoadController>(
      () => ServerAppLoadController(),
    );
  }
}
