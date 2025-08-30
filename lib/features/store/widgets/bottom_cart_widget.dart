import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/cart/controllers/cart_controller.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';

class BottomCartWidget extends StatelessWidget {
  const BottomCartWidget({super.key, this.storeId, this.fromQr = false});
  final int? storeId;
  final bool fromQr;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        final isAdd =
            storeId == cartController.cartList.firstOrNull?.item?.storeId ||
                storeId == null ||
                !fromQr;
        return IntrinsicHeight(
          child: Container(
            // height: GetPlatform.isIOS ? 100 : 70,
            width: Get.width,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeExtraLarge,
              /* vertical: Dimensions.PADDING_SIZE_SMALL*/
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2A2A2A).withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${'item'.tr}: ${cartController.cartList.length}',
                            style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
                          ),
                          Row(
                            children: [
                              Text(
                                '${'total'.tr}: ',
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: context.color.secondary,
                                ),
                              ),
                              Text(
                                PriceConverter.convertPrice(
                                  cartController.calculationCart(),
                                ),
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: context.color.secondary,
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppButton(
                        buttonText: isAdd ? 'view_cart'.tr : 'remove'.tr,
                        width: 130,
                        height: 45,
                        color: isAdd ? null : context.color.redColor,
                        buttonType: isAdd ? null : ButtonType.red,
                        onPressed: () => isAdd
                            ? Get.toNamed(
                                RouteHelper.getCartRoute(isFromQr: fromQr),
                              )
                            : cartController.clearCartOnline(),
                      ),
                    ],
                  ),
                  if (!isAdd)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '*Your cart item store and different then your scanned store',
                        style: context.style.s12w700.copyWith(
                          color: context.color.redColor,
                          height: 1.2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
