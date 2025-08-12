import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_drop_down.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class PickupZoneWidget extends StatelessWidget {
  const PickupZoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreRegistrationController>(
      builder: (storeRegistrationController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDropDown(
              margin: const EdgeInsets.only(bottom: 10),
              itemList: storeRegistrationController.zoneList
                  .map((e) => e.name ?? '')
                  .toList(),
              hint: 'select_pick_zone'.tr,
              backColor: context.color.whiteLight,
              style: context.style.s14w700.copyWith(
                color: context.color.primary,
              ),
              hintStyle: context.style.s14w600.copyWith(
                color: Get.find<GlobalController>().isDark
                    ? context.color.ff6c6c6c
                    : context.color.ff455A64,
              ),
              child: Text.new,
              selectedItem: null,
              onChanged: (value) {
                final selectedZone = storeRegistrationController.zoneList
                    .firstWhere((zone) => zone.name == value);
                storeRegistrationController.setSelectedPickupZone(
                  selectedZone.name,
                  selectedZone.id,
                );
              },
            ),
            Wrap(
              children: List.generate(
                storeRegistrationController.pickupZoneList.length,
                (index) {
                  final zoneName =
                      storeRegistrationController.pickupZoneList[index];
                  final zoneId =
                      storeRegistrationController.pickupZoneIdList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: Dimensions.paddingSizeSmall,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        FilterChip(
                          label: Text(zoneName),
                          onSelected: (bool value) {},
                        ),
                        Positioned(
                          right: -5,
                          top: 0,
                          child: InkWell(
                            onTap: () {
                              storeRegistrationController.removePickupZone(
                                zoneName,
                                zoneId,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.red),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 15,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
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
