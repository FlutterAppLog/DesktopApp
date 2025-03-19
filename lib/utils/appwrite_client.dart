import 'dart:io';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' hide File;
import 'package:flutter_app_log_desktop_app/commons/functions.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AppwriteClient extends GetxService {
  late Client client;
  final String databaseId = '677f63ac003be28fb635';
  final String uploadConfigTableId = '67885eda0039ba8da33e';
  final String logTableId = '6784aec8003d415d53d7';
  final String sentryTableId = '6784a4960004fd640ddf';
  final String userTableId = '677f71c9000566bbcf38';
  final String appLoadTableId = '677f63b900033b03d59f';
  final String storageId = '6787201a00376ab5d134';

  @override
  void onInit() {
    super.onInit();

    client = Client(endPoint: 'https://appwrite.winnermedical.com/v1')
      ..setProject('677f626b0012252b422e')
      ..setSelfSigned(status: false);
  }

  Future<Session> auth(String email, String password) {
    return Account(client)
        .createEmailPasswordSession(
      email: email,
      password: password,
    )
        .catchError((e) {
      showToast(e.toString());
      throw e;
    });
  }

  Future<bool> checkNeedLogin() async {
    return Account(client).getSession(sessionId: 'current').then((session) {
      final expire = DateTime.parse(session.expire);
      final now = DateTime.now();
      return expire.millisecondsSinceEpoch <= now.millisecondsSinceEpoch;
    }).catchError((e) {
      return true;
    });
  }

  /// 根据deviceId查询APP启动数据
  Future<List<Document>> queryAppLoads(String deviceId) async {
    return Databases(client)
        .listDocuments(
            databaseId: databaseId,
            collectionId: appLoadTableId,
            queries: [
              Query.equal('deviceId', deviceId),
            ])
        .then((e) => e.documents)
        .catchError((e) {
          showToast(e.toString());
          return <Document>[];
        });
  }

  /// 根据用户ID查询App启动
  Future<List<Document>> queryUser(String userId) async {
    return Databases(client)
        .listDocuments(
            databaseId: databaseId,
            collectionId: userTableId,
            queries: [
              Query.equal('userId', userId),
            ])
        .then((e) => _getAppLoadDocuments(e.documents))
        .catchError((e) {
          showToast(e.toString());
          return <Document>[];
        });
  }

  /// 通过AppLoadId查询AppLoad表
  Future<Document?> queryAppLoadById(String appLoadId) async {
    return Databases(client)
        .getDocument(
          databaseId: databaseId,
          collectionId: appLoadTableId,
          documentId: appLoadId,
        )
        .then<Document?>((e) => e)
        .catchError((e) {
      showToast(e.toString());
      return null;
    });
  }

  /// 根据SentryId 查询APP启动
  Future<List<Document>> querySentry(String sentryId) async {
    return Databases(client)
        .listDocuments(
            databaseId: databaseId,
            collectionId: sentryTableId,
            queries: [
              Query.equal('sentryId', sentryId),
            ])
        .then((e) => _getAppLoadDocuments(e.documents))
        .catchError((e) => <Document>[]);
  }

  /// 根据Sentry title查询APP启动
  Future<List<Document>> querySentryByTitle(String title) async {
    return Databases(client)
        .listDocuments(
            databaseId: databaseId,
            collectionId: sentryTableId,
            queries: [
              Query.equal('title', title),
            ])
        .then((e) => _getAppLoadDocuments(e.documents))
        .catchError((e) => <Document>[]);
  }

  Future<List<Document>> _getAppLoadDocuments(List<Document> documents) async {
    final List<Document> result = [];
    for (var e in documents) {
      final appLoadId = e.data['appLoadId'];
      final appLoad = await queryAppLoadById(appLoadId);
      if (appLoad != null) {
        result.add(appLoad);
      }
    }
    return result;
  }

  /// 根据启动ID查询用户ID表
  Future<List<Document>> queryUserByAppLoad(String appLoadId) async {
    return Databases(client)
        .listDocuments(
            databaseId: databaseId,
            collectionId: userTableId,
            queries: [
              Query.equal('appLoadId', appLoadId),
            ])
        .then((e) => e.documents)
        .catchError((e) {
          return <Document>[];
        });
  }

  /// 根据启动ID查询日志表
  Future<List<Document>> queryLogsByAppLoad(String appLoadId) async {
    return Databases(client)
        .listDocuments(
            databaseId: databaseId,
            collectionId: logTableId,
            queries: [
              Query.equal('appLoadId', appLoadId),
            ])
        .then((e) => e.documents)
        .catchError((e) => <Document>[]);
  }

  /// 根据启动ID查询Sentry表
  Future<List<Document>> querySentryByAppLoad(String appLoadId) async {
    return Databases(client)
        .listDocuments(
            databaseId: databaseId,
            collectionId: sentryTableId,
            queries: [
              Query.equal('appLoadId', appLoadId),
            ])
        .then((e) => e.documents)
        .catchError((e) => <Document>[]);
  }

  /// 下载日志文件
  Future<Uint8List> downloadFile(String fileId) async {
    final fileInfo = await Storage(client).getFile(
      bucketId: storageId,
      fileId: fileId,
    );
    if (fileInfo.mimeType != 'application/zip') {
      throw Exception('请使用v0.1.x版本打开当前的日志！');
    }
    return await Storage(client).getFileDownload(
      bucketId: storageId,
      fileId: fileId,
    );
  }

  Future<void> logout() async {
    return Account(client).deleteSession(sessionId: 'current');
  }
}
