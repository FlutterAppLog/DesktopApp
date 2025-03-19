/// App启动
class AppLoad {
  /// App启动ID
  final String appLoadId;

  /// App启动时间
  final DateTime time;

  /// 设备的唯一ID
  final String deviceId;

  /// 当前日志环境
  final String environment;

  /// 是否是市场版本
  final bool isStoreVersion;

  const AppLoad({
    required this.appLoadId,
    required this.time,
    required this.deviceId,
    required this.environment,
    required this.isStoreVersion,
  });
}

/// App日志
class AppLog {
  /// 日志类型
  late String level;

  /// 日志内容
  late String message;

  /// 日志时间
  late DateTime time;
}

class AppSentryId {
  /// Sentry的ID
  final String sentryId;

  /// 标题
  final String title;

  /// 时间
  final DateTime time;

  const AppSentryId({
    required this.sentryId,
    required this.title,
    required this.time,
  });
}

class AppUserId {
  /// 用户ID
  final String userId;

  /// 时间
  final DateTime time;

  const AppUserId({
    required this.userId,
    required this.time,
  });
}
