import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/helper/db_helper.dart';
import 'package:scan_sa_user/helper/local/cache_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DataSourceEnum { client, local }

class LocalClient {
  static Future<String?> organize(
    DataSourceEnum source,
    String cacheId,
    String? responseBody,
    Map<String, String>? header,
  ) async {
    final sharedPreferences = Get.find<SharedPreferences>();
    switch (source) {
      case DataSourceEnum.client:
        try {
          //debugPrint('==========cache data : endpoint banner=${cacheId}, '
          //     'header= ${header.toString()}, '
          //     'response= ${responseBody}');

          if (GetPlatform.isWeb) {
            await sharedPreferences.setString(cacheId, responseBody ?? '');
          } else {
            await DbHelper.insertOrUpdate(
              id: cacheId,
              data: CacheResponseCompanion(
                endPoint: drift.Value(cacheId),
                header: drift.Value(header.toString()),
                response: drift.Value(responseBody ?? ''),
              ),
            );
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('=====error occure in repo api bannaer add: $e');
          }
        }
      case DataSourceEnum.local:
        try {
          if (GetPlatform.isWeb) {
            final cacheData = sharedPreferences.getString(cacheId);
            return cacheData;
          } else {
            final cacheResponseData = await database.getCacheResponseById(
              cacheId,
            );
            return cacheResponseData?.response;
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('=====error occur in repo local banner: $e');
          }
        }
    }
    return null;
  }
}
