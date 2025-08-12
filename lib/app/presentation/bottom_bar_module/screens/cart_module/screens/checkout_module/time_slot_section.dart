import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/controllers/checkout_controller.dart';
import 'package:scan_sa_user/common/models/config_model.dart';
import 'package:scan_sa_user/utils/dimensions.dart';

class TimeSlotSection extends StatelessWidget {
  const TimeSlotSection({
    super.key,
    this.storeId,
    required this.checkoutController,
    this.cartList,
    required this.tomorrowClosed,
    required this.todayClosed,
    this.module,
  });
  final int? storeId;
  final CheckoutController checkoutController;
  final List<CartModel?>? cartList;
  final bool tomorrowClosed;
  final bool todayClosed;
  final Module? module;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!checkoutController.store!.scheduleOrder!)
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge,
              vertical: Dimensions.paddingSizeSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('preference_time'.tr),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    // JustTheTooltip(
                    //   backgroundColor: Colors.black87,
                    //   controller: tooltipController2,
                    //   preferredDirection: AxisDirection.right,
                    //   tailLength: 14,
                    //   tailBaseWidth: 20,
                    //   content: Padding(
                    //     padding: const EdgeInsets.all(8),
                    //     child: Text(
                    //       'schedule_time_tool_tip'.tr,
                    //       style: robotoRegular.copyWith(color: Colors.white),
                    //     ),
                    //   ),
                    //   child: InkWell(
                    //     onTap: tooltipController2.showTooltip,
                    //     child: const Icon(Icons.info_outline),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                InkWell(
                  onTap: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   isScrollControlled: true,
                    //   backgroundColor: Colors.transparent,
                    //   builder: (con) => TimeSlotBottomSheet(
                    //     tomorrowClosed: tomorrowClosed,
                    //     todayClosed: todayClosed,
                    //     module: module,
                    //   ),
                    // );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(
                        Dimensions.radiusDefault,
                      ),
                    ),
                    height: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: Dimensions.paddingSizeLarge),
                        Expanded(
                          child:
                              ((checkoutController.selectedDateSlot == 0 &&
                                      todayClosed) ||
                                  (checkoutController.selectedDateSlot == 1 &&
                                      tomorrowClosed))
                              ? Center(
                                  child: Text(
                                    module!.showRestaurantText!
                                        ? 'restaurant_is_closed'.tr
                                        : 'store_is_closed'.tr,
                                  ),
                                )
                              : Text(
                                  checkoutController.preferableTime.isNotEmpty
                                      ? checkoutController.preferableTime
                                      : 'instance'.tr,
                                ),
                        ),
                        const Icon(Icons.arrow_drop_down, size: 28),
                        Icon(
                          Icons.access_time_filled_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
              ],
            ),
          )
        else
          const SizedBox(),
        SizedBox(
          height: storeId == null && checkoutController.store!.scheduleOrder!
              ? Dimensions.paddingSizeSmall
              : 0,
        ),
      ],
    );
  }
}
