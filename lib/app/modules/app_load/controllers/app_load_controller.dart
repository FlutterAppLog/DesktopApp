import 'package:flutter_app_log_desktop_app/app/routes/app_pages.dart';
import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:get/get.dart';

class AppLoadController extends GetxController {
  /// 当前APP启动列表
  final appLoads = <AppLoad>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    // /// 加载启动数据
    // loadAppLoads(Get.arguments['path']);
  }

  // Future<void> loadAppLoads(String zipPath) async {
  //   if (!isZipFile(zipPath)) {
  //     throw Exception('日志格式错误!');
  //   }
  //   final logDir = await getLogDir();
  //   print('logDir: ${logDir.path}');
  //   final tempLogZip = File(join(logDir.path, 'temp.zip'));
  //   if (!await tempLogZip.exists()) {
  //     await tempLogZip.create(recursive: true);
  //   }
  //   final tempLogDir = Directory(join(logDir.path, 'temp'));
  //   await File(zipPath).copy(tempLogZip.path);
  //   if (!await unzipFile(tempLogZip.path, tempLogDir.path)) {
  //     throw Exception('日志解压失败!');
  //   }
  // }

  void toAppLoadDetail(AppLoad object) {
    Get.toNamed(Routes.LOG_DETAIL, arguments: {
      'appLoad': object,
    });
  }

  // Future<bool> unzipFile(
  //     String zipFilePath, String destinationDirectory) async {
  //   if (Directory(destinationDirectory).existsSync()) {
  //     await Directory(destinationDirectory).delete(recursive: true);
  //   }
  //   await Directory(destinationDirectory).create(recursive: true);
  //   try {
  //     // 读取 ZIP 文件的内容
  //     final bytes = File(zipFilePath).readAsBytesSync();

  //     // 解码 ZIP 文件
  //     final archive = ZipDecoder().decodeBytes(bytes);

  //     // 遍历 ZIP 文件中的每个文件
  //     for (final file in archive) {
  //       final filePath = join(destinationDirectory, basename(file.name));
  //       if (file.isFile) {
  //         final outputFile = File(filePath);
  //         if (!await outputFile.exists()) {
  //           await outputFile.create(recursive: true);
  //         }
  //         await outputFile.writeAsBytes(file.readBytes()!);
  //       }
  //     }
  //     return true;
  //   } catch (e) {
  //     showToast(e.toString());
  //     return false;
  //   }
  // }
}
