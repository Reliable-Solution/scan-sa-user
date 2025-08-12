import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/userinfo_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/repositories/global_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/splash_screens/domain/models/landing_model.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalRepository implements GlobalRepositoryInterface {
  GlobalRepository({required this.apiClient, required this.sharedPreferences});
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  @override
  Future<Response<dynamic>> getConfigData({
    required DataSourceEnum source,
  }) async {
    var responseData = Response(
      statusCode: 00,
      body: ApiClient.noInternetMessage,
    );
    const cacheId = AppConstants.configUri;

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(AppConstants.configUri);
        if (response.statusCode == 200) {
          responseData = Response(
            statusCode: 200,
            body: jsonEncode(response.body),
          );
          await LocalClient.organize(
            source,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          source,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          responseData = Response(statusCode: 200, body: cacheResponseData);
        }
    }
    return responseData;
  }

  @override
  Future<LandingModel?> getLandingPageData({
    required DataSourceEnum source,
  }) async {
    LandingModel? landingModel;
    const cacheId = AppConstants.landingPageUri;

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(AppConstants.landingPageUri);
        if (response.statusCode == 200) {
          landingModel = LandingModel.fromJson(
            response.body as Map<String, dynamic>,
          );
          await LocalClient.organize(
            source,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          source,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          landingModel = LandingModel.fromJson(
            jsonDecode(cacheResponseData) as Map<String, dynamic>,
          );
        }
    }
    return landingModel;
  }

  @override
  Future<ModuleModel?> initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.theme)) {
      await sharedPreferences.setBool(AppConstants.theme, false);
    }
    if (!sharedPreferences.containsKey(AppConstants.countryCode)) {
      await sharedPreferences.setString(
        AppConstants.countryCode,
        AppConstants.languages[0].countryCode!,
      );
    }
    if (!sharedPreferences.containsKey(AppConstants.languageCode)) {
      await sharedPreferences.setString(
        AppConstants.languageCode,
        AppConstants.languages[0].languageCode!,
      );
    }
    if (!sharedPreferences.containsKey(AppConstants.cartList)) {
      await sharedPreferences.setStringList(AppConstants.cartList, []);
    }
    if (!sharedPreferences.containsKey(AppConstants.searchHistory)) {
      await sharedPreferences.setStringList(AppConstants.searchHistory, []);
    }
    if (!sharedPreferences.containsKey(AppConstants.notification)) {
      await sharedPreferences.setBool(AppConstants.notification, true);
    }
    if (!sharedPreferences.containsKey(AppConstants.intro)) {
      await sharedPreferences.setBool(AppConstants.intro, true);
    }
    if (!sharedPreferences.containsKey(AppConstants.notificationCount)) {
      await sharedPreferences.setInt(AppConstants.notificationCount, 0);
    }
    if (!sharedPreferences.containsKey(AppConstants.suggestedLocation)) {
      await sharedPreferences.setBool(AppConstants.suggestedLocation, false);
    }
    if (sharedPreferences.containsKey(AppConstants.referBottomSheet)) {
      await sharedPreferences.setBool(AppConstants.referBottomSheet, true);
    }

    ModuleModel? module;
    if (sharedPreferences.containsKey(AppConstants.moduleId)) {
      try {
        module = ModuleModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.moduleId)!)
              as Map<String, dynamic>,
        );
      } catch (e) {
        debugPrint('Did not get shared Preferences module. Note: $e');
      }
    }
    return module;
  }

  @override
  void disableIntro() {
    sharedPreferences.setBool(AppConstants.intro, false);
  }

  @override
  bool? showIntro() {
    return sharedPreferences.getBool(AppConstants.intro);
  }

  @override
  Future<void> setStoreCategory(int storeCategoryID) async {
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(
        jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!)
            as Map<String, dynamic>,
      );
    } catch (e) {
      debugPrint(
        'Did not get shared Preferences address setStoreCategory. Note: $e',
      );
    }
    apiClient.updateHeader(
      token: sharedPreferences.getString(AppConstants.token),
      zoneIDs: addressModel?.zoneIds,
      operationIds: addressModel?.areaIds,
      languageCode: sharedPreferences.getString(AppConstants.languageCode),
      moduleID: storeCategoryID,
      latitude: addressModel?.latitude,
      longitude: addressModel?.longitude,
    );
  }

  @override
  Future<List<ModuleModel>?> getModules({
    Map<String, String>? headers,
    required DataSourceEnum source,
  }) async {
    List<ModuleModel>? moduleList;
    const cacheId = AppConstants.moduleUri;

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(
          AppConstants.moduleUri,
          headers: headers,
        );
        if (response.statusCode == 200) {
          moduleList = [];
          response.body.forEach(
            (storeCategory) => moduleList!.add(
              ModuleModel.fromJson(storeCategory as Map<String, dynamic>),
            ),
          );
          debugPrint('object Module ${moduleList.length}');
          await LocalClient.organize(
            source,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          source,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          moduleList = [];
          jsonDecode(cacheResponseData).forEach(
            (storeCategory) => moduleList!.add(
              ModuleModel.fromJson(storeCategory as Map<String, dynamic>),
            ),
          );
        }
    }

    return moduleList;
  }

  @override
  Future<void> setModule(ModuleModel? module) async {
    AddressModel? addressModel;
    // try {
    ('===>>> ${sharedPreferences.getString(AppConstants.userAddress)}').print;
    addressModel = AddressModel.fromJson(
      jsonDecode(sharedPreferences.getString(AppConstants.userAddress) ?? '{}')
          as Map<String, dynamic>,
    );
    // } catch (e) {
    //   debugPrint('Did not get shared Preferences address setModule . Note: $e');
    // }
    apiClient.updateHeader(
      token: sharedPreferences.getString(AppConstants.token),
      zoneIDs: addressModel.zoneIds,
      operationIds: addressModel.areaIds,
      languageCode: sharedPreferences.getString(AppConstants.languageCode),
      moduleID: module?.id,
      latitude: addressModel.latitude,
      longitude: addressModel.longitude,
    );
    if (module != null) {
      await sharedPreferences.setString(
        AppConstants.moduleId,
        jsonEncode(module.toJson()),
      );
    } else {
      await sharedPreferences.remove(AppConstants.moduleId);
    }
  }

  @override
  Future<ModuleModel?> setCacheModule(ModuleModel? module) async {
    if (module != null) {
      await sharedPreferences.setString(
        AppConstants.cacheModuleId,
        jsonEncode(module.toJson()),
      );
      return module;
    } else {
      await sharedPreferences.remove(AppConstants.cacheModuleId);
      return null;
    }
  }

  @override
  ModuleModel? getCacheModule() {
    ModuleModel? module;
    if (sharedPreferences.containsKey(AppConstants.cacheModuleId)) {
      try {
        module = ModuleModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.cacheModuleId)!)
              as Map<String, dynamic>,
        );
      } catch (e) {
        debugPrint('Did not get shared Preferences cache module. Note: $e');
      }
    }
    return module;
  }

  @override
  ModuleModel? getModule() {
    ModuleModel? module;
    if (sharedPreferences.containsKey(AppConstants.moduleId)) {
      try {
        module = ModuleModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.moduleId)!)
              as Map<String, dynamic>,
        );
      } catch (e) {
        debugPrint('Did not get shared Preferences module. Note: $e');
      }
    }
    return module;
  }

  @override
  Future<ResponseModel> subscribeEmail(String email) async {
    ResponseModel responseModel;
    final response = await apiClient.postData(AppConstants.subscriptionUri, {
      'email': email,
    }, handleError: false);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, 'subscribed_successfully'.tr);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  bool getSavedCookiesData() {
    return sharedPreferences.getBool(AppConstants.acceptCookies)!;
  }

  @override
  Future<void> saveCookiesData(bool data) async {
    try {
      await sharedPreferences.setBool(AppConstants.acceptCookies, data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void cookiesStatusChange(String? data) {
    if (data != null) {
      sharedPreferences.setString(AppConstants.cookiesManagement, data);
    }
  }

  @override
  bool getAcceptCookiesStatus(String data) {
    return sharedPreferences.getString(AppConstants.cookiesManagement) !=
            null &&
        sharedPreferences.getString(AppConstants.cookiesManagement) == data;
  }

  @override
  bool getSuggestedLocationStatus() {
    return sharedPreferences.getBool(AppConstants.suggestedLocation)!;
  }

  @override
  Future<void> saveSuggestedLocationStatus(bool data) async {
    try {
      await sharedPreferences.setBool(AppConstants.suggestedLocation, data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool getReferBottomSheetStatus() {
    return sharedPreferences.getBool(AppConstants.referBottomSheet) ?? true;
  }

  @override
  Future<void> saveReferBottomSheetStatus(bool data) async {
    try {
      await sharedPreferences.setBool(AppConstants.referBottomSheet, data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> add(dynamic value) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future<UserInfoModel?> get(String? id) async {
    UserInfoModel? userInfoModel;
    final response = await apiClient.getData(AppConstants.customerInfoUri);
    if (response.statusCode == 200) {
      userInfoModel = UserInfoModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return userInfoModel;
  }

  @override
  Future<void> getList({int? offset}) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
