import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/location_module/edit_map_screen.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key, required this.isEdit});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final locationController = Get.find<LocationController>();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (isEdit) {
          locationController
            ..isSearch.value = false
            ..update();
        }
        locationController
          ..contactPersonNameController.clear()
          ..contactPersonNumberController.clear()
          ..streetNumberController.clear()
          ..houserNumberController.clear()
          ..floorNumberController.clear()
          ..addressController.clear()
          ..additionalController.clear();
      },
      child: Form(
        child: Builder(
          builder: (context) {
            return CommonSubScreen(
              appBarTitle: isEdit
                  ? context.l10n.editAddress
                  : context.l10n.addAddress,
              btnText: context.l10n.saveLocation,
              onTap: () => locationController.addAddress(context, isEdit),
              child: Obx(
                () => ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                    vertical: 20,
                  ),
                  children: [
                    // Row(
                    //   spacing: 10,
                    //   children: [
                    //     const Icon(Icons.subdirectory_arrow_right_rounded),
                    //     Expanded(
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             locationController.addressModel?.address ?? '',
                    //             style: context.style.s14w600.copyWith(
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //           if (locationController
                    //                   .addressModel
                    //                   ?.additionalAddress
                    //                   ?.isNotEmpty ??
                    //               false)
                    //             Text(
                    //               locationController
                    //                       .addressModel
                    //                       ?.additionalAddress ??
                    //                   '',
                    //               style: context.style.s16w700.copyWith(
                    //                 color: context.color.darkTextGrey,
                    //               ),
                    //             ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        context.l10n.labelAs,
                        style: context.style.s20w900.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children:
                          [
                            AppIcons.homeAddressIc,
                            AppIcons.officeAddressIc,
                            AppIcons.otherAddressIc,
                          ].map((e) {
                            final isSelected =
                                locationController.addressLabel.value == e;

                            return GestureDetector(
                              onTap: () =>
                                  locationController.changeAddressLabel(e),
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? context.color.primary
                                        : context.color.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: SvgAssets(
                                  e,
                                  color: isSelected
                                      ? context.color.primary
                                      : context.color.darkTextGrey,
                                  width: 30,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      hintText: context.l10n.address,
                      controller: locationController.addressController,
                      validator: (p0) => AppValidations.emptyFieldValidation(
                        p0,
                        'Please enter your address',
                      ),
                    ),
                    AppTextField(
                      hintText: context.l10n.contactPersonName,
                      controller:
                          locationController.contactPersonNameController,
                      validator: (p0) => AppValidations.emptyFieldValidation(
                        p0,
                        'Please enter contact person name',
                      ),
                    ),
                    AppTextField(
                      hintText: context.l10n.contactPersonNumber,
                      controller:
                          locationController.contactPersonNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (p0) => AppValidations.emptyFieldValidation(
                        p0,
                        'Please enter contact person number',
                      ),
                    ),
                    AppTextField(
                      hintText: context.l10n.streetNumberOptional,
                      controller: locationController.streetNumberController,
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: AppTextField(
                            hintText: context.l10n.houseOptional,
                            controller:
                                locationController.houserNumberController,
                          ),
                        ),
                        Expanded(
                          child: AppTextField(
                            hintText: context.l10n.floorOptional,
                            controller:
                                locationController.floorNumberController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 8),
                      child: Text(
                        context.l10n.googleMap,
                        style: context.style.s20w900.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            GoogleMap(
                              scrollGesturesEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  double.tryParse(
                                        locationController
                                                .addressModel
                                                ?.latitude ??
                                            '0.0',
                                      ) ??
                                      0,
                                  double.tryParse(
                                        locationController
                                                .addressModel
                                                ?.longitude ??
                                            '0.0',
                                      ) ??
                                      0,
                                ),
                                zoom: 14,
                              ),
                              markers: locationController.marker.toSet(),
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              myLocationButtonEnabled: false,
                              zoomGesturesEnabled: false,
                              onMapCreated: (controller) {
                                locationController
                                  ..mapController2 = controller
                                  ..update();
                              },
                            ),
                            if (isEdit)
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () => Get.to(
                                    EditMapScreen(
                                      initialLatLng: LatLng(
                                        double.tryParse(
                                              locationController
                                                      .addressModel
                                                      ?.latitude ??
                                                  '0.0',
                                            ) ??
                                            0,
                                        double.tryParse(
                                              locationController
                                                      .addressModel
                                                      ?.longitude ??
                                                  '0.0',
                                            ) ??
                                            0,
                                      ),
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 18,
                                    child: Icon(Icons.expand, size: 18),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
