import 'package:get/get_connect/http/src/response/response.dart';
import 'package:scan_sa_user/app/presentation/auth_module/models/signup_body_model.dart';
import 'package:scan_sa_user/app/presentation/auth_module/models/verification_data_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/common/models/social_log_in_body.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class AuthRepositoryInterface extends RepositoryInterface<dynamic> {
  bool isSharedPrefNotificationActive();
  Future<Response<dynamic>> registration(SignUpBodyModel signUpBody);
  //Future<Response<dynamic>> login({String? phone, String? password});
  Future<Response<dynamic>> login({
    required String emailOrPhone,
    required String password,
    required String loginType,
    required String fieldType,
  });
  Future<Response<dynamic>> otpLogin({
    required String phone,
    required String otp,
    required String loginType,
    required String verified,
  });
  Future<Response<dynamic>> updatePersonalInfo({
    required String name,
    required String? phone,
    required String loginType,
    required String? email,
    required String? referCode,
  });
  //Future<bool> saveUserToken(String token);
  Future<bool> saveUserToken(String token, {bool alreadyInApp = false});
  Future<Response<dynamic>> updateToken({String notificationDeviceToken = ''});
  Future<bool> saveSharedPrefGuestId(String id);
  String getSharedPrefGuestId();
  Future<bool> clearSharedPrefGuestId();
  bool isGuestLoggedIn();
  Future<bool> clearSharedData({bool removeToken = true});
  Future<ResponseModel> guestLogin();
  //Future<Response<dynamic>> loginWithSocialMedia(SocialLogInBody socialLogInBody, int timeout);
  Future<Response<dynamic>> loginWithSocialMedia(
    SocialLogInBody socialLogInModel,
  );
  bool isLoggedIn();
  Future<bool> clearSharedAddress();
  Future<void> saveUserNumberAndPassword(
    String number,
    String password,
    String countryCode,
  );
  String getUserNumber();
  String getUserCountryCode();
  String getUserPassword();
  Future<bool> clearUserNumberAndPassword();
  String getUserToken();
  Future<Response<dynamic>> updateZone();
  Future<bool> saveGuestContactNumber(String number);
  String getGuestContactNumber();

  Future<bool> saveDmTipIndex(String index);
  String getDmTipIndex();
  Future<bool> saveEarningPoint(String point);
  String getEarningPint();
  Future<void> setNotificationActive(bool isActive);
  Future<String?> saveDeviceToken();

  /// verification repo
  Future<ResponseModel> forgetPassword({String? phone, String? email});
  Future<ResponseModel> resetPassword({
    String? resetToken,
    String? phone,
    String? email,
    required String password,
    required String confirmPassword,
  });
  Future<Response<dynamic>> verifyPhone(VerificationDataModel data);
  Future<ResponseModel> verifyToken({
    String? phone,
    String? email,
    required String token,
  });
  Future<ResponseModel> verifyFirebaseOtp({
    required String phoneNumber,
    required String session,
    required String otp,
    required String loginType,
  });
  Future<ResponseModel> verifyForgetPassFirebaseOtp({
    required String phoneNumber,
    required String session,
    required String otp,
  });
}
