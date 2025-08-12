import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/auth_module/models/auth_response_model.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/login_screens/controller/login_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/common/models/social_log_in_body.dart';
import 'package:scan_sa_user/utils/app_icons.dart';

class ExistingUserBottomSheet extends StatelessWidget {
  const ExistingUserBottomSheet({
    super.key,
    required this.userModel,
    this.number,
    this.email,
    required this.loginType,
    this.otp,
    this.socialLogInBodyModel,
  });
  final IsExistUser userModel;
  final String? number;
  final String? email;
  final String loginType;
  final String? otp;
  final SocialLogInBody? socialLogInBodyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      // height: 500,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
          bottom: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 35,
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 12),

          ClipOval(
            child: Image.asset(
              AppIcons.guestIcon,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),

          Text(userModel.name ?? 'Jhon Doe', textAlign: TextAlign.center),
          const SizedBox(height: 20),

          Text('is_it_you'.tr),
          const SizedBox(height: 20),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: number != null
                      ? 'it_looks_like_the_phone'.tr
                      : 'it_looks_like_the_email'.tr,
                  // style: robotoRegular.copyWith(
                  //   color: Theme.of(context).disabledColor,
                  // ),
                ),
                const TextSpan(text: ' '),

                TextSpan(
                  text: number ?? email,
                  // style: robotoMedium.copyWith(
                  //   color: Theme.of(context).textTheme.bodyMedium!.color,
                  // ),
                ),
                const TextSpan(text: ' '),

                TextSpan(
                  text:
                      'you_entered_has_already_been_used_and_has_an_existing_account'
                          .tr,
                  // style: robotoRegular.copyWith(
                  //   color: Theme.of(context).disabledColor,
                  // ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          SafeArea(
            child: GetBuilder<LoginController>(
              builder: (authController) {
                return Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'no'.tr,
                        onPressed: () {
                          // if (loginType == CentralizeLoginType.otp.name) {
                          //   authController
                          //       .otpLogin(
                          //         phone: number ?? email ?? '',
                          //         loginType: loginType,
                          //         otp: otp!,
                          //         verified: 'no',
                          //       )
                          //       .then(_responseHandle);
                          // } else {
                          //   socialLogInBodyModel!.verified = 'no';

                          //   authController
                          //       .loginWithSocialMedia(
                          //         socialLogInBodyModel!,
                          //       )
                          //       .then(_responseHandle);
                          // }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: AppButton(
                        label: 'yes_its_me'.tr,
                        onPressed: () async {
                          // if (loginType == CentralizeLoginType.otp.name) {
                          //   authController
                          //       .otpLogin(
                          //         phone: number ?? email ?? '',
                          //         loginType: loginType,
                          //         otp: otp!,
                          //         verified: 'yes',
                          //       )
                          //       .then(_responseHandle);
                          // } else {
                          //   socialLogInBodyModel!.verified = 'yes';

                          //   authController
                          //       .loginWithSocialMedia(
                          //         socialLogInBodyModel!,
                          //       )
                          //       .then(_responseHandle);
                          // }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void responseHandle(ResponseModel response) {
    Get.back();
    // if (response.isSuccess && !response.authResponseModel!.isPersonalInfo!) {
    //   if (ResponsiveHelper.isDesktop(Get.context)) {
    //     Get.back();
    //     Get.dialog(
    //       NewUserSetupScreen(
    //         name: userModel.name ?? '',
    //         loginType: loginType,
    //         phone: number,
    //         email: email,
    //       ),
    //     );
    //   } else {
    //     Get.toNamed(
    //       RouteHelper.getNewUserSetupScreen(
    //         name: userModel.name ?? '',
    //         loginType: loginType,
    //         phone: number,
    //         email: email,
    //       ),
    //     );
    //   }
    // } else if (response.isSuccess &&
    //     response.authResponseModel!.isPersonalInfo!) {
    //   // Get.offAllNamed(RouteHelper.getInitialRoute());
    //   Get.find<LocationController>().navigateToLocationScreen(
    //     'sign-in',
    //     offNamed: true,
    //   );
    // } else {
    //   Future.delayed(const Duration(milliseconds: 600), () {
    //     showCustomSnackBar(response.message);
    //   });
    // }
  }
}
