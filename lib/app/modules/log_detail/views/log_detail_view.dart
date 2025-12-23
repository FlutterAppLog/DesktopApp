import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        actions: [
          IconButton(
            tooltip: '下载全部日志',
            icon: const Icon(Icons.download),
            onPressed: () => controller.downloadAllLogs(),
          ),
        ],
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
    return Obx(
      () {
        final sentryList = controller.appSentryIds; // 触发响应
        return SearchListView<AppSentryId>(
          objects: sentryList.toList(),
          itemBuilder: (context, object) {
            return InkWell(
              onDoubleTap: () async {
                await Clipboard.setData(
                    ClipboardData(text: '[${object.sentryId}]${object.title}'));
                showToast('Sentry 已复制');
              },
              child: ListTile(
                title: Text(
                  getLocalDisplayTime(object.time),
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                subtitle: SelectableText(
                  '[${object.sentryId}]${object.title}',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            );
          },
          onFilter: (sentry, value) {
            return sentry.sentryId.contains(value);
          },
        );
      },
    );
  }

  /// 用户ID
  Widget _buildUserIdWidget() {
    return Obx(
      () {
        final userList = controller.appUsers; // 触发响应
        return SearchListView<AppUserId>(
          objects: userList.toList(),
          itemBuilder: (context, object) {
            return InkWell(
              onDoubleTap: () async {
                await Clipboard.setData(ClipboardData(text: object.userId));
                showToast('用户ID已复制');
              },
              child: ListTile(
                title: Text(getLocalDisplayTime(object.time)),
                subtitle: SelectableText(object.userId),
              ),
            );
          },
          onFilter: (user, value) {
            return user.userId.contains(value);
          },
        );
      },
    );
  }

  /// 日志
  Widget _buildLogWidget() {
    return Obx(
      () {
        final logs = controller.appLogs; // 触发响应
        final logCount = logs.length; // 显式读取以注册依赖
        return SearchListView<AppLog>(
          hintText: '搜索日志($logCount条)',
          objects: logs.toList(),
          itemBuilder: (context, object) {
            final textColor = controller.getLogColor(object.level);

            return InkWell(
              onDoubleTap: () async {
                // 双击复制整条日志文本，方便快速分享
                await Clipboard.setData(ClipboardData(text: object.message));
                showToast('日志已复制');
              },
              child: ListTile(
                title: Text(
                  getLocalDisplayTime(object.time),
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                subtitle: SelectableText(
                  object.message,
                  style: TextStyle(color: textColor, fontSize: 14),
                ),
              ),
            );
          },
          onFilter: (log, value) {
            return log.message.contains(value);
          },
        );
      },
    );
  }
}
