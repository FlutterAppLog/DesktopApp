import 'package:intl/intl.dart';

String getLocalDisplayTime(DateTime utcTime) {
  // 将UTC时间转换为本地时间
  DateTime localDateTime = utcTime.toLocal();
  // 创建DateFormat对象用于格式化时间，这里设置格式为常见的 yyyy-MM-dd HH:mm:ss
  DateFormat dateFormat = DateFormat('yyyy年-MM月-dd日 HH时:mm分:ss秒');
  // 格式化输出本地时间，并带上时区信息
  String formattedTime = dateFormat.format(localDateTime);
  return '$formattedTime ${localDateTime.millisecond}毫秒';
}
