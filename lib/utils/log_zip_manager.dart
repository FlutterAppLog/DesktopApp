import 'dart:io';

import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:path/path.dart';

class LogZipManager {
  clear() async {
    final logZipDir = await getLogZipDir();
    if (await logZipDir.exists()) {
      await logZipDir.delete(recursive: true);
    }
    await logZipDir.create(recursive: true);
  }

  writeZip(List<int> bytes, String fileName) async {
    final logZipDir = await getLogZipDir();
    final zipFile = File(join(logZipDir.path, fileName));
    if (!await zipFile.exists()) {
      await zipFile.create(recursive: true);
    }
    await zipFile.writeAsBytes(bytes);
  }

  Future<List<File>> getZipFiles() async {
    final logZipDir = await getLogZipDir();
    return logZipDir
        .listSync()
        .where((e) => extension(e.path) == '.zip')
        .map((e) => File(e.path))
        .toList();
  }
}
