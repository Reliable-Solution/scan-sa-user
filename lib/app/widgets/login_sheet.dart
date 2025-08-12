import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

void showLoginSheet() {
  Get.bottomSheet(const LoginSheet());
}

class LoginSheet extends StatelessWidget {
  const LoginSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: context.color.whiteLight,
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.appPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Login is required to access this feature',
              style: context.style.s22w700,
            ),
            Text(
              'Tap to Login to authorize',
              style: context.style.s14w600.copyWith(
                color: context.color.ff6c6c6c,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AppButton(
                label: 'login'.tr,
                onPressed: () => AppPages.login.offAll(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
