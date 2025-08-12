import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/controllers/deliveryman_registration_controller.dart';
import 'package:scan_sa_user/app/widgets/app_drop_down.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class DeliveryRegSecondScreen extends StatefulWidget {
  const DeliveryRegSecondScreen({super.key});

  @override
  State<DeliveryRegSecondScreen> createState() =>
      _DeliveryRegSecondScreenState();
}

class _DeliveryRegSecondScreenState extends State<DeliveryRegSecondScreen> {
  final deliverymanRegistrationController =
      Get.find<DeliverymanRegistrationController>();

  @override
  void initState() {
    for (
      var index = 0;
      index < deliverymanRegistrationController.dmTypeList.length;
      index++
    ) {
      dmTypeList.add(
        deliverymanRegistrationController.dmTypeList[index]?.tr ?? '',
      );
    }
    for (
      var index = 0;
      index < deliverymanRegistrationController.identityTypeList.length;
      index++
    ) {
      identityTypeList.add(
        deliverymanRegistrationController.identityTypeList[index].tr,
      );
    }
    if (deliverymanRegistrationController.zoneList != null) {
      for (
        var index = 0;
        index < deliverymanRegistrationController.zoneList!.length;
        index++
      ) {
        zoneIndexList.add(index);
        zoneList.add(
          deliverymanRegistrationController.zoneList?[index].name ?? '',
        );
      }
    }
    if (deliverymanRegistrationController.vehicles != null) {
      for (
        var index = 0;
        index < deliverymanRegistrationController.vehicles!.length;
        index++
      ) {
        vehicleList.add(
          deliverymanRegistrationController.vehicles?[index].type ?? '',
        );
      }
    }
    super.initState();
  }

  final zoneIndexList = <int>[];
  final zoneList = <String>[];
  final vehicleList = <String>[];
  final dmTypeList = <String>[];
  final identityTypeList = <String>[];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliverymanRegistrationController>(
      builder: (controller) {
        return Column(
          children: [
            AppDropDown(
              itemList: dmTypeList,
              hint: 'select_delivery_type'.tr,
              selectedItem: controller.dmTypeIndex == -1
                  ? null
                  : dmTypeList[controller.dmTypeIndex],
              backColor: context.color.whiteLight,
              hintStyle: context.style.s14w600.copyWith(
                color: context.color.ff455A64,
              ),
              onChanged: (value) {
                final index = dmTypeList.indexWhere(
                  (element) => element == value,
                );
                controller.setDMTypeIndex(index, true);
              },
              child: Text.new,
            ),
            if (deliverymanRegistrationController.zoneList?.isNotEmpty ?? false)
              AppDropDown(
                itemList: zoneList,
                hint: 'select_delivery_type'.tr,
                selectedItem: controller.selectedZoneIndex == -1
                    ? null
                    : zoneList[controller.selectedZoneIndex],
                backColor: context.color.whiteLight,
                hintStyle: context.style.s14w600.copyWith(
                  color: context.color.ff455A64,
                ),
                onChanged: (value) {
                  final index = zoneList.indexWhere(
                    (element) => element == value,
                  );
                  controller.setZoneIndex(index);
                },
                child: Text.new,
              ),
            if (vehicleList.isNotEmpty)
              AppDropDown(
                itemList: vehicleList,
                hint: 'select_delivery_type'.tr,
                selectedItem: controller.dmTypeIndex == -1
                    ? null
                    : vehicleList[controller.vehicleIndex],
                backColor: context.color.whiteLight,
                hintStyle: context.style.s14w600.copyWith(
                  color: context.color.ff455A64,
                ),
                onChanged: (value) {
                  final index = vehicleList.indexWhere(
                    (element) => element == value,
                  );
                  controller.setVehicleIndex(index, true);
                },
                child: Text.new,
              ),
            if (identityTypeList.isNotEmpty)
              AppDropDown(
                itemList: identityTypeList,
                hint: 'select_delivery_type'.tr,
                selectedItem: identityTypeList[controller.identityTypeIndex],
                backColor: context.color.whiteLight,
                hintStyle: context.style.s14w600.copyWith(
                  color: context.color.ff455A64,
                ),
                onChanged: (value) {
                  final index = identityTypeList.indexWhere(
                    (element) => element == value,
                  );
                  controller.setIdentityTypeIndex(index, true);
                },
                child: Text.new,
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AppTextField(
                hintText: '${'identity_number'.tr}*',
                controller: controller.identityNumberController,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 10),
              itemCount:
                  deliverymanRegistrationController.pickedIdentities.length + 1,
              itemBuilder: (context, index) {
                final file =
                    index ==
                        deliverymanRegistrationController
                            .pickedIdentities
                            .length
                    ? null
                    : deliverymanRegistrationController.pickedIdentities[index];
                if (index ==
                    deliverymanRegistrationController.pickedIdentities.length) {
                  return InkWell(
                    onTap: () => deliverymanRegistrationController.pickDmImage(
                      false,
                      false,
                    ),
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        color: Theme.of(context).primaryColor,
                        dashPattern: const [5, 5],
                        padding: const EdgeInsets.all(5),

                        // borderType: BorderType.RRect,
                        radius: const Radius.circular(20),
                      ),
                      child: SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Theme.of(context).disabledColor,
                              size: 38,
                            ),
                            Text('upload_identity_image'.tr),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      color: Theme.of(context).primaryColor,
                      dashPattern: const [5, 5],
                      padding: const EdgeInsets.all(5),

                      radius: const Radius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GetPlatform.isWeb
                              ? Image.network(
                                  file!.path,
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(file!.path),
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: () => deliverymanRegistrationController
                                .removeIdentityImage(index),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
