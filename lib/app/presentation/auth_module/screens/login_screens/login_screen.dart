import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/login_screens/controller/login_controller.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/login_screens/widgets/round_animation.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_rich_text.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/helper/get_it_hook.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class LoginScreen extends GetItHook<LoginController> {
  const LoginScreen({super.key, required super.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.secondary,
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          EntryAnimatedRotatingCircles(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.color.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSizes.appPadding),
                child: Form(
                  child: Builder(
                    builder: (context) {
                      return Column(
                        children: [
                          Text(
                            context.l10n.welcome,
                            style: context.style.s30w700,
                          ),
                          Text(
                            context.l10n.letsStartWith,
                            style: context.style.s18w700.copyWith(
                              color: context.color.ff6c6c6c,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: AppTextField(
                              hintText: context.l10n.enterEmail,
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (p0) =>
                                  AppValidations.emailFieldValidation(
                                    p0,
                                    context,
                                  ),
                            ),
                          ),
                          Obx(() {
                            final passObscureText =
                                controller.obscureText.value;
                            return AppTextField(
                              hintText: context.l10n.password,
                              controller: controller.passController,
                              textInputAction: TextInputAction.done,
                              obscureText: passObscureText,
                              keyboardType: TextInputType.visiblePassword,
                              suffixIcon: IconButton(
                                icon: SvgAssets(
                                  passObscureText
                                      ? AppIcons.closeEyeIc
                                      : AppIcons.openEyeIc,
                                ),
                                onPressed: controller.toggleObscureText,
                              ),
                              validator: (p0) =>
                                  AppValidations.passFieldValidation(
                                    p0,
                                    context,
                                  ),
                            );
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: controller.toggleRememberMe,
                                child: Obx(() {
                                  final isRemember =
                                      controller.isRemember.value;
                                  return Container(
                                    width: 20,
                                    height: 20,
                                    margin: AppPadding.rightPad(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                        color: isRemember
                                            ? context.color.primary
                                            : context.color.borderColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: isRemember
                                        ? Icon(
                                            Icons.check,
                                            size: 16,
                                            color: context.color.primary,
                                          )
                                        : null,
                                  );
                                }),
                              ),
                              Text(
                                context.l10n.rememberMe,
                                style: context.style.s16w700.copyWith(
                                  color: context.color.darkTextGrey,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: AppPages.forgotPass.push,
                                child: Text(
                                  context.l10n.forgotPasswordQ,
                                  style: context.style.s16w700.copyWith(
                                    color: context.color.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AppRichText(
                                text1: context.l10n.iAgree,
                                text2: context.l10n.termsConditions,
                              ),
                            ),
                          ),
                          AppButton(
                            label: context.l10n.login,
                            onPressed: () {
                              if (Form.of(context).validate()) {
                                return controller.login();
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
                            onTap: controller.googleLogin,
                          ),
                          // if (Platform.isIOS)
                          //   Padding(
                          //     padding: const EdgeInsets.only(top: 14),
                          //     child: SocialButton(
                          //       icon: AppIcons.appleIc,
                          //       label: context.l10n.apple,
                          //       onTap: controller.appleLogin,
                          //     ),
                          //   ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: AppRichText(
                              text1: context.l10n.donNotHaveAcc,
                              text2: context.l10n.signUp,
                              textStyle1: context.style.s14w700.copyWith(
                                color: context.color.darkTextGrey,
                              ),
                              textStyle2: context.style.s14w700.copyWith(
                                color: context.color.secondary,
                              ),
                              onTap1: AppPages.signUp.push,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 10,
              left: AppSizes.appPadding,
              right: AppSizes.appPadding,
            ),
            child: GestureDetector(
              onTap: () => controller.configureToRouteInitialPage(),
              child: Text(
                'SKIP',
                style: context.style.s14w600.copyWith(
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                ),
              ),
            ),
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
