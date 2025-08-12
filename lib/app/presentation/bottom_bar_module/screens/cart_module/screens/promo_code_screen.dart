import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/controllers/checkout_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/controllers/coupon_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/coupon_screen.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({
    super.key,
    this.order,
    this.deliveryCharge,
    this.storeId,
    required this.total,
  });
  final num? order;
  final num? deliveryCharge;
  final int? storeId;
  final num total;

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  final coupon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var totalPrice = widget.total;
    return GetBuilder<CouponController>(
      builder: (controller) {
        final checkoutController = Get.find<CheckoutController>();
        return CommonSubScreen(
          appBarTitle: context.l10n.promoCodes,
          backColor: Get.find<GlobalController>().isDark
              ? context.color.whiteLight
              : context.color.fff5f5f5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.appPadding,
                  vertical: 20,
                ),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.l10n.promoCode, style: context.style.s18w700),
                    AppTextField(
                      hintText: context.l10n.enterPromoCode,
                      bottomPadding: 0,
                      controller: coupon,
                    ),
                    Text(
                      'Voucher',
                      style: context.style.s16w700.copyWith(
                        color: context.color.greenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: VoucherScreenWidget(
                  onTap: (code) {
                    coupon.text = code;
                  },
                ),
              ),
              Divider(height: 0, color: context.color.borderColor),
              GestureDetector(
                onTap: () {
                  if (coupon.text.isNotEmpty) {
                    controller
                        .applyCoupon(
                          coupon.text,
                          widget.order ?? 0,
                          widget.deliveryCharge,
                          widget.storeId ?? 0,
                        )
                        .then((discount) {
                          if (discount! > 0) {
                            showCustomSnackBar(
                              '${'you_got_discount_of'.tr} ${PriceConverter.convertPrice(discount)}',
                              isError: false,
                            );
                            if (checkoutController.isPartialPay ||
                                checkoutController.paymentMethodIndex == 1) {
                              totalPrice = totalPrice - discount;
                              checkoutController.checkBalanceStatus(
                                totalPrice,
                                discount,
                              );
                            }
                            checkoutController
                              ..appliedCoupon = coupon.text
                              ..update();
                            Get.back();
                          }
                        });
                  }
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  height: MediaQuery.paddingOf(context).bottom / 2 + 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.paddingOf(context).bottom / 2,
                  ),
                  child: Text(
                    context.l10n.apply,
                    style: context.style.s22w700.copyWith(
                      color: context.color.ff9c9c9c,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
