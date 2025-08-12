import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class EditMapScreen extends StatelessWidget {
  const EditMapScreen({super.key, required this.initialLatLng});
  final LatLng initialLatLng;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GetBuilder<LocationController>(
        builder: (locationController) => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: initialLatLng,
                        zoom: 14,
                      ),
                      markers: locationController.marker.toSet(),
                      zoomControlsEnabled: false,
                      onTap: (latLong) => locationController.addMarker(
                        latLong,
                        isLoad: true,
                        isEdit: true,
                        id: locationController.addressModel?.id,
                      ),
                      onMapCreated: (controller) {
                        locationController
                          ..mapController = controller
                          ..update();
                      },
                    ),
                    Positioned(
                      top: MediaQuery.paddingOf(context).top + 10,
                      left: AppSizes.appPadding,
                      child: IconButton(
                        onPressed: Get.back,
                        icon: const CircleAvatar(
                          child: Icon(Icons.close_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if ((locationController.addressList.isNotEmpty) ||
                  locationController.isSearch.value)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height * .4,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: context.color.white,
                    ),
                    padding: EdgeInsets.all(AppSizes.appPadding),
                    child: locationController.isSearch.value
                        ? (locationController.buttonDisabled.value)
                              ? Text(
                                  'Out of delivery address',
                                  style: context.style.s20w900.copyWith(
                                    color: context.color.darkTextGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : AppButton(
                                  label: 'Select',
                                  btnColor:
                                      locationController.buttonDisabled.value
                                      ? context.color.darkTextGrey
                                      : null,
                                  onPressed: () {
                                    locationController.mapController2
                                        ?.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                              target: LatLng(
                                                double.parse(
                                                  locationController
                                                          .addressModel!
                                                          .latitude ??
                                                      '0',
                                                ),
                                                double.parse(
                                                  locationController
                                                          .addressModel!
                                                          .longitude ??
                                                      '0',
                                                ),
                                              ),
                                              zoom: 15,
                                            ),
                                          ),
                                        );
                                    Get.back();
                                  },
                                )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Where shall we deliver to?',
                                  style: context.style.s22w700,
                                ),
                                ...locationController.addressList.map(
                                  (address) => Column(
                                    spacing: 10,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          AddressHelper.saveUserAddressInSharedPref(
                                            address,
                                          );
                                          Get.back();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            top: 15,
                                          ),
                                          color: Colors.transparent,
                                          child: Row(
                                            spacing: 10,
                                            children: [
                                              const Icon(
                                                Icons.home_rounded,
                                                size: 30,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      address.contactPersonName ??
                                                          '',
                                                      style:
                                                          context.style.s16w700,
                                                    ),
                                                    Text(
                                                      address.address ?? '',
                                                      style: context
                                                          .style
                                                          .s14w600
                                                          .copyWith(
                                                            color: context
                                                                .color
                                                                .darkTextGrey,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await locationController
                                                      .addMarker(
                                                        LatLng(
                                                          double.parse(
                                                            address.latitude ??
                                                                '0',
                                                          ),
                                                          double.parse(
                                                            address.longitude ??
                                                                '0',
                                                          ),
                                                        ),
                                                        isLoad: true,
                                                        isEdit: true,
                                                        addressModel: address,
                                                      );
                                                  AppPages.editAddressScreen
                                                      .push(arguments: true);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      context.color.grey,
                                                  radius: 15,
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 15,
                                                    color:
                                                        context.color.primary,
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
                              ].toList(),
                            ),
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
