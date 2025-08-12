import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/custom_time_picker_widget.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class VendorPreferenceWidget extends StatelessWidget {
  const VendorPreferenceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreRegistrationController>(
      builder: (storeController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'vendor_preference'.tr,
              style: context.style.s18w700.copyWith(
                color: context.color.primary,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.color.whiteLight,
                boxShadow: [
                  BoxShadow(
                    color: context.color.primary.withValues(alpha: .1),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 8, bottom: 20),
              child: Column(
                spacing: 8,
                children: [
                  AppTextField(
                    hintText: 'write_vat_tax_amount'.tr,
                    controller: storeController.vatController,
                  ),
                  InkWell(
                    onTap: () {
                      Get.dialog(const CustomTimePickerWidget());
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: context.color.whiteLight,
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusDefault,
                            ),
                            border: Border.all(
                              color: context.color.borderColor,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${storeController.storeMinTime} : ${storeController.storeMaxTime} ${storeController.storeTimeUnit}',
                                  // style: robotoMedium,
                                ),
                              ),
                              Icon(
                                Icons.access_time_filled,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: -15,
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.color.whiteLight,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'select_time'.tr,
                              // style: robotoRegular.copyWith(
                              //   color: Theme.of(context).disabledColor,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
