import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/reset_pass_screens/controller/reset_pass_controller.dart';
import 'package:scan_sa_user/app/presentation/auth_module/widgets/common_auth_screen.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final resetPassController = Get.put(ResetPassController());
    return CommonAuthScreen(
      icon: AppIcons.passwordScreenTitle,
      title: context.l10n.forgotPassword,
      description: context.l10n.checkYourInbox,
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(top: 40),
            child: AppTextField(
              hintText: context.l10n.enterNewPass,
              bottomPadding: 12,
              controller: resetPassController.passController,
              obscureText: resetPassController.passObscureText.value,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                icon: SvgAssets(
                  resetPassController.passObscureText.value
                      ? AppIcons.closeEyeIc
                      : AppIcons.openEyeIc,
                ),
                onPressed: resetPassController.toggleObscureText,
              ),
              validator: (value) =>
                  AppValidations.passFieldValidation(value, context),
            ),
          ),
        ),
        Obx(
          () => AppTextField(
            hintText: context.l10n.confirmPassword,
            controller: resetPassController.conPassController,
            textInputAction: TextInputAction.done,
            obscureText: resetPassController.conPassObscureText.value,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              icon: SvgAssets(
                resetPassController.conPassObscureText.value
                    ? AppIcons.closeEyeIc
                    : AppIcons.openEyeIc,
              ),
              onPressed: () =>
                  resetPassController.toggleObscureText(isPass: false),
            ),
            validator: (value) => AppValidations.emptyFieldValidation(
              value,
              context.l10n.pleaseEnterConfirmPassword,
            ),
          ),
        ),
        AppButton(
          label: context.l10n.submit,
          onPressed: () => AppPages.login.offAll(),
        ),
      ],
    );
  }
}
