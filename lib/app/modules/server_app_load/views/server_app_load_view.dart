import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:flutter_app_log_desktop_app/widgets/search_list_view.dart';

import 'package:get/get.dart';

import '../controllers/server_app_load_controller.dart';

class ServerAppLoadView extends GetView<ServerAppLoadController> {
  final void Function()? onLogout;
  const ServerAppLoadView({super.key, this.onLogout});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                () => DropdownMenu<ServerAppLoadKey>(
                  initialSelection: controller.searchKey.value,
                  label: const Text('选择搜索的类型'),
                  requestFocusOnTap: false,
                  dropdownMenuEntries: ServerAppLoadKey.values
                      .map((e) => DropdownMenuEntry(
                            value: e,
                            label: e.name,
                          ))
                      .toList(),
                  onSelected: (value) {
                    if (value != null) {
                      controller.searchKey.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: '请输入搜索关键字',
                  ),
                  controller: controller.searchController,
                ),
              ),
              ElevatedButton(
                  onPressed: () => controller.search(),
                  child: const Text('搜索')),
              ElevatedButton(
                  onPressed: () => onLogout?.call(), child: const Text('退出登录')),
            ],
          ),
          Expanded(
            child: Obx(() {
              final list = controller.appLoads.value;
              if (list == null) return Container();
              if (list.isEmpty) return _buildNoData();
              return _buildData(list);
            }),
          ),
        ],
      ),
    );
  }

  Column _buildNoData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('当前搜索无内容,请尝试其他搜索关键字或者新建通知等待用户上传!'),
        const SizedBox(height: 10),
        ElevatedButton(
          child: const Text('新建通知'),
          onPressed: () => controller.newConfig(),
        )
      ],
    );
  }

  Widget _buildData(List<AppLoad> appLoads) {
    return SearchListView(
      objects: appLoads,
      itemBuilder: (context, object) {
        return ListTile(
          title: Text('${getLocalDisplayTime(object.time)}(${object.id})'),
          subtitle: Text(object.deviceId),
          onTap: () {
            controller.toAppLoadDetail(object).catchError((e) {
              hideHUD();
              showToast(e.toString());
            });
          },
        );
      },
    );
  }
}
