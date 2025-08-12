import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class SubscriptionSuccessOrFailedScreen extends StatefulWidget {
  const SubscriptionSuccessOrFailedScreen({
    super.key,
    required this.success,
    required this.fromSubscription,
    this.storeId,
  });
  final bool success;
  final bool fromSubscription;
  final int? storeId;

  @override
  State<SubscriptionSuccessOrFailedScreen> createState() =>
      _SubscriptionSuccessOrFailedScreenState();
}

class _SubscriptionSuccessOrFailedScreenState
    extends State<SubscriptionSuccessOrFailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSizes.appPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.success ? AppIcons.checkGif : AppIcons.cancelGif,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  widget.success
                      ? '${'congratulations'.tr}!'
                      : '${'transaction_failed'.tr}!',
                  style: context.style.s20w900,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                child: Text(
                  widget.success
                      ? widget.fromSubscription
                            ? '${'subscription_success_message'.tr} '
                            : '${'commission_base_success_message'.tr} '
                      : 'sorry_your_transaction_can_not_be_completed_please_choose_another_payment_method_or_try_again'
                            .tr,
                  textAlign: TextAlign.center,
                  style: context.style.s16w500,
                ),
              ),
              TextButton(
                onPressed: () => widget.success
                    ? AppPages.bottomBarScreen.offAll(arguments: false)
                    : Get.back(),
                child: Text(
                  widget.success ? 'continue_to_home_page'.tr : 'back'.tr,
                  style: context.style.s16w700.copyWith(
                    color: widget.success
                        ? context.color.greenColor
                        : context.color.redColor,
                    decoration: TextDecoration.underline,
                    decorationColor: widget.success
                        ? context.color.greenColor
                        : context.color.redColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
