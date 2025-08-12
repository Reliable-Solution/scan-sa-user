import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.icon,
    this.title,
    required this.description,
    required this.onYesPressed,
    this.isLogOut = false,
    this.onNoPressed,
  });
  final String icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: context.color.white,
      insetPadding: const EdgeInsets.all(30),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Image.asset(
                icon,
                width: 80,
                height: 80,
                color: Theme.of(context).primaryColor,
              ),
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge,
                ),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: context.style.s18w700,
                ),
              )
            else
              const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: Text(
                description,
                style: context.style.s16w700,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            GetBuilder<CartController>(
              builder: (orderController) {
                return Row(
                  spacing: Dimensions.paddingSizeLarge,
                  children: [
                    Expanded(
                      child: AppButton(
                        label: isLogOut ? 'yes'.tr : 'no'.tr,
                        buttonType: ButtonType.white,
                        btnColor: context.color.grey,
                        txtColor: context.color.primary,
                        onPressed: () => isLogOut
                            ? onYesPressed()
                            : onNoPressed != null
                            ? onNoPressed!()
                            : Get.back(),
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        label: isLogOut ? 'no'.tr : 'yes'.tr,
                        onPressed: () => isLogOut ? Get.back() : onYesPressed(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
