import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class VendorInfoWidget extends StatelessWidget {
  const VendorInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreRegistrationController>(
      builder: (storeController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'vendor_info'.tr,
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
                    hintText: 'vendor_name'.tr,
                    controller: storeController.vendorName,
                  ),
                  Row(
                    spacing: 10,
                    children:
                        [
                              (
                                "${'vendor_logo'.tr} (${'1:1'})",
                                storeController.pickedLogo,
                                'upload_vendor_logo'.tr,
                                () {
                                  storeController.pickImage(true, false);
                                },
                                4,
                              ),
                              (
                                "${'vendor_cover'.tr} (${'3:1'})",
                                storeController.pickedCover,
                                '${'upload_vendor_cover'.tr}/n${'upload_jpg_png_gif_maximum_2_mb'.tr}',
                                () => storeController.pickImage(false, false),
                                6,
                              ),
                            ]
                            .map(
                              (e) => Expanded(
                                flex: e.$5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 6,
                                  children: [
                                    Text(e.$1, style: context.style.s14w600),
                                    Align(
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    Dimensions.radiusSmall,
                                                  ),
                                              child: e.$2 != null
                                                  ? GetPlatform.isWeb
                                                        ? Image.network(
                                                            e.$2!.path,
                                                            width:
                                                                double.infinity,
                                                            height: 120,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.file(
                                                            File(e.$2!.path),
                                                            width:
                                                                double.infinity,
                                                            height: 120,
                                                            fit: BoxFit.cover,
                                                          )
                                                  : SizedBox(
                                                      width: double.infinity,
                                                      height: 120,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .photo_camera_solid,
                                                            size: 30,
                                                            color: context
                                                                .color
                                                                .lightText,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      Dimensions
                                                                          .paddingSizeSmall,
                                                                ),
                                                            child: Text(
                                                              e.$3,
                                                              style: context
                                                                  .style
                                                                  .s12w700
                                                                  .copyWith(
                                                                    color: context
                                                                        .color
                                                                        .lightText,
                                                                  ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            top: 0,
                                            left: 0,
                                            child: InkWell(
                                              onTap: () => e.$4(),
                                              child: DottedBorder(
                                                options:
                                                    RoundedRectDottedBorderOptions(
                                                      color: Theme.of(
                                                        context,
                                                      ).primaryColor,
                                                      dashPattern: const [5, 5],
                                                      padding: EdgeInsets.zero,

                                                      radius:
                                                          const Radius.circular(
                                                            Dimensions
                                                                .radiusDefault,
                                                          ),
                                                    ),
                                                child: Center(
                                                  child: Visibility(
                                                    visible: e.$2 != null,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            25,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 2,
                                                          color: Colors.white,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        CupertinoIcons
                                                            .photo_camera_solid,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
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
