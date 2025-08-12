import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_drop_down.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class ModuleViewWidget extends StatelessWidget {
  const ModuleViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreRegistrationController>(
      builder: (storeRegController) {
        final moduleIndexList = <int>[];
        final moduleList = <String>[];
        if (storeRegController.moduleList.isNotEmpty) {
          for (
            var index = 0;
            index < storeRegController.moduleList.length;
            index++
          ) {
            if (storeRegController.moduleList[index].moduleType != 'parcel') {
              moduleIndexList.add(index);
              moduleList.add(
                storeRegController.moduleList[index].moduleName ?? '',
              );
            }
          }
        }

        return storeRegController.moduleList.isNotEmpty
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
                    itemList: moduleList.map((e) => e).toList(),
                    child: Text.new,
                    selectedItem: storeRegController.selectedModuleIndex != -1
                        ? moduleList[storeRegController.selectedModuleIndex ??
                              0]
                        : null,
                    onChanged: (String? value) {
                      final index = moduleList.indexWhere(
                        (element) => element == value,
                      );
                      if (index != -1) {
                        storeRegController.selectModuleIndex(index);
                        Get.find<StoreRegistrationController>().getPackageList(
                          moduleId: storeRegController.moduleList[index].id,
                        );
                      }
                    },
                  ),
                ],
              )
            : Center(child: Text('not_available_module'.tr));
      },
    );
  }
}
