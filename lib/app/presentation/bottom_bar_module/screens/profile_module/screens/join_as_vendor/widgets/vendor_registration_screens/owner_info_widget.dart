import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class OwnerInfoWidget extends StatelessWidget {
  const OwnerInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreRegistrationController>(
      builder: (storeController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'owner_info'.tr,
              style: context.style.s18w700.copyWith(
                color: context.color.primary,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.color.whiteLight,
                boxShadow: [
                  BoxShadow(
                    color: context.color.primary.withValues(alpha: .1),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 8, bottom: 20),
              child: Column(
                spacing: 8,
                children: [
                  AppTextField(
                    hintText: 'first_name'.tr,
                    controller: storeController.fNameController,
                    maxLength: 10,
                    validator: (value) =>
                        AppValidations.emptyFieldValidation(value, null),
                  ),
                  AppTextField(
                    hintText: 'last_name'.tr,
                    controller: storeController.lNameController,
                    maxLength: 10,
                    validator: (value) =>
                        AppValidations.emptyFieldValidation(value, null),
                  ),

                  AppTextField(
                    hintText: context.l10n.phone,
                    controller: storeController.phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) =>
                        AppValidations.emptyFieldValidation(value, null),
                  ),
                  AppTextField(
                    hintText: context.l10n.email,
                    controller: storeController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        AppValidations.emptyFieldValidation(value, null),
                  ),
                  Obx(() {
                    final passObscureText =
                        storeController.passObscureText.value;
                    return AppTextField(
                      hintText: context.l10n.password,
                      bottomPadding: 12,
                      controller: storeController.passwordController,
                      obscureText: passObscureText,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        icon: SvgAssets(
                          passObscureText
                              ? AppIcons.closeEyeIc
                              : AppIcons.openEyeIc,
                        ),
                        onPressed: storeController.toggleObscureText,
                      ),
                      validator: (value) =>
                          AppValidations.passFieldValidation(value, context),
                    );
                  }),
                  Obx(() {
                    final conPassObscureText =
                        storeController.conPassObscureText.value;
                    return AppTextField(
                      hintText: context.l10n.confirmPassword,
                      bottomPadding: 12,
                      controller: storeController.confirmPassController,
                      textInputAction: TextInputAction.done,
                      obscureText: conPassObscureText,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        icon: SvgAssets(
                          conPassObscureText
                              ? AppIcons.closeEyeIc
                              : AppIcons.openEyeIc,
                        ),
                        onPressed: () =>
                            storeController.toggleObscureText(isPass: false),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return context.l10n.pleaseEnterConfirmPassword;
                        } else if (value !=
                            storeController.passwordController.text) {
                          return 'Password and confirm password does not match';
                        } else {
                          return null;
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
