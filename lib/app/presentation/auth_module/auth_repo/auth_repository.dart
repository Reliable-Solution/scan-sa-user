import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_repo/auth_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/auth_module/models/auth_response_model.dart';
import 'package:scan_sa_user/app/presentation/auth_module/models/signup_body_model.dart';
import 'package:scan_sa_user/app/presentation/auth_module/models/verification_data_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/common/models/social_log_in_body.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements AuthRepositoryInterface {
  AuthRepository({required this.sharedPreferences, required this.apiClient});
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  @override
  bool isSharedPrefNotificationActive() {
    return sharedPreferences.getBool(AppConstants.notification) ?? true;
  }

  /*  @override
  Future<ResponseModel> registration(SignUpBodyModel signUpBody) async {
    Response response = await apiClient.postData(AppConstants.registerUri, signUpBody.toJson(), handleError: false);
    if (response.statusCode == 200) {
      return ResponseModel(true, response.body["token"]);
    } else {
      return ResponseModel(false, response.statusText);
    }
  }*/

  @override
  Future<Response<dynamic>> registration(SignUpBodyModel signUpBody) async {
    return apiClient.postData(
      AppConstants.registerUri,
      signUpBody.toJson(),
      handleError: false,
    );
  }

  /*  @override
  Future<Response> login({String? phone, String? password}) async {
    String guestId = getSharedPrefGuestId();
    String? deviceToken = await saveDeviceToken();
    Map<String, String> data = {
      "phone": phone!,
      "password": password!,
      "cm_firebase_token": deviceToken!,
    };
    if(guestId.isNotEmpty) {
      data.addAll({"guest_id": guestId});
    }
    return await apiClient.postData(AppConstants.loginUri, data, handleError: false);
  }*/

  @override
  Future<Response<dynamic>> login({
    required String emailOrPhone,
    required String password,
    required String loginType,
    required String fieldType,
    bool alreadyInApp = false,
  }) async {
    final guestId = getSharedPrefGuestId();
    final data = <String, String>{
      'email_or_phone': emailOrPhone,
      'password': password,
      'login_type': loginType,
      'field_type': fieldType,
    };
    if (guestId.isNotEmpty) {
      data.addAll({'guest_id': guestId});
    }
    return apiClient.postData(AppConstants.loginUri, data, handleError: false);
  }

  @override
  Future<Response<dynamic>> otpLogin({
    required String phone,
    required String otp,
    required String loginType,
    required String verified,
  }) async {
    final guestId = getSharedPrefGuestId();
    final data = <String, String>{'phone': phone, 'login_type': loginType};
    if (guestId.isNotEmpty) {
      data.addAll({'guest_id': guestId});
    }
    if (otp.isNotEmpty) {
      data.addAll({'otp': otp});
    }
    if (verified.isNotEmpty) {
      data.addAll({'verified': verified});
    }
    return apiClient.postData(AppConstants.loginUri, data, handleError: false);
  }

  @override
  Future<ResponseModel> guestLogin() async {
    ResponseModel responseModel;
    final deviceToken = await saveDeviceToken();
    final response = await apiClient.postData(AppConstants.guestLoginUri, {
      'fcm_token': deviceToken,
    });
    if (response.statusCode == 200) {
      await saveSharedPrefGuestId(response.body['guest_id'].toString());
      responseModel = ResponseModel(true, '${response.body['guest_id']}');
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  Future<Response<dynamic>> updatePersonalInfo({
    required String name,
    required String? phone,
    required String loginType,
    required String? email,
    required String? referCode,
  }) async {
    final data = <String, String>{
      'login_type': loginType,
      'name': name,
      'ref_code': referCode ?? '',
    };
    if (phone != null && phone.isNotEmpty) {
      data.addAll({'phone': phone});
    }
    if (email != null && email.isNotEmpty) {
      data.addAll({'email': email});
    }
    return apiClient.postData(
      AppConstants.personalInformationUri,
      data,
      handleError: false,
    );
  }

  /*  @override
  Future<Response> loginWithSocialMedia(SocialLogInBody socialLogInBody, int timeout) async {
    return await apiClient.postData(AppConstants.socialLoginUri, socialLogInBody.toJson(), timeout: timeout);
  }*/

  @override
  Future<Response<dynamic>> loginWithSocialMedia(
    SocialLogInBody socialLogInModel,
  ) async {
    final guestId = getSharedPrefGuestId();
    final data = socialLogInModel.toJson();
    if (guestId.isNotEmpty) {
      data.addAll({'guest_id': guestId});
    }
    return apiClient.postData(AppConstants.loginUri, data);
  }

  /*  @override
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    if(sharedPreferences.getString(AppConstants.userAddress) != null){
      AddressModel? addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
      apiClient.updateHeader(
        token, addressModel.zoneIds, addressModel.areaIds, sharedPreferences.getString(AppConstants.languageCode),
         ModuleHelper.getModule()?.id, addressModel.latitude, addressModel.longitude,
      );
    }else{
      apiClient.updateHeader(
          token, null, null, sharedPreferences.getString(AppConstants.languageCode),
          ModuleHelper.getModule()?.id,
          null, null
      );
    }
    return await sharedPreferences.setString(AppConstants.token, token);
  }*/

  @override
  Future<bool> saveUserToken(String token, {bool alreadyInApp = false}) async {
    apiClient.token = token;
    if (alreadyInApp &&
        sharedPreferences.getString(AppConstants.userAddress) != null) {
      final addressModel = AddressModel.fromJson(
        jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!)
            as Map<String, dynamic>,
      );
      apiClient.updateHeader(
        token: token,
        zoneIDs: addressModel.zoneIds,
        operationIds: addressModel.areaIds,
        languageCode: sharedPreferences.getString(AppConstants.languageCode),
        latitude: addressModel.latitude,
        longitude: addressModel.longitude,
      );
    } else {
      apiClient.updateHeader(
        token: token,
        languageCode: sharedPreferences.getString(AppConstants.languageCode),
      );
    }
    return sharedPreferences.setString(AppConstants.token, token);
  }

  @override
  Future<Response<dynamic>> updateToken({
    String notificationDeviceToken = '',
  }) async {
    String? deviceToken;
    if (notificationDeviceToken.isEmpty) {
      if (GetPlatform.isIOS && !GetPlatform.isWeb) {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
              alert: true,
              badge: true,
              sound: true,
            );
        final settings = await FirebaseMessaging.instance.requestPermission();
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          deviceToken = await saveDeviceToken();
        }
      } else {
        deviceToken = await saveDeviceToken();
      }
      if (!GetPlatform.isWeb) {
        await FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
        await FirebaseMessaging.instance.subscribeToTopic(
          'zone_${AddressHelper.getUserAddressFromSharedPref()?.zoneId}_customer',
        );
      }
    }
    return apiClient.postData(AppConstants.tokenUri, {
      '_method': 'put',
      'cm_firebase_token': notificationDeviceToken.isNotEmpty
          ? notificationDeviceToken
          : deviceToken,
    }, handleError: false);
  }

  @override
  Future<String?> saveDeviceToken() async {
    String? deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (_) {}
    }
    if (deviceToken != null) {
      if (kDebugMode) {
        debugPrint('--------Device Token---------- $deviceToken');
      }
    }
    return deviceToken;
  }

  @override
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  @override
  Future<bool> saveSharedPrefGuestId(String id) async {
    return sharedPreferences.setString(AppConstants.guestId, id);
  }

  @override
  String getSharedPrefGuestId() {
    return sharedPreferences.getString(AppConstants.guestId) ?? '';
  }

  @override
  Future<bool> clearSharedPrefGuestId() async {
    return sharedPreferences.remove(AppConstants.guestId);
  }

  @override
  bool isGuestLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.guestId);
  }

  @override
  Future<bool> clearSharedAddress() async {
    await sharedPreferences.remove(AppConstants.userAddress);
    return true;
  }

  @override
  Future<bool> clearSharedData({bool removeToken = true}) async {
    if (!GetPlatform.isWeb) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.topic);
      await FirebaseMessaging.instance.unsubscribeFromTopic(
        'zone_${AddressHelper.getUserAddressFromSharedPref()!.zoneId}_customer',
      );
      if (removeToken) {
        await apiClient.postData(AppConstants.tokenUri, {
          '_method': 'put',
          'cm_firebase_token': '@',
        }, handleError: false);
      }
    }
    await sharedPreferences.remove(AppConstants.token);
    await sharedPreferences.remove(AppConstants.guestId);
    await sharedPreferences.setStringList(AppConstants.cartList, []);
    // sharedPreferences.remove(AppConstants.userAddress);
    apiClient.token = null;
    // apiClient.updateHeader(null, null, null, null, null, null, null);
    await guestLogin();
    if (sharedPreferences.getString(AppConstants.userAddress) != null) {
      final addressModel = AddressModel.fromJson(
        jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!)
            as Map<String, dynamic>,
      );
      apiClient.updateHeader(
        zoneIDs: addressModel.zoneIds,
        languageCode: sharedPreferences.getString(AppConstants.languageCode),
        latitude: addressModel.latitude,
        longitude: addressModel.longitude,
      );
    }
    return true;
  }

  @override
  Future<void> saveUserNumberAndPassword(
    String number,
    String password,
    String countryCode,
  ) async {
    try {
      await sharedPreferences.setString(AppConstants.userPassword, password);
      await sharedPreferences.setString(AppConstants.userNumber, number);
      await sharedPreferences.setString(
        AppConstants.userCountryCode,
        countryCode,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.userNumber) ?? '';
  }

  @override
  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.userCountryCode) ?? '';
  }

  @override
  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.userPassword) ?? '';
  }

  @override
  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.userPassword);
    await sharedPreferences.remove(AppConstants.userCountryCode);
    return sharedPreferences.remove(AppConstants.userNumber);
  }

  @override
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? '';
  }

  @override
  Future<Response<dynamic>> updateZone() async {
    return apiClient.getData(AppConstants.updateZoneUri);
  }

  @override
  Future<bool> saveGuestContactNumber(String number) async {
    return sharedPreferences.setString(AppConstants.guestNumber, number);
  }

  @override
  String getGuestContactNumber() {
    return sharedPreferences.getString(AppConstants.guestNumber) ?? '';
  }

  @override
  Future<bool> saveDmTipIndex(String index) async {
    return sharedPreferences.setString(AppConstants.dmTipIndex, index);
  }

  @override
  String getDmTipIndex() {
    return sharedPreferences.getString(AppConstants.dmTipIndex) ?? '';
  }

  @override
  Future<bool> saveEarningPoint(String point) async {
    return sharedPreferences.setString(AppConstants.earnPoint, point);
  }

  @override
  String getEarningPint() {
    return sharedPreferences.getString(AppConstants.earnPoint) ?? '';
  }

  @override
  Future<void> setNotificationActive(bool isActive) async {
    if (isActive) {
      await updateToken();
    } else {
      if (!GetPlatform.isWeb) {
        await updateToken(notificationDeviceToken: '@');
        await FirebaseMessaging.instance.unsubscribeFromTopic(
          AppConstants.topic,
        );
        if (isLoggedIn()) {
          await FirebaseMessaging.instance.unsubscribeFromTopic(
            'zone_${AddressHelper.getUserAddressFromSharedPref()!.zoneId}_customer',
          );
        }
      }
    }
    await sharedPreferences.setBool(AppConstants.notification, isActive);
  }

  @override
  Future<ResponseModel> forgetPassword({String? phone, String? email}) async {
    final deviceToken = await Get.find<GlobalController>().saveDeviceToken();
    final response = await apiClient.postData(AppConstants.forgetPasswordUri, {
      'phone': phone,
      'email': email,
      'verification_method': phone != null && phone.isNotEmpty
          ? 'phone'
          : 'email',
      'cm_firebase_token': deviceToken,
    }, handleError: false);
    if (response.statusCode == 200) {
      return ResponseModel(true, response.body['message'] as String?);
    } else {
      return ResponseModel(false, response.statusText);
    }
  }

  @override
  Future<ResponseModel> resetPassword({
    String? resetToken,
    String? phone,
    String? email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await apiClient.postData(AppConstants.resetPasswordUri, {
      '_method': 'put',
      'reset_token': resetToken,
      'phone': phone != null && phone != 'null' && phone.isNotEmpty
          ? phone
          : '',
      'email': email != null && email != 'null' && email.isNotEmpty
          ? email
          : '',
      'verification_method':
          phone != null && phone != 'null' && phone.isNotEmpty
          ? 'phone'
          : 'email',
      'password': password,
      'confirm_password': confirmPassword,
    }, handleError: false);
    if (response.statusCode == 200) {
      return ResponseModel(true, response.body['message'] as String?);
    } else {
      return ResponseModel(false, response.statusText);
    }
  }

  @override
  Future<Response<dynamic>> verifyPhone(VerificationDataModel data) async {
    return apiClient.postData(
      AppConstants.verifyPhoneUri,
      data.toJson(),
      handleError: false,
    );
  }

  @override
  Future<ResponseModel> verifyFirebaseOtp({
    required String phoneNumber,
    required String session,
    required String otp,
    required String loginType,
  }) async {
    final guestId = GlobalHelper.getGuestId();
    final data = <String, dynamic>{
      'session_info': session,
      'phone': phoneNumber,
      'otp': otp,
      'login_type': loginType,
    };
    if (guestId.isNotEmpty) {
      data.addAll({'guest_id': guestId});
    }
    final response = await apiClient.postData(
      AppConstants.firebaseAuthVerify,
      data,
    );
    if (response.statusCode == 200) {
      final authResponse = AuthResponseModel.fromJson(
        response.body as Map<String, dynamic>,
      );
      return ResponseModel(
        true,
        response.body['message'] as String?,
        authResponseModel: authResponse,
      );
    } else {
      return ResponseModel(false, response.statusText);
    }
  }

  @override
  Future<ResponseModel> verifyForgetPassFirebaseOtp({
    required String phoneNumber,
    required String session,
    required String otp,
  }) async {
    final response = await apiClient
        .postData(AppConstants.firebaseResetPassword, {
          'sessionInfo': session,
          'phoneNumber': phoneNumber,
          'code': otp,
          'is_reset_token': 1,
          '_method': 'PUT',
        });
    if (response.statusCode == 200) {
      return ResponseModel(true, response.body['message'] as String?);
    } else {
      return ResponseModel(false, response.statusText);
    }
  }

  @override
  Future<ResponseModel> verifyToken({
    String? phone,
    String? email,
    required String token,
  }) async {
    final response = await apiClient.postData(AppConstants.verifyTokenUri, {
      'phone': phone,
      'email': email,
      'verification_method': phone != null && phone.isNotEmpty
          ? 'phone'
          : 'email',
      'reset_token': token,
    });
    if (response.statusCode == 200) {
      return ResponseModel(true, response.body['message'] as String?);
    } else {
      return ResponseModel(false, response.statusText);
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
  Future<void> get(String? id) {
    throw UnimplementedError();
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
