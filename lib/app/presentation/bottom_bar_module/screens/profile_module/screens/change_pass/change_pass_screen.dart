import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/change_pass/controller/change_pass_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final changePassController = Get.put(
      ChangePassController(profileServiceInterface: Get.find()),
    );
    return CommonSubScreen(
      appBarTitle: context.l10n.changePassword,
      child: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.appPadding,
            vertical: 20,
          ),
          children: [
            // AppTextField(
            //   hintText: context.l10n.enterOldPassword,
            //   bottomPadding: 12,
            //   controller: changePassController.oldPass,
            //   obscureText: changePassController.oldPassObscureText.value,
            //   keyboardType: TextInputType.visiblePassword,
            //   suffixIcon: IconButton(
            //     icon: SvgAssets(
            //       changePassController.oldPassObscureText.value
            //           ? AppIcons.closeEyeIc
            //           : AppIcons.openEyeIc,
            //     ),
            //     onPressed: () =>
            //         changePassController.toggleObscureText(isPass: null),
            //   ),
            //   validator: (value) =>
            //       AppValidations.passFieldValidation(value, context),
            // ),
            AppTextField(
              hintText: context.l10n.enterNewPassword,
              controller: changePassController.newPass,
              textInputAction: TextInputAction.done,
              obscureText: changePassController.passObscureText.value,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                icon: SvgAssets(
                  changePassController.passObscureText.value
                      ? AppIcons.closeEyeIc
                      : AppIcons.openEyeIc,
                ),
                onPressed: changePassController.toggleObscureText,
              ),
              validator: (value) => AppValidations.emptyFieldValidation(
                value,
                context.l10n.pleaseEnterConfirmPassword,
              ),
            ),
            AppTextField(
              hintText: context.l10n.confirmPassword,
              controller: changePassController.confirmPass,
              textInputAction: TextInputAction.done,
              obscureText: changePassController.conPassObscureText.value,
              keyboardType: TextInputType.visiblePassword,
              bottomPadding: 50,
              suffixIcon: IconButton(
                icon: SvgAssets(
                  changePassController.conPassObscureText.value
                      ? AppIcons.closeEyeIc
                      : AppIcons.openEyeIc,
                ),
                onPressed: () =>
                    changePassController.toggleObscureText(isPass: false),
              ),
              validator: (value) => AppValidations.emptyFieldValidation(
                value,
                context.l10n.pleaseEnterConfirmPassword,
              ),
            ),
            AppButton(
              label: context.l10n.changePassword,
              onPressed: changePassController.changePassword,
            ),
          ],
        ),
      ),
    );
  }
}
