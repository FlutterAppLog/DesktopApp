import 'package:flutter/material.dart';
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                decoration: const InputDecoration(labelText: '请输入本地日志路径'),
                controller: controller.localLogPathController,
                onChanged: (text) {},
              ),
            ),
            Expanded(
              flex: 1,
              child: TextField(
                decoration: const InputDecoration(labelText: '请输入本地日志密码'),
                controller: controller.logPasswordController,
                onChanged: (text) {},
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              child: const Text('打开日志文件'),
              onPressed: () => controller.openLogFile(),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              child: const Text('选取日志文件'),
              onPressed: () => controller.selectLogFile(),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildOnlineWidget() {
    return const Center(
      child: Text('预览线上日志'),
    );
  }
}
