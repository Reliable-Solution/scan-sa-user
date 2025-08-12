import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CustomTimePickerWidget extends StatelessWidget {
  const CustomTimePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final time = <String>[];
    for (var i = 1; i <= 60; i++) {
      time.add(i.toString());
    }
    final unit = <String>['minute', 'hours', 'days'];

    final storeRegController = Get.find<StoreRegistrationController>();

    final isRental =
        storeRegController.selectedModuleIndex != -1 &&
        storeRegController
                .moduleList[storeRegController.selectedModuleIndex!]
                .moduleType ==
            AppConstants.taxi;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
      ),
      backgroundColor: context.color.whiteLight,
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: GetBuilder<StoreRegistrationController>(
          builder: (storeRegController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isRental
                      ? 'estimated_pickup_time_time'.tr
                      : 'estimated_delivery_time'.tr,
                  style: context.style.s18w700.copyWith(
                    color: context.color.primary,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall,
                  ),
                  child: Text(
                    'this_item_will_be_shown_in_the_user_app_website'.tr,
                    style: context.style.s16w500.copyWith(
                      color: context.color.ff6c6c6c,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        'minimum'.tr,
                        style: context.style.s14w600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(),

                    SizedBox(
                      width: 70,
                      child: Text(
                        'maximum'.tr,
                        style: context.style.s14w600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        'unit'.tr,
                        style: context.style.s14w600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MinMaxTimePickerWidget(
                      times: time,
                      onChanged: (int index) =>
                          storeRegController.minTimeChange(time[index]),
                      initialPosition: 10,
                    ),

                    const Text(':'),

                    MinMaxTimePickerWidget(
                      times: time,
                      onChanged: (int index) =>
                          storeRegController.maxTimeChange(time[index]),
                      initialPosition: 10,
                    ),

                    MinMaxTimePickerWidget(
                      times: unit,
                      onChanged: (int index) =>
                          storeRegController.timeUnitChange(unit[index]),
                      initialPosition: 1,
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeLarge,
                  ),
                  child: Text(
                    '${storeRegController.storeMinTime} - ${storeRegController.storeMaxTime} ${storeRegController.storeTimeUnit}',
                    style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge),
                  ),
                ),

                AppButton(
                  label: 'save'.tr,
                  onPressed: () {
                    int? min;
                    int? max;
                    try {
                      min = int.parse(storeRegController.storeMinTime);
                      max = int.parse(storeRegController.storeMaxTime);
                    } catch (e) {
                      log(e.toString());
                    }

                    if (min == null) {
                      showCustomSnackBar(
                        isRental
                            ? 'minimum_pickup_time_can_not_be_empty'
                            : 'minimum_delivery_time_can_not_be_empty'.tr,
                      );
                    } else if (max == null) {
                      showCustomSnackBar(
                        isRental
                            ? 'maximum_pickup_time_can_not_be_empty'
                            : 'maximum_delivery_time_can_not_be_empty'.tr,
                      );
                    } else if (storeRegController.storeTimeUnit.isEmpty) {
                      showCustomSnackBar('time_unit_can_not_be_empty'.tr);
                    } else if (min < max) {
                      Get.back();
                    } else {
                      showCustomSnackBar(
                        isRental
                            ? 'maximum_pickup_time_can_not_be_smaller_then_minimum_pickup_time'
                            : 'maximum_delivery_time_can_not_be_smaller_then_minimum_delivery_time'
                                  .tr,
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MinMaxTimePickerWidget extends StatefulWidget {
  const MinMaxTimePickerWidget({
    super.key,
    required this.times,
    required this.onChanged,
    required this.initialPosition,
  });
  final List<String> times;
  final Function(int index) onChanged;
  final int initialPosition;

  @override
  State<MinMaxTimePickerWidget> createState() => _MinMaxTimePickerWidgetState();
}

class _MinMaxTimePickerWidgetState extends State<MinMaxTimePickerWidget> {
  int selectedIndex = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: context.color.borderColor, width: 0.5),
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          enlargeCenterPage: true,
          disableCenter: true,
          viewportFraction: 0.3,
          initialPage: widget.initialPosition,
          autoPlayInterval: const Duration(seconds: 7),
          onPageChanged: (index, reason) {
            setState(() {
              selectedIndex = index;
            });
            widget.onChanged(index);
          },
          scrollDirection: Axis.vertical,
        ),
        itemCount: widget.times.length,
        itemBuilder: (context, index, _) {
          return Container(
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                  : Colors.transparent,
            ),
            child: Center(
              child: Text(
                widget.times[index],
                style: selectedIndex == index
                    ? TextStyle(fontSize: Dimensions.fontSizeExtraLarge)
                    : TextStyle(fontSize: Dimensions.fontSizeSmall),
              ),
            ),
          );
        },
      ),
    );
  }
}
