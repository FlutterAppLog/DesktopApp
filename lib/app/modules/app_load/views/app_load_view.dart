import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:flutter_app_log_desktop_app/widgets/search_list_view.dart';

import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../controllers/app_load_controller.dart';

class AppLoadView extends GetView<AppLoadController> {
  const AppLoadView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App启动列表'),
        centerTitle: true,
      ),
      body: SearchListView(
        objects: controller.appLoads,
        itemBuilder: (context, object) {
          return TDCell(
            title: '${getLocalDisplayTime(object.time)}(${object.id})',
            description: object.deviceId,
            onClick: (cell) {
              controller.toAppLoadDetail(object);
            },
          );
        },
      ),
    );
  }
}
