import 'dart:io';

import 'package:path/path.dart';

import '../commons/functions.dart';

/// 将日志内容保存到本地导出目录，返回文件路径
Future<String> saveLogs(String content) async {
  final logDir = await getLogDir();
  final exportDir = Directory(join(logDir.path, 'exports'));
  if (!await exportDir.exists()) {
    await exportDir.create(recursive: true);
  }
  final fileName = 'logs_${DateTime.now().millisecondsSinceEpoch}.txt';
  final file = File(join(exportDir.path, fileName));
  await file.writeAsString(content);
  return file.path;
}

