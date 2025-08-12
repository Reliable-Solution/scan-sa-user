import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_drop_down.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class ZoneSelectionWidget extends StatelessWidget {
  const ZoneSelectionWidget({
    super.key,
    required this.storeRegController,
    required this.zoneList,
    required this.callBack,
  });
  final StoreRegistrationController storeRegController;
  final List<String> zoneList;
  final Function() callBack;

  @override
  Widget build(BuildContext context) {
    return storeRegController.zoneIds != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'select_module'.tr,
                style: context.style.s16w500.copyWith(
                  color: context.color.ff6c6c6c,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppDropDown(
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                backColor: context.color.whiteLight,
                style: context.style.s14w700.copyWith(
                  color: context.color.primary,
                ),
                hintStyle: context.style.s14w600.copyWith(
                  color: Get.find<GlobalController>().isDark
                      ? context.color.ff6c6c6c
                      : context.color.ff455A64,
                ),
                itemList: storeRegController.zoneList
                    .map((e) => e.name ?? '')
                    .toList(),
                child: Text.new,
                selectedItem: storeRegController.selectedZoneIndex != -1
                    ? storeRegController
                          .zoneList[storeRegController.selectedZoneIndex ?? 0]
                          .name
                    : null,
                onChanged: (String? value) {
                  final index = storeRegController.zoneList.indexWhere(
                    (element) => element.name == value,
                  );
                  if (index != -1) {
                    storeRegController
                      ..setZoneIndex(index)
                      ..pickupZoneIdList.clear()
                      ..pickupZoneList.clear();
                    callBack();
                  }
                },
              ),
            ],
          )
        : Center(child: Text('service_not_available_in_this_area'.tr));
  }
}
