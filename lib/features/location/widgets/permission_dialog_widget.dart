import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class PermissionDialogWidget extends StatelessWidget {
  const PermissionDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      ),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_location_alt_rounded,
                color: context.color.secondary,
                size: 100,
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Text(
                'you_denied_location_permission'.tr,
                textAlign: TextAlign.center,
                style:
                    robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSmall),
                          side: BorderSide(
                            width: 2,
                            color: context.color.secondary,
                          ),
                        ),
                        minimumSize: const Size(1, 50),
                      ),
                      child: Text('close'.tr),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(
                    child: AppButton(
                      buttonText: 'settings'.tr,
                      onPressed: () async {
                        await Geolocator.openAppSettings();
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
