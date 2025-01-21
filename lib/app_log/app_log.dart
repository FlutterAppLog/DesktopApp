import 'package:isar/isar.dart';
part 'app_log.g.dart';

/// App启动
@Collection()
class AppLoad {
  /// ISAR 数据库ID
  Id id = Isar.autoIncrement;

  /// 存储在Appwrite的数据库ID
  late String appwriteId;

  /// App启动时间
  late DateTime time;

  /// 设备的唯一ID
  late String deviceId;

  /// 当前日志环境
  late String environment;

  /// 是否是市场版本
  late bool isStoreVersion;

  /// 是否同步
  late bool isSynced;
}

/// App日志
@Collection()
class AppLog {
  /// ISAR 数据库ID
  Id id = Isar.autoIncrement;

  /// 日志类型
  late String level;

  /// 日志内容
  late String message;

  /// 日志时间
  late DateTime time;

  /// 是否已经同步到服务器
  late bool isSynced;

  /// App启动日志
  final appLoad = IsarLink<AppLoad>();
}

@Collection()
class AppSentryId {
  Id id = Isar.autoIncrement;

  /// Sentry的ID
  late String sentryId;

  /// 标题
  late String title;

  /// App启动日志
  final appLoad = IsarLink<AppLoad>();

  /// 时间
  late DateTime time;

  /// 是否已经同步
  late bool isSynced;
}

@Collection()
class AppUserId {
  Id id = Isar.autoIncrement;

  /// 用户ID
  late String userId;

  /// App启动日志
  final appLoad = IsarLink<AppLoad>();

  /// 时间
  late DateTime time;

  /// 是否已经同步
  late bool isSynced;
}
