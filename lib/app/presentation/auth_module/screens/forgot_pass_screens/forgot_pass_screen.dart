import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/forgot_pass_screens/controller/forgot_pass_controller.dart';
import 'package:scan_sa_user/app/presentation/auth_module/widgets/common_auth_screen.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/helper/get_it_hook.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class ForgotPassScreen extends GetItHook<ForgotPassController> {
  const ForgotPassScreen({super.key, required super.controller});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(
    //   ForgotPassController(authServiceInterface: Get.find()),
    // );
    return Form(
      child: CommonAuthScreen(
        icon: AppIcons.passwordScreenTitle,
        title: context.l10n.forgotPassword,
        description: context.l10n.checkYourInbox,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: AppTextField(
              hintText: context.l10n.enterEmail,
              bottomPadding: 16,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  AppValidations.emailFieldValidation(value, context),
            ),
          ),
          Builder(
            builder: (context) {
              return AppButton(
                label: context.l10n.send,
                onPressed: () => controller.forgetPassword(context),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get canDisposeController => true;

  @override
  void onDispose() {}

  @override
  void onInit() {}
}
