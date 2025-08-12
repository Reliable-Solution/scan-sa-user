import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/screens/otp_screens/controller/otp_controller.dart';
import 'package:scan_sa_user/app/presentation/auth_module/widgets/common_auth_screen.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    this.isFromSignUp = false,
    required this.email,
    this.mobile,
  }) : assert(
         email != null || mobile != null,
         'Please provide at least email or mobile',
       );
  final bool isFromSignUp;
  final String? email;
  final String? mobile;

  @override
  Widget build(BuildContext context) {
    final optController = Get.put(
      OtpController(authServiceInterface: Get.find()),
    );
    return Form(
      child: CommonAuthScreen(
        icon: AppIcons.otpScreenTitle,
        title: context.l10n.weJustSent,
        description: context.l10n.enterTheSecurity,
        children: [
          Text(email ?? mobile ?? '', style: context.style.s18w700),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Pinput(
              controller: optController.otpController,
              defaultPinTheme: PinTheme(
                height: 65,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: context.color.borderColor,
                    width: 2,
                  ),
                ),
              ),
              focusedPinTheme: PinTheme(
                height: 65,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: context.color.primary, width: 2),
                ),
              ),
            ),
          ),
          Builder(
            builder: (context) {
              return AppButton(
                label: context.l10n.verify,
                onPressed: () {
                  AppPages.resetPass.push();

                  // if (Form.of(context).validate()) {
                  //   optController.verifyToken(phone: mobile, email: email);
                  // }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
