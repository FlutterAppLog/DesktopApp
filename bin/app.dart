import 'dart:io';

import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:path/path.dart';

Future<void> main(List<String> args) async {
  final logDir = args[0];
  final appLogs = <AppLog>[];
  for (var i = 0; i < 500; i++) {
    final logFile = File(join(logDir, '$i.txt'));
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
        appLog?.message = '$appLog?.message\n$logLine';
      }
    }
    if (appLog != null) {
      appLogs.add(appLog);
    }
  }
  print(appLogs.length);
}
