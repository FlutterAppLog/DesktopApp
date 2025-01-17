import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app/modules/log_detail/controllers/log_detail_controller.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:flutter_app_log_desktop_app/widgets/search_list_view.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

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
          TDTabBar(
            tabs: _buildTabs(),
            controller: controller.tabController,
            backgroundColor: Colors.white,
            showIndicator: true,
            onTap: (p0) {
              controller.loadData(p0);
            },
          ),
          Expanded(child: _buildTabBarView()),
        ],
      ),
    );
  }

  List<TDTab> _buildTabs() {
    final titles = ['日志详情', '用户详情', 'Sentry ID'];
    return List.generate(
      titles.length,
      (index) => TDTab(
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
          return TDCell(
            title: '${getLocalDisplayTime(object.time)}(${object.sentryId})',
            description: object.title,
            onClick: (cell) {},
          );
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
            return TDCell(
              title: getLocalDisplayTime(object.time),
              description: object.userId,
              onClick: (cell) {},
            );
          });
    });
  }

  /// 日志
  Widget _buildLogWidget() {
    return GetBuilder<LogDetailController>(builder: (controller) {
      return SearchListView<AppLog>(
        hintText: '搜索日志(${controller.appLogs.length}条)',
        objects: controller.appLogs,
        itemBuilder: (context, object) {
          final cellStyle = TDCellStyle.cellStyle(context);
          cellStyle.descriptionStyle = cellStyle.descriptionStyle!.copyWith(
            color: controller.getLogColor(object.level),
          );

          return TDCell(
            title: getLocalDisplayTime(object.time),
            description: object.message,
            style: cellStyle,
            onClick: (cell) {},
          );
        },
      );
    });
  }
}
