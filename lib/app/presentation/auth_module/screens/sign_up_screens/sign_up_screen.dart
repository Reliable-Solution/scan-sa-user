import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/login_screens/controller/login_controller.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/sign_up_screens/controller/sign_up_controller.dart';
import 'package:scan_sa_user/app/presentation/auth_module/widgets/common_auth_screen.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_rich_text.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Get.put(
      SignUpController(authServiceInterface: Get.find()),
    );
    return Form(
      child: Builder(
        builder: (context) {
          return CommonAuthScreen(
            isRegisterScreen: true,
            children: [
              AppTextField(
                hintText: context.l10n.userName,
                controller: signUpProvider.userNameController,
                validator: (value) => AppValidations.emptyFieldValidation(
                  value,
                  context.l10n.pleaseEnterUserName,
                ),
              ),
              AppTextField(
                hintText: context.l10n.phone,
                controller: signUpProvider.phoneController,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) => AppValidations.emptyFieldValidation(
                  value,
                  context.l10n.pleaseEnterPhoneNumber,
                ),
              ),
              AppTextField(
                hintText: context.l10n.enterEmail,
                controller: signUpProvider.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    AppValidations.emailFieldValidation(value, context),
              ),
              Obx(() {
                final passObscureText = signUpProvider.passObscureText.value;
                return AppTextField(
                  hintText: context.l10n.password,
                  bottomPadding: 12,
                  controller: signUpProvider.passController,
                  obscureText: passObscureText,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: SvgAssets(
                      passObscureText
                          ? AppIcons.closeEyeIc
                          : AppIcons.openEyeIc,
                    ),
                    onPressed: signUpProvider.toggleObscureText,
                  ),
                  validator: (value) =>
                      AppValidations.passFieldValidation(value, context),
                );
              }),
              Obx(() {
                final conPassObscureText =
                    signUpProvider.conPassObscureText.value;
                return AppTextField(
                  hintText: context.l10n.confirmPassword,
                  bottomPadding: 12,
                  controller: signUpProvider.conPassController,
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
                        signUpProvider.toggleObscureText(isPass: false),
                  ),
                  validator: (value) => AppValidations.emptyFieldValidation(
                    value,
                    context.l10n.pleaseEnterConfirmPassword,
                  ),
                );
              }),
              AppTextField(
                hintText: context.l10n.referCode,
                controller: signUpProvider.referralCodeController,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppRichText(
                    text1: context.l10n.iAgree,
                    text2: context.l10n.termsConditions,
                  ),
                ),
              ),
              AppButton(
                label: context.l10n.signUp,
                onPressed: () {
                  if (Form.of(context).validate()) {
                    signUpProvider.register('+91');
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: context.color.grey,
                      thickness: 2,
                      endIndent: 12,
                      height: 42,
                    ),
                  ),
                  Text(
                    context.l10n.orWith,
                    style: context.style.s16w700.copyWith(
                      color: context.color.lightText,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: context.color.grey,
                      thickness: 2,
                      indent: 12,
                      height: 42,
                    ),
                  ),
                ],
              ),
              SocialButton(
                icon: AppIcons.googleIc,
                label: context.l10n.google,
                onTap: Get.find<LoginController>().googleLogin,
              ),
              if (Platform.isIOS)
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: SocialButton(
                    icon: AppIcons.appleIc,
                    label: context.l10n.apple,
                    onTap: () {},
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: AppRichText(
                  text1: context.l10n.alreadyHaveAcc,
                  text2: context.l10n.signIn,
                  textStyle1: context.style.s14w700.copyWith(
                    color: context.color.darkTextGrey,
                  ),
                  textStyle2: context.style.s14w700.copyWith(
                    color: context.color.secondary,
                  ),
                  onTap1: Get.back,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
