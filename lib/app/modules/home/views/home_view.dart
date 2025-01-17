import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

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
          TDTabBar(
            tabs: const [
              TDTab(
                text: '预览本地日志',
              ),
              TDTab(
                text: '预览线上日志',
              ),
            ],
            controller: controller.tabController,
            showIndicator: true,
            backgroundColor: Colors.white,
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                Center(child: _buildLocalWidget()),
                Center(child: _buildOnlineWidget()),
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
              child: TDInput(
                backgroundColor: Colors.white,
                hintText: '请输入本地日志路径',
                controller: controller.localLogPathController,
                onChanged: (text) {},
                onClearTap: () {
                  controller.localLogPathController.clear();
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: TDInput(
                backgroundColor: Colors.white,
                hintText: '请输入本地日志密码',
                controller: controller.logPasswordController,
                onChanged: (text) {},
                onClearTap: () {
                  controller.logPasswordController.clear();
                },
              ),
            ),
            const SizedBox(width: 10),
            TDButton(
              text: '打开日志文件',
              onTap: () => controller.openLogFile(),
            ),
            const SizedBox(width: 10),
            TDButton(
              text: '选取日志文件',
              onTap: () => controller.selectLogFile(),
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
