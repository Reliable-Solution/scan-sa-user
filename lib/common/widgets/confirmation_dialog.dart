import 'package:scan_sa_user/features/order/controllers/order_controller.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      ),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: PointerInterceptor(
        child: SizedBox(
          width: 500,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: Image.asset(
                    icon,
                    width: 50,
                    height: 50,
                    // color: context.color.secondary,
                  ),
                ),
                title != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge,
                        ),
                        child: Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: Text(
                    description,
                    style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                GetBuilder<OrderController>(
                  builder: (orderController) {
                    return !orderController.isLoading
                        ? Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  onPressed: () => isLogOut
                                      ? onYesPressed()
                                      : onNoPressed != null
                                          ? onNoPressed!()
                                          : Get.back(),
                                  // style: TextButton.styleFrom(
                                  //   backgroundColor: Theme.of(context)
                                  //       .disabledColor
                                  //       .withValues(alpha: 0.3),
                                  //   minimumSize:
                                  //       const Size(Dimensions.webMaxWidth, 50),
                                  //   padding: EdgeInsets.zero,
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(
                                  //       Dimensions.radiusSmall,
                                  //     ),
                                  //   ),
                                  // ),
                                  buttonText: isLogOut ? 'yes'.tr : 'no'.tr,
                                  buttonType: ButtonType.white,
                                  color: context.color.grey,
                                  textColor: context.color.secondary,
                                  // child: Text(
                                  //   isLogOut ? 'yes'.tr : 'no'.tr,
                                  //   textAlign: TextAlign.center,
                                  //   style: robotoBold.copyWith(
                                  //     color: Theme.of(context)
                                  //         .textTheme
                                  //         .bodyLarge!
                                  //         .color,
                                  //   ),
                                  // ),
                                ),
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeLarge,
                              ),
                              Expanded(
                                child: AppButton(
                                  buttonText: isLogOut ? 'no'.tr : 'yes'.tr,
                                  onPressed: () =>
                                      isLogOut ? Get.back() : onYesPressed(),
                                  radius: Dimensions.radiusSmall,
                                  height: 50,
                                ),
                              ),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
