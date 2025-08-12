import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service_interface.dart';
import 'package:scan_sa_user/app/presentation/auth_module/models/signup_body_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/enums/centralize_login_enum.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class SignUpController extends GetxController {
  SignUpController({required this.authServiceInterface});

  /// this is authentication service to get all apis
  final AuthServiceInterface authServiceInterface;

  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final conPassController = TextEditingController();
  final referralCodeController = TextEditingController();
  RxBool isRemember = false.obs;
  RxBool passObscureText = true.obs;
  RxBool conPassObscureText = true.obs;

  void toggleRememberMe() {
    isRemember.value = !isRemember.value;
  }

  void toggleObscureText({bool isPass = true}) {
    if (isPass) {
      passObscureText.value = !passObscureText.value;
    } else {
      conPassObscureText.value = !conPassObscureText.value;
    }
  }

  Future<void> register(String countryCode) async {
    // AppPages.signUpOtp.push<Map<String, dynamic>>(
    //   arguments: {'email': 'xyz@gmail.com'},
    // );
    EasyLoading.load();
    final signUpModel = await _prepareSignUpBody(countryCode);

    if (signUpModel == null) {
      EasyLoading.dismiss();
      return;
    } else {
      await authServiceInterface.registration(signUpModel).then((status) async {
        EasyLoading.dismiss();
        _handleResponse(status, countryCode);
      });
    }
  }

  void _handleResponse(ResponseModel status, String countryCode) {
    final numberWithCountryCode = countryCode + passController.text.trim();
    final email = emailController.text.trim();

    '==>> status.authResponseModel ${status.authResponseModel?.toJson()}'.print;

    if (status.isSuccess) {
      if (status.authResponseModel != null &&
          !(status.authResponseModel?.isPhoneVerified ?? false)) {
        if (Get.find<GlobalController>().configModel?.firebaseOtpVerification ??
            false) {
          Get.find<GlobalController>().firebaseVerifyPhoneNumber(
            numberWithCountryCode,
            status.message,
            CentralizeLoginType.manual.name,
          );
        } else {
          AppPages.signUpOtp.push<Map<String, dynamic>>(
            arguments: {'email': email},
          );
        }
      } else if (status.authResponseModel != null &&
          !(status.authResponseModel?.isEmailVerified ?? false)) {
        // final List<int> encoded = utf8.encode(password);
        // final data = base64Encode(encoded);

        AppPages.signUpOtp.push<Map<String, dynamic>>(
          arguments: {'email': email},
        );
      } else {
        Get.find<GlobalController>().getUserInfo();
        // Get.find<LocationController>().navigateToLocationScreen(
        //   RouteHelper.signUp,
        // );
        // if (ResponsiveHelper.isDesktop(context)) {
        //   Get.back();
        // }
      }
    } else {
      showCustomSnackBar(status.message);
    }
    EasyLoading.dismiss();
  }

  Future<SignUpBodyModel?> _prepareSignUpBody(String countryCode) async {
    final name = userNameController.text.trim();
    final email = emailController.text.trim();
    final number = phoneController.text.trim();
    final password = passController.text.trim();
    final confirmPassword = conPassController.text.trim();
    final referCode = referralCodeController.text.trim();

    var numberWithCountryCode = countryCode + number;
    ('numberWithCountryCode: $numberWithCountryCode').print;
    final phoneValid = await AppValidations.isPhoneValid(numberWithCountryCode);
    numberWithCountryCode = phoneValid.phone;

    if (name.isEmpty) {
      showCustomSnackBar('please_enter_your_name'.tr);
    } else if (email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    } else if (number.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (!phoneValid.isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    } else if (password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (password.length < 8) {
      showCustomSnackBar('password_should_be_8_characters'.tr);
    } else if (password != confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    } else if (referCode.isNotEmpty && referCode.length != 10) {
      showCustomSnackBar('invalid_refer_code'.tr);
    } else {
      final signUpBody = SignUpBodyModel(
        name: name,
        email: email,
        phone: numberWithCountryCode,
        password: password,
        refCode: referCode,
      );
      return signUpBody;
    }
    return null;
  }
}
