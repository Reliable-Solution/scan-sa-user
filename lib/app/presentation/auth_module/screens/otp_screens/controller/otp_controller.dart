import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class OtpController extends GetxController {
  OtpController({required this.authServiceInterface});

  /// this is authentication service to get all apis
  final AuthServiceInterface authServiceInterface;

  final otpController = TextEditingController();

  Future<ResponseModel> verifyToken({
    String? phone,
    String? email,
    bool isFromSignUp = false,
  }) async {
    EasyLoading.load();
    final responseModel = await authServiceInterface.verifyToken(
      phone: phone,
      email: email,
      token: otpController.text,
    );
    EasyLoading.dismiss();
    if (responseModel.isSuccess) {
      if (isFromSignUp) {
        AppPages.login.offAll();
      } else {
        AppPages.resetPass.push();
      }
      showCustomSnackBar('registerSuccessfully='.tr, isError: false);
    } else {
      showCustomSnackBar(responseModel.message);
    }
    return responseModel;
  }
}
