// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_log.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class AppLoad extends _AppLoad with RealmEntity, RealmObjectBase, RealmObject {
  AppLoad(
    Uuid id,
    DateTime time,
    String deviceId,
    String environment,
    bool isStoreVersion,
    bool isSynced,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'time', time);
    RealmObjectBase.set(this, 'deviceId', deviceId);
    RealmObjectBase.set(this, 'environment', environment);
    RealmObjectBase.set(this, 'isStoreVersion', isStoreVersion);
    RealmObjectBase.set(this, 'isSynced', isSynced);
  }

  AppLoad._();

  @override
  Uuid get id => RealmObjectBase.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => RealmObjectBase.set(this, 'id', value);

  @override
  DateTime get time => RealmObjectBase.get<DateTime>(this, 'time') as DateTime;
  @override
  set time(DateTime value) => RealmObjectBase.set(this, 'time', value);

  @override
  String get deviceId =>
      RealmObjectBase.get<String>(this, 'deviceId') as String;
  @override
  set deviceId(String value) => RealmObjectBase.set(this, 'deviceId', value);

  @override
  String get environment =>
      RealmObjectBase.get<String>(this, 'environment') as String;
  @override
  set environment(String value) =>
      RealmObjectBase.set(this, 'environment', value);

  @override
  bool get isStoreVersion =>
      RealmObjectBase.get<bool>(this, 'isStoreVersion') as bool;
  @override
  set isStoreVersion(bool value) =>
      RealmObjectBase.set(this, 'isStoreVersion', value);

  @override
  bool get isSynced => RealmObjectBase.get<bool>(this, 'isSynced') as bool;
  @override
  set isSynced(bool value) => RealmObjectBase.set(this, 'isSynced', value);

  @override
  Stream<RealmObjectChanges<AppLoad>> get changes =>
      RealmObjectBase.getChanges<AppLoad>(this);

  @override
  Stream<RealmObjectChanges<AppLoad>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AppLoad>(this, keyPaths);

  @override
  AppLoad freeze() => RealmObjectBase.freezeObject<AppLoad>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'time': time.toEJson(),
      'deviceId': deviceId.toEJson(),
      'environment': environment.toEJson(),
      'isStoreVersion': isStoreVersion.toEJson(),
      'isSynced': isSynced.toEJson(),
    };
  }

  static EJsonValue _toEJson(AppLoad value) => value.toEJson();
  static AppLoad _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'time': EJsonValue time,
        'deviceId': EJsonValue deviceId,
        'environment': EJsonValue environment,
        'isStoreVersion': EJsonValue isStoreVersion,
        'isSynced': EJsonValue isSynced,
      } =>
        AppLoad(
          fromEJson(id),
          fromEJson(time),
          fromEJson(deviceId),
          fromEJson(environment),
          fromEJson(isStoreVersion),
          fromEJson(isSynced),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AppLoad._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, AppLoad, 'AppLoad', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('time', RealmPropertyType.timestamp),
      SchemaProperty('deviceId', RealmPropertyType.string),
      SchemaProperty('environment', RealmPropertyType.string),
      SchemaProperty('isStoreVersion', RealmPropertyType.bool),
      SchemaProperty('isSynced', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class AppLog extends _AppLog with RealmEntity, RealmObjectBase, RealmObject {
  AppLog(
    Uuid id,
    String level,
    String message,
    DateTime time,
    bool isSynced, {
    AppLoad? appLoad,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'level', level);
    RealmObjectBase.set(this, 'message', message);
    RealmObjectBase.set(this, 'time', time);
    RealmObjectBase.set(this, 'isSynced', isSynced);
    RealmObjectBase.set(this, 'appLoad', appLoad);
  }

  AppLog._();

  @override
  Uuid get id => RealmObjectBase.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get level => RealmObjectBase.get<String>(this, 'level') as String;
  @override
  set level(String value) => RealmObjectBase.set(this, 'level', value);

  @override
  String get message => RealmObjectBase.get<String>(this, 'message') as String;
  @override
  set message(String value) => RealmObjectBase.set(this, 'message', value);

  @override
  DateTime get time => RealmObjectBase.get<DateTime>(this, 'time') as DateTime;
  @override
  set time(DateTime value) => RealmObjectBase.set(this, 'time', value);

  @override
  bool get isSynced => RealmObjectBase.get<bool>(this, 'isSynced') as bool;
  @override
  set isSynced(bool value) => RealmObjectBase.set(this, 'isSynced', value);

  @override
  AppLoad? get appLoad =>
      RealmObjectBase.get<AppLoad>(this, 'appLoad') as AppLoad?;
  @override
  set appLoad(covariant AppLoad? value) =>
      RealmObjectBase.set(this, 'appLoad', value);

  @override
  Stream<RealmObjectChanges<AppLog>> get changes =>
      RealmObjectBase.getChanges<AppLog>(this);

  @override
  Stream<RealmObjectChanges<AppLog>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AppLog>(this, keyPaths);

  @override
  AppLog freeze() => RealmObjectBase.freezeObject<AppLog>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'level': level.toEJson(),
      'message': message.toEJson(),
      'time': time.toEJson(),
      'isSynced': isSynced.toEJson(),
      'appLoad': appLoad.toEJson(),
    };
  }

  static EJsonValue _toEJson(AppLog value) => value.toEJson();
  static AppLog _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'level': EJsonValue level,
        'message': EJsonValue message,
        'time': EJsonValue time,
        'isSynced': EJsonValue isSynced,
        'appLoad': EJsonValue appLoad,
      } =>
        AppLog(
          fromEJson(id),
          fromEJson(level),
          fromEJson(message),
          fromEJson(time),
          fromEJson(isSynced),
          appLoad: fromEJson(appLoad),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AppLog._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, AppLog, 'AppLog', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('level', RealmPropertyType.string),
      SchemaProperty('message', RealmPropertyType.string),
      SchemaProperty('time', RealmPropertyType.timestamp),
      SchemaProperty('isSynced', RealmPropertyType.bool),
      SchemaProperty('appLoad', RealmPropertyType.object,
          optional: true, linkTarget: 'AppLoad'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class AppSentryId extends _AppSentryId
    with RealmEntity, RealmObjectBase, RealmObject {
  AppSentryId(
    Uuid id,
    String sentryId,
    String title,
    DateTime time,
    bool isSynced, {
    AppLoad? appLoad,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'sentryId', sentryId);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'appLoad', appLoad);
    RealmObjectBase.set(this, 'time', time);
    RealmObjectBase.set(this, 'isSynced', isSynced);
  }

  AppSentryId._();

  @override
  Uuid get id => RealmObjectBase.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get sentryId =>
      RealmObjectBase.get<String>(this, 'sentryId') as String;
  @override
  set sentryId(String value) => RealmObjectBase.set(this, 'sentryId', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  AppLoad? get appLoad =>
      RealmObjectBase.get<AppLoad>(this, 'appLoad') as AppLoad?;
  @override
  set appLoad(covariant AppLoad? value) =>
      RealmObjectBase.set(this, 'appLoad', value);

  @override
  DateTime get time => RealmObjectBase.get<DateTime>(this, 'time') as DateTime;
  @override
  set time(DateTime value) => RealmObjectBase.set(this, 'time', value);

  @override
  bool get isSynced => RealmObjectBase.get<bool>(this, 'isSynced') as bool;
  @override
  set isSynced(bool value) => RealmObjectBase.set(this, 'isSynced', value);

  @override
  Stream<RealmObjectChanges<AppSentryId>> get changes =>
      RealmObjectBase.getChanges<AppSentryId>(this);

  @override
  Stream<RealmObjectChanges<AppSentryId>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AppSentryId>(this, keyPaths);

  @override
  AppSentryId freeze() => RealmObjectBase.freezeObject<AppSentryId>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'sentryId': sentryId.toEJson(),
      'title': title.toEJson(),
      'appLoad': appLoad.toEJson(),
      'time': time.toEJson(),
      'isSynced': isSynced.toEJson(),
    };
  }

  static EJsonValue _toEJson(AppSentryId value) => value.toEJson();
  static AppSentryId _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'sentryId': EJsonValue sentryId,
        'title': EJsonValue title,
        'appLoad': EJsonValue appLoad,
        'time': EJsonValue time,
        'isSynced': EJsonValue isSynced,
      } =>
        AppSentryId(
          fromEJson(id),
          fromEJson(sentryId),
          fromEJson(title),
          fromEJson(time),
          fromEJson(isSynced),
          appLoad: fromEJson(appLoad),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AppSentryId._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, AppSentryId, 'AppSentryId', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('sentryId', RealmPropertyType.string),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('appLoad', RealmPropertyType.object,
          optional: true, linkTarget: 'AppLoad'),
      SchemaProperty('time', RealmPropertyType.timestamp),
      SchemaProperty('isSynced', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class AppUserId extends _AppUserId
    with RealmEntity, RealmObjectBase, RealmObject {
  AppUserId(
    Uuid id,
    String userId,
    DateTime time,
    bool isSynced, {
    AppLoad? appLoad,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'appLoad', appLoad);
    RealmObjectBase.set(this, 'time', time);
    RealmObjectBase.set(this, 'isSynced', isSynced);
  }

  AppUserId._();

  @override
  Uuid get id => RealmObjectBase.get<Uuid>(this, 'id') as Uuid;
  @override
  set id(Uuid value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

  @override
  AppLoad? get appLoad =>
      RealmObjectBase.get<AppLoad>(this, 'appLoad') as AppLoad?;
  @override
  set appLoad(covariant AppLoad? value) =>
      RealmObjectBase.set(this, 'appLoad', value);

  @override
  DateTime get time => RealmObjectBase.get<DateTime>(this, 'time') as DateTime;
  @override
  set time(DateTime value) => RealmObjectBase.set(this, 'time', value);

  @override
  bool get isSynced => RealmObjectBase.get<bool>(this, 'isSynced') as bool;
  @override
  set isSynced(bool value) => RealmObjectBase.set(this, 'isSynced', value);

  @override
  Stream<RealmObjectChanges<AppUserId>> get changes =>
      RealmObjectBase.getChanges<AppUserId>(this);

  @override
  Stream<RealmObjectChanges<AppUserId>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<AppUserId>(this, keyPaths);

  @override
  AppUserId freeze() => RealmObjectBase.freezeObject<AppUserId>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'userId': userId.toEJson(),
      'appLoad': appLoad.toEJson(),
      'time': time.toEJson(),
      'isSynced': isSynced.toEJson(),
    };
  }

  static EJsonValue _toEJson(AppUserId value) => value.toEJson();
  static AppUserId _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'userId': EJsonValue userId,
        'appLoad': EJsonValue appLoad,
        'time': EJsonValue time,
        'isSynced': EJsonValue isSynced,
      } =>
        AppUserId(
          fromEJson(id),
          fromEJson(userId),
          fromEJson(time),
          fromEJson(isSynced),
          appLoad: fromEJson(appLoad),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(AppUserId._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, AppUserId, 'AppUserId', [
      SchemaProperty('id', RealmPropertyType.uuid, primaryKey: true),
      SchemaProperty('userId', RealmPropertyType.string),
      SchemaProperty('appLoad', RealmPropertyType.object,
          optional: true, linkTarget: 'AppLoad'),
      SchemaProperty('time', RealmPropertyType.timestamp),
      SchemaProperty('isSynced', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
