import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class ForgotPassController extends GetxController {
  ForgotPassController({required this.authServiceInterface});

  /// this is authentication service to get all apis
  final AuthServiceInterface authServiceInterface;
  final emailController = TextEditingController();

  Future<void> forgetPassword(BuildContext context) async {
    if (Form.of(context).validate()) {
      EasyLoading.load();
      final responseModel = await authServiceInterface.forgetPassword(
        email: emailController.text,
      );
      if (responseModel.isSuccess) {
        AppPages.forgotOtp.push<Map<String, dynamic>>(
          arguments: {'email': emailController.text},
        );
      } else {
        showCustomSnackBar(responseModel.message);
      }
      EasyLoading.dismiss();
    }
  }
}
