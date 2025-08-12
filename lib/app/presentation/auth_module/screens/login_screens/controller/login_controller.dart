import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service_interface.dart';
import 'package:scan_sa_user/app/presentation/auth_module/widgets/existing_user_bottom_sheet.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/enums/centralize_login_enum.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/common/models/social_log_in_body.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  LoginController({required this.authServiceInterface}) {
    _notification = authServiceInterface.isSharedPrefNotificationActive();
    emailController.text =
        Get.find<SharedPreferences>().getString('email') ?? '';
    passController.text = Get.find<SharedPreferences>().getString('pass') ?? '';
    isRemember.value = emailController.text.isNotEmpty;
  }

  /// this is authentication service to get all apis
  final AuthServiceInterface authServiceInterface;

  /// variables
  final emailController = TextEditingController();
  final passController = TextEditingController();
  RxBool isRemember = false.obs;
  RxBool obscureText = true.obs;

  final bool _guestLoading = false;
  bool get guestLoading => _guestLoading;

  bool _notification = true;
  bool get notification => _notification;

  /// function is used to change is remember tab
  void toggleRememberMe() => isRemember.value = !isRemember.value;

  /// this function is used to change password visibility
  void toggleObscureText() => obscureText.value = !obscureText.value;

  /// login api
  Future<ResponseModel> login({bool alreadyInApp = false}) async {
    EasyLoading.load();
    final responseModel = await authServiceInterface.login(
      emailOrPhone: emailController.text,
      password: passController.text,
      loginType: 'manual',
      fieldType: 'email',
    );

    _getUserAndCartData(responseModel);
    '==>> responseModel ${responseModel.authResponseModel?.toJson()}'.print;
    // await Get.find<GlobalController>().getUserInfo();
    EasyLoading.dismiss();

    if (!responseModel.isSuccess) {
      showCustomSnackBar(responseModel.message);
    } else {
      await Get.find<SharedPreferences>().setString(
        'email',
        isRemember.value ? emailController.text : '',
      );
      await Get.find<SharedPreferences>().setString(
        'pass',
        isRemember.value ? passController.text : '',
      );
      if (!isRemember.value) {
        emailController.clear();
        passController.clear();
        isRemember = false.obs;
        obscureText = true.obs;
      }
      showCustomSnackBar('loginSuccessfully'.tr, isError: false);
    }

    return responseModel;
  }

  void _getUserAndCartData(ResponseModel responseModel) {
    if (responseModel.isSuccess &&
        responseModel.authResponseModel != null &&
        (responseModel.authResponseModel?.isPhoneVerified ?? false) &&
        (responseModel.authResponseModel?.isEmailVerified ?? false) &&
        (responseModel.authResponseModel?.isPersonalInfo ?? false) &&
        responseModel.authResponseModel?.isExistUser == null) {
      Get.find<GlobalController>().getUserInfo();
    }
  }

  /// google login function
  Future<void> googleLogin() async {
    EasyLoading.load();
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final googleAccount = (await googleSignIn.signIn())!;
      final auth = await googleAccount.authentication;
      final googleBodyModel = SocialLogInBody(
        email: googleAccount.email,
        token: auth.accessToken,
        uniqueId: googleAccount.id,
        medium: 'google',
        accessToken: 1,
        loginType: CentralizeLoginType.social.name,
      );

      final responseModel = await authServiceInterface.loginWithSocialMedia(
        googleBodyModel,
      );
      EasyLoading.dismiss();

      if (responseModel.isSuccess) {
        _processSocialSuccessSetup(responseModel, googleBodyModel, null);
      } else {
        showCustomSnackBar(responseModel.message);
      }
    } catch (e) {
      '==>>> googleBodyModel $e'.print;
    } finally {
      EasyLoading.dismiss();
    }
  }

  /// this function is used to navigate or process next flow after social login
  void _processSocialSuccessSetup(
    ResponseModel response,
    SocialLogInBody? googleBodyModel,
    SocialLogInBody? appleBodyModel,
  ) {
    var email = googleBodyModel?.email ?? appleBodyModel?.email;
    '==>> response ${response.updateProfileResponseModel?.toJson()}'.print;
    if (response.isSuccess &&
        response.authResponseModel != null &&
        response.authResponseModel!.isExistUser != null) {
      if (appleBodyModel != null) {
        email = response.authResponseModel!.email;
        appleBodyModel.email = email;
      }

      Get.bottomSheet(
        ExistingUserBottomSheet(
          userModel: response.authResponseModel!.isExistUser!,
          loginType: CentralizeLoginType.social.name,
          socialLogInBodyModel: googleBodyModel ?? appleBodyModel,
          email: email,
        ),
      );
    } else if (response.isSuccess &&
        response.authResponseModel != null &&
        !response.authResponseModel!.isPersonalInfo!) {
      final displayName =
          googleBodyModel?.email?.split('@')[0] ??
          appleBodyModel?.email?.split('@')[0];

      if (appleBodyModel != null) {
        email = response.authResponseModel!.email;
      }

      '${AppPages.newUser}?name=$displayName&login_type='
              '${CentralizeLoginType.social.name}&email=$email'
          .push();
    } else {
      Get.find<GlobalController>().getUserInfo();
    }
  }

  /// update personal info after social login
  Future<ResponseModel> updatePersonalInfo({
    required String name,
    required String? phone,
    required String loginType,
    required String? email,
    required String? referCode,
    bool alreadyInApp = false,
  }) async {
    EasyLoading.load();
    final responseModel = await authServiceInterface.updatePersonalInfo(
      name: name,
      phone: phone,
      email: email,
      loginType: loginType,
      referCode: referCode,
      alreadyInApp: alreadyInApp,
    );
    _getUserAndCartData(responseModel);
    EasyLoading.dismiss();
    return responseModel;
  }

  Future<void> appleLogin() async {
    final clientID =
        Get.find<GlobalController>().configModel!.appleLogin![0].clientId!;
    final redirectURL =
        Get.find<GlobalController>().configModel!.appleLogin![0].redirectUrl!;

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: GetPlatform.isIOS
          ? null
          : WebAuthenticationOptions(
              clientId: clientID,
              redirectUri: Uri.parse(redirectURL),
            ),

      // webAuthenticationOptions: WebAuthenticationOptions(
      //   clientId:
      //       Get.find<GlobalController>().configModel.appleLogin[0].clientId,
      //   redirectUri: Uri.parse('https://6ammart-web.6amtech.com/apple'),
      // ),
    );

    final appleBodyModel = SocialLogInBody(
      email: credential.email,
      token: credential.authorizationCode,
      uniqueId: credential.authorizationCode,
      medium: 'apple',
      loginType: CentralizeLoginType.social.name,
      platform: GetPlatform.isIOS ? 'flutter_app' : 'flutter_web',
    );

    await authServiceInterface.loginWithSocialMedia(appleBodyModel).then((
      response,
    ) {
      if (response.isSuccess) {
        _processSocialSuccessSetup(response, null, appleBodyModel);
      } else {
        showCustomSnackBar(response.message);
      }
    });
  }

  Future<void> configureToRouteInitialPage() async {
    Get.find<GlobalController>().disableIntro();
    await Get.find<GlobalController>().guestLogin();
    if (Get.find<GlobalController>().addressModel.value != null) {
      AppPages.bottomBarScreen.offAll();
    } else {
      AppPages.locationScreen.offAll();
    }
    Get.find<GlobalController>().isGuestMode = true;
  }
}
