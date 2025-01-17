import 'dart:math';

import 'package:flutter_app_log_desktop_app/app_log/app_log.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

class RealmUtils extends GetxService {
  /// 已经初始化的Realm对象
  final Map<String, Realm> _realms = {};

  Realm getRealm(String path, String password, {bool closeOld = false}) {
    Realm? realm = _realms[path];
    if (realm != null) {
      if (!closeOld) {
        return realm;
      }
      realm.close();
      _realms.remove(path);
    }

    List<int> byteList = [];
    for (int i = 0; i < password.length; i += 2) {
      String byteHex = password.substring(i, i + 2);
      int byteValue = int.parse(byteHex, radix: 16);
      byteList.add(byteValue);
    }

    /// 字符串转64位整数

    Configuration config = Configuration.local(
      [
        AppLoad.schema,
        AppLog.schema,
        AppSentryId.schema,
        AppUserId.schema,
      ],
      path: path,
      isReadOnly: true,
      encryptionKey: byteList,
    );
    realm = Realm(config);
    _realms[path] = realm;
    return realm;
  }
}

extension RealmUtilsExtension on Realm {
  /// 查询对应表的所有数据按照时间倒序
  List<T> queryOffsetCount<T extends RealmObject>(int page, int pageCount) {
    final results = query<T>('TRUEPREDICATE SORT(time DESC)');
    List<T> objects = [];
    int offset = max(page - 1, 0) * pageCount;
    for (var i = 0; i < results.length; i++) {
      if (i >= offset && i < offset + pageCount) {
        objects.add(results[i]);
      }
    }
    return objects;
  }

  /// 根据APP启动进行查询
  List<T> queryByAppLoadId<T extends RealmObject>(AppLoad appLoad) {
    final results = query<T>('appLoad.id == \$0 SORT(time ASC)', [appLoad.id]);
    List<T> objects = [];
    for (var i = 0; i < results.length; i++) {
      objects.add(results[i]);
    }
    return objects;
  }
}
