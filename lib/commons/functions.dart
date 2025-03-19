import 'dart:io';

import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:intl/intl.dart';
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

/// 获取存放日志文件的目录
Future<Directory> getLogDir() async {
  return getApplicationDocumentsDirectory()
      .then((e) => Directory(join(e.path, 'logs')));
}

/// 存放日志Zip的目录
Future<Directory> getLogZipDir() async {
  return getLogDir().then((e) => Directory(join(e.path, 'temp_zips')));
}

/// 存放解压的日志Zip的Txt文件的目录
Future<Directory> getLogTxtDir() async {
  return getLogDir().then((e) => Directory(join(e.path, 'temp_txts')));
}

/// 判断文件是否是zip文件
bool isZipFile(String path) {
  return extension(path) == '.zip';
}

/// 解析日志文件
Future<List<AppLog>> getAppLogsFromLogDir(Directory logDir) async {
  final appLogs = <AppLog>[];
  for (var i = 0; i < 500; i++) {
    final logFile = File(join(logDir.path, '$i.txt'));
    if (!await logFile.exists()) {
      break;
    }
    final logLines = await logFile.readAsLines();
    AppLog? appLog;
    for (final logLine in logLines) {
      RegExp levelMatch = RegExp(r'^\[Level\.([^\]]+)\]');
      RegExp timeMatch =
          RegExp(r'\[(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+)\]');
      if (levelMatch.hasMatch(logLine) && timeMatch.hasMatch(logLine)) {
        if (appLog != null) {
          appLogs.add(appLog);
        }
        final level = levelMatch.firstMatch(logLine)?.group(1);
        final time = timeMatch.firstMatch(logLine)?.group(1);
        appLog = AppLog();
        appLog.level = level!;
        appLog.time = DateTime.parse(time!);
        appLog.message = logLine;
      } else {
        appLog?.message = '${appLog.message}\n$logLine';
      }
    }
    if (appLog != null) {
      appLogs.add(appLog);
    }
  }
  return appLogs;
}

/// 复制Zip到对应的目录
Future<void> copyZipsToLogZipDir(List<File> zipFiles) async {
  final logZipDir = await getLogZipDir();

  /// 删除目录下的所有文件
  if (await logZipDir.exists()) {
    await logZipDir.delete(recursive: true);
  }
  await logZipDir.create(recursive: true);
  for (final zipFile in zipFiles) {
    final fileName = basename(zipFile.path);
    final newZipFile = File(join(logZipDir.path, fileName));
    if (!await newZipFile.exists()) {
      await newZipFile.create(recursive: true);
    }
    await zipFile.copy(newZipFile.path);
  }
}
