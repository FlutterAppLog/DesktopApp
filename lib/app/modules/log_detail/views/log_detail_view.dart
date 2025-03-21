import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app/modules/log_detail/controllers/log_detail_controller.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:flutter_app_log_desktop_app/widgets/search_list_view.dart';
import 'package:get/get.dart';

class LogDetailView extends GetView<LogDetailController> {
  const LogDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('日志详情'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            tabs: _buildTabs(),
            controller: controller.tabController,
            onTap: (value) => controller.loadData(value),
          ),
          Expanded(child: _buildTabBarView()),
        ],
      ),
    );
  }

  List<Tab> _buildTabs() {
    final titles = ['日志详情', '用户详情', 'Sentry ID'];
    return List.generate(
      titles.length,
      (index) => Tab(
        text: titles[index],
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: controller.tabController,
      children: [
        _buildLogWidget(),
        _buildUserIdWidget(),
        _buildSentryWidget(),
      ],
    );
  }

  /// Sentry ID
  Widget _buildSentryWidget() {
    return GetBuilder<LogDetailController>(builder: (controller) {
      return SearchListView<AppSentryId>(
        objects: controller.appSentryIds,
        itemBuilder: (context, object) {
          return ListTile(
            title: Text(
              getLocalDisplayTime(object.time),
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
            subtitle: Text(
              '[${object.sentryId}]${object.title}',
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          );
        },
        onFilter: (sentry, value) {
          return sentry.sentryId.contains(value);
        },
      );
    });
  }

  /// 用户ID
  Widget _buildUserIdWidget() {
    return GetBuilder<LogDetailController>(builder: (controller) {
      return SearchListView<AppUserId>(
        objects: controller.appUsers,
        itemBuilder: (context, object) {
          return ListTile(
            title: Text(getLocalDisplayTime(object.time)),
            subtitle: Text(object.userId),
          );
        },
        onFilter: (user, value) {
          return user.userId.contains(value);
        },
      );
    });
  }

  /// 日志
  Widget _buildLogWidget() {
    return Obx(
      () => SearchListView<AppLog>(
        hintText: '搜索日志(${controller.appLogs.length}条)',
        objects: controller.appLogs,
        itemBuilder: (context, object) {
          final textColor = controller.getLogColor(object.level);

          return ListTile(
            title: Text(
              getLocalDisplayTime(object.time),
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
            subtitle: Text(
              object.message,
              style: TextStyle(color: textColor, fontSize: 14),
            ),
          );
        },
        onFilter: (log, value) {
          return log.message.contains(value);
        },
      ),
    );
  }
}
