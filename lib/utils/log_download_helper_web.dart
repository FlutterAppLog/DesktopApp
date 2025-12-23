// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';

/// 在浏览器中触发文本文件下载，返回状态描述
Future<String> saveLogs(String content) async {
  final bytes = utf8.encode(content);
  final blob = html.Blob([bytes], 'text/plain', 'native');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..download = 'logs_${DateTime.now().millisecondsSinceEpoch}.txt'
    ..click();
  html.Url.revokeObjectUrl(url);
  return '浏览器已开始下载';
}

