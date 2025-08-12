import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class BusinessPlanWidget extends StatelessWidget {
  const BusinessPlanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreRegistrationController>(
      builder: (controller) {
        final isRental =
            controller.moduleList.isNotEmpty &&
            controller.selectedModuleIndex != -1 &&
            controller.moduleList[controller.selectedModuleIndex!].moduleType ==
                AppConstants.taxi;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              'choose_your_business_plan'.tr,
              style: context.style.s18w700.copyWith(
                color: context.color.primary,
              ),
            ),
            Row(
              spacing: 12,
              children: ['commission_base'.tr, 'subscription_base'.tr].map((e) {
                final isSelected =
                    (controller.isSubscriptionPlan &&
                        e == 'subscription_base'.tr) ||
                    (!controller.isSubscriptionPlan &&
                        e == 'commission_base'.tr);
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.isSubscriptionPlan =
                          e == 'subscription_base'.tr;
                      controller.update();
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? context.color.primary
                              : context.color.borderColor,
                        ),
                        color: context.color.whiteLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          e,
                          style: context.style.s18w700.copyWith(
                            color: isSelected ? context.color.primary : null,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                !controller.isSubscriptionPlan
                    ? 'run_vendor_by_purchasing_subscription_packages'.tr
                    : "${'vendor_will_pay'.tr} "
                          '${Get.find<GlobalController>().configModel!.adminCommission}% '
                          "${'commission_to'.tr} "
                          '${Get.find<GlobalController>().configModel!.businessName}'
                          " ${'from_each_order_You_will_get_access_of_all'.tr}",
                style: context.style.s16w700,
              ),
            ),
            if (controller.isSubscriptionPlan)
              SizedBox(
                height: 530,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 30),
                  itemCount:
                      controller.packageModel?.packages?.length.print as int? ??
                      0,
                  itemBuilder: (context, index) {
                    final packages = controller.packageModel?.packages?[index];
                    final isSelected = controller.selectedPlan == packages?.id;
                    return GestureDetector(
                      onTap: () {
                        controller
                          ..selectedPlan = packages?.id
                          ..update();
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width * .8,
                        ),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? context.color.primary
                                : context.color.borderColor,
                            width: 2,
                          ),
                          color: isSelected
                              ? Get.find<GlobalController>().isDark
                                    ? context.color.whiteLight
                                    : context.color.borderColor
                              : null,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Text(
                              packages?.packageName ?? '',
                              textAlign: TextAlign.center,
                              style: context.style.s20w900.copyWith(
                                color: context.color.ff6c6c6c,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                PriceConverter.convertPrice(packages?.price),
                                textAlign: TextAlign.center,
                                style: context.style.s30w700.copyWith(
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                ),
                              ),
                            ),
                            Text(
                              '${packages?.validity} '
                                      'days'
                                  .tr,
                              textAlign: TextAlign.center,
                              style: context.style.s14w600.copyWith(
                                color: context.color.ff9c9c9c,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Divider(color: context.color.borderColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    [
                                          (
                                            '${isRental ? 'max_trip'.tr : 'max_order'.tr}'
                                                ' (${packages?.maxOrder})',
                                            true,
                                          ),
                                          (
                                            '${isRental ? 'max_vehicle'.tr : 'max_product'.tr}'
                                                ' (${packages?.maxProduct})',
                                            true,
                                          ),
                                          ('pos'.tr, packages?.pos == 1),
                                          (
                                            'mobile_app'.tr,
                                            packages?.mobileApp == 1,
                                          ),
                                          ('chat'.tr, packages?.chat == 1),
                                          ('review'.tr, packages?.review == 1),
                                          (
                                            'self_delivery'.tr,
                                            packages?.selfDelivery == 1,
                                          ),
                                        ]
                                        .map(
                                          (e) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                spacing: 6,
                                                children: [
                                                  Icon(
                                                    !e.$2
                                                        ? Icons.close_rounded
                                                        : Icons.check_circle,
                                                    color:
                                                        context.color.primary,
                                                  ),
                                                  Text(e.$1),
                                                ],
                                              ),
                                              Container(
                                                width: 120,
                                                height: 1,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                    ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      context.color.primary
                                                          .withValues(
                                                            alpha: .5,
                                                          ),
                                                      context.color.white,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
