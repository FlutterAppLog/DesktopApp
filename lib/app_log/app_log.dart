import 'package:realm/realm.dart';
part 'app_log.realm.dart';

/// App启动
@RealmModel()
class _AppLoad {
  @PrimaryKey()
  late Uuid id;

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
@RealmModel()
class _AppLog {
  @PrimaryKey()
  late Uuid id;

  /// 日志类型
  late String level;

  /// 日志内容
  late String message;

  /// 日志时间
  late DateTime time;

  /// 是否已经同步到服务器
  late bool isSynced;

  /// App启动日志
  late _AppLoad? appLoad;
}

@RealmModel()
class _AppSentryId {
  @PrimaryKey()
  late Uuid id;

  /// Sentry的ID
  late String sentryId;

  /// 标题
  late String title;

  /// 日志ID
  late _AppLoad? appLoad;

  /// 时间
  late DateTime time;

  /// 是否已经同步
  late bool isSynced;
}

@RealmModel()
class _AppUserId {
  @PrimaryKey()
  late Uuid id;

  /// 用户ID
  late String userId;

  /// 日志ID
  late _AppLoad? appLoad;

  /// 时间
  late DateTime time;

  /// 是否已经同步
  late bool isSynced;
}
