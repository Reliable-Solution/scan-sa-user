import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/common/controllers/theme_controller.dart';
import 'package:scan_sa_user/features/profile/controllers/profile_controller.dart';
import 'package:scan_sa_user/features/checkout/controllers/checkout_controller.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/util/styles.dart';

class PartialPayView extends StatelessWidget {
  const PartialPayView({
    super.key,
    required this.totalPrice,
    required this.isPrescription,
  });
  final num totalPrice;
  final bool isPrescription;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (checkoutController) {
        return Get.find<SplashController>()
                    .configModel!
                    .partialPaymentStatus! &&
                !isPrescription &&
                Get.find<SplashController>()
                        .configModel!
                        .customerWalletStatus ==
                    1 &&
                Get.find<ProfileController>().userInfoModel!.walletBalance! > 0
            ? AnimatedContainer(
                duration: const Duration(seconds: 2),
                decoration: BoxDecoration(
                  color: Get.find<ThemeController>().darkTheme
                      ? context.color.secondary.withValues(alpha: 0.2)
                      : context.color.secondary.withValues(alpha: 0.05),
                  border: Border.all(
                    color: context.color.secondary,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  image: !ResponsiveHelper.isDesktop(context)
                      ? DecorationImage(
                          alignment: Alignment.bottomRight,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withValues(alpha: 0.1),
                            BlendMode.dstATop,
                          ),
                          image: const AssetImage(Images.partialWallet),
                        )
                      : null,
                ),
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: ResponsiveHelper.isDesktop(context)
                    ? Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                checkoutController.isPartialPay ||
                                        checkoutController.paymentMethodIndex ==
                                            1
                                    ? Row(
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(2),
                                            child: const Icon(
                                              Icons.check,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: Dimensions
                                                .paddingSizeExtraSmall,
                                          ),
                                          Text(
                                            'applied'.tr,
                                            style: robotoMedium.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        'do_you_want_to_use_now'.tr,
                                        style: robotoMedium.copyWith(
                                          color: context.color.secondary,
                                          fontSize: Dimensions.fontSizeDefault,
                                        ),
                                      ),
                                const SizedBox(
                                  height: Dimensions.paddingSizeSmall,
                                ),
                                Text(
                                  PriceConverter.convertPrice(
                                    Get.find<ProfileController>()
                                        .userInfoModel!
                                        .walletBalance,
                                  ),
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: context.color.secondary,
                                  ),
                                ),
                                checkoutController.paymentMethodIndex == 1
                                    ? Text(
                                        '${'remaining_wallet_balance'.tr}: ${PriceConverter.convertPrice(Get.find<ProfileController>().userInfoModel!.walletBalance! - totalPrice)}',
                                        style: robotoMedium.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraSmall,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (Get.find<ProfileController>()
                                      .userInfoModel!
                                      .walletBalance! <
                                  totalPrice) {
                                checkoutController.changePartialPayment();
                              } else {
                                if (checkoutController.paymentMethodIndex !=
                                    1) {
                                  checkoutController.setPaymentMethod(1);
                                } else {
                                  checkoutController.setPaymentMethod(-1);
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: checkoutController.isPartialPay ||
                                        checkoutController.paymentMethodIndex ==
                                            1
                                    ? Theme.of(context).cardColor
                                    : context.color.secondary,
                                border: Border.all(
                                  color: checkoutController.isPartialPay ||
                                          checkoutController
                                                  .paymentMethodIndex ==
                                              1
                                      ? Colors.red
                                      : context.color.secondary,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusDefault,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeSmall,
                                horizontal: Dimensions.paddingSizeLarge,
                              ),
                              child: Text(
                                checkoutController.isPartialPay ||
                                        checkoutController.paymentMethodIndex ==
                                            1
                                    ? 'remove'.tr
                                    : 'use'.tr,
                                style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: checkoutController.isPartialPay ||
                                          checkoutController
                                                  .paymentMethodIndex ==
                                              1
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                Images.partialWallet,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    PriceConverter.convertPrice(
                                      Get.find<ProfileController>()
                                          .userInfoModel!
                                          .walletBalance,
                                    ),
                                    style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeOverLarge,
                                      color: context.color.secondary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  Text(
                                    checkoutController.isPartialPay
                                        ? 'has_paid_by_your_wallet'.tr
                                        : 'your_have_balance_in_your_wallet'.tr,
                                    style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              checkoutController.isPartialPay ||
                                      checkoutController.paymentMethodIndex == 1
                                  ? Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(2),
                                          child: const Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall,
                                        ),
                                        Text(
                                          'applied'.tr,
                                          style: robotoMedium.copyWith(
                                            color: context.color.secondary,
                                            fontSize: Dimensions.fontSizeLarge,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'do_you_want_to_use_now'.tr,
                                      style: robotoMedium.copyWith(
                                        color: context.color.secondary,
                                        fontSize: Dimensions.fontSizeLarge,
                                      ),
                                    ),
                              InkWell(
                                onTap: () {
                                  if (Get.find<ProfileController>()
                                          .userInfoModel!
                                          .walletBalance! <
                                      totalPrice) {
                                    checkoutController.changePartialPayment();
                                  } else {
                                    if (checkoutController.paymentMethodIndex !=
                                        1) {
                                      checkoutController.setPaymentMethod(1);
                                    } else {
                                      checkoutController.setPaymentMethod(-1);
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: checkoutController.isPartialPay ||
                                            checkoutController
                                                    .paymentMethodIndex ==
                                                1
                                        ? Theme.of(context).cardColor
                                        : context.color.secondary,
                                    border: Border.all(
                                      color: checkoutController.isPartialPay ||
                                              checkoutController
                                                      .paymentMethodIndex ==
                                                  1
                                          ? Colors.red
                                          : context.color.secondary,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radiusDefault,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.paddingSizeSmall,
                                    horizontal: Dimensions.paddingSizeLarge,
                                  ),
                                  child: Text(
                                    checkoutController.isPartialPay ||
                                            checkoutController
                                                    .paymentMethodIndex ==
                                                1
                                        ? 'remove'.tr
                                        : 'use'.tr,
                                    style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: checkoutController.isPartialPay ||
                                              checkoutController
                                                      .paymentMethodIndex ==
                                                  1
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          checkoutController.paymentMethodIndex == 1
                              ? Text(
                                  '${'remaining_wallet_balance'.tr}: ${PriceConverter.convertPrice(Get.find<ProfileController>().userInfoModel!.walletBalance! - totalPrice)}',
                                  style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
              )
            : const SizedBox();
      },
    );
  }
}
