import 'package:scan_sa_user/app/presentation/auth_module/models/signup_body_model.dart';
import 'package:scan_sa_user/app/presentation/auth_module/models/verification_data_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/common/models/social_log_in_body.dart';

abstract class AuthServiceInterface {
  bool isSharedPrefNotificationActive();
  //Future<ResponseModel> registration(SignUpBodyModel signUpBody, bool isCustomerVerificationOn);
  Future<ResponseModel> registration(SignUpBodyModel signUpBody);
  //Future<ResponseModel> login({String? phone, String? password, required bool isCustomerVerificationOn});
  Future<ResponseModel> login({
    required String emailOrPhone,
    required String password,
    required String loginType,
    required String fieldType,
    bool alreadyInApp = false,
  });
  Future<ResponseModel> otpLogin({
    required String phone,
    required String otp,
    required String loginType,
    required String verified,
    bool alreadyInApp = false,
  });
  Future<ResponseModel> updatePersonalInfo({
    required String name,
    required String? phone,
    required String loginType,
    required String? email,
    required String? referCode,
    bool alreadyInApp = false,
  });
  Future<ResponseModel> guestLogin();
  //Future<bool> loginWithSocialMedia(SocialLogInBody socialLogInBody, int timeout, bool isCustomerVerificationOn);
  Future<ResponseModel> loginWithSocialMedia(
    SocialLogInBody socialLogInModel, {
    bool isCustomerVerificationOn = false,
  });
  Future<void> updateToken();
  bool isLoggedIn();
  bool isGuestLoggedIn();
  String getSharedPrefGuestId();
  Future<bool> clearSharedData({bool removeToken = true});
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
  Future<dynamic> updateZone();
  Future<bool> saveGuestContactNumber(String number);
  String getGuestContactNumber();
  Future<bool> saveDmTipIndex(String index);
  String getDmTipIndex();
  Future<bool> saveEarningPoint(String point);
  String getEarningPint();
  Future<void> setNotificationActive(bool isActive);
  Future<String?> saveDeviceToken();

  Future<ResponseModel> forgetPassword({String? phone, String? email});
  Future<ResponseModel> resetPassword({
    String? resetToken,
    String? phone,
    String? email,
    required String password,
    required String confirmPassword,
  });
  Future<ResponseModel> verifyPhone(VerificationDataModel data);
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
    required String? token,
    required bool isSignUpPage,
    required bool isForgetPassPage,
  });
}
