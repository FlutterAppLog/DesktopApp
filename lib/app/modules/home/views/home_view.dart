import 'package:flutter/material.dart';
import 'package:flutter_app_log_desktop_app/app/modules/server_app_load/controllers/server_app_load_controller.dart';
import 'package:flutter_app_log_desktop_app/app/modules/server_app_load/views/server_app_load_view.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('欢迎使用Flutter 日志系统'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(
                text: '预览本地日志',
              ),
              Tab(
                text: '预览线上日志',
              ),
            ],
            controller: controller.tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                _buildLocalWidget(),
                _buildOnlineWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLocalWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: '请输入本地(.zip)日志路径'),
            controller: controller.localLogPathController,
            onChanged: (text) {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  child: const Text('选取日志文件'),
                  onPressed: () => controller.selectLogFile(),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  child: const Text('打开日志文件'),
                  onPressed: () => controller.openLogFile(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<HomeController>(
          builder: (_) => controller.needLogin.value
              ? _buildLoginWidget()
              : _buildSearchWidget()),
    );
  }

  Widget _buildSearchWidget() {
    return GetBuilder(
      builder: (_) {
        return ServerAppLoadView(
          onLogout: () => controller.logout(),
        );
      },
      init: controller.serverAppLoadController,
    );
  }

  Column _buildLoginWidget() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: '请输入邮箱',
          ),
          controller: controller.emailController,
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: '请输入密码',
          ),
          controller: controller.passwordController,
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () => controller.login(),
          child: const Text('登录'),
        ),
      ],
    );
  }
}
