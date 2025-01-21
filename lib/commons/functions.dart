import 'dart:io';

import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

String getLocalDisplayTime(DateTime utcTime) {
  // 将UTC时间转换为本地时间
  DateTime localDateTime = utcTime.toLocal();
  // 创建DateFormat对象用于格式化时间，这里设置格式为常见的 yyyy-MM-dd HH:mm:ss
  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  // 格式化输出本地时间，并带上时区信息
  String formattedTime = dateFormat.format(localDateTime);
  return '$formattedTime ${localDateTime.millisecond}';
}

showHUD([String text = '加载中']) {
  SmartDialog.showLoading(msg: text);
}

hideHUD() {
  SmartDialog.dismiss();
}

showToast(String text) {
  SmartDialog.showToast(text);
}

Future<Isar> createIsarFromPath(String path) async {
  final isarDir = await getApplicationDocumentsDirectory().then((e) => e.path);
  final name = basenameWithoutExtension(path);
  final file = File(join(isarDir, '$name.isar'));
  if (await file.exists()) {
    await file.delete(recursive: true);
  }
  await File(path).copy(file.path);
  return Isar.open(
    [AppLoadSchema, AppLogSchema, AppUserIdSchema, AppSentryIdSchema],
    directory: isarDir,
    name: name,
  );
}

Future<Isar> createDefaultIsar() async {
  return Isar.open(
    [AppLoadSchema, AppLogSchema, AppUserIdSchema, AppSentryIdSchema],
    directory: await getApplicationDocumentsDirectory().then((e) => e.path),
  );
}
