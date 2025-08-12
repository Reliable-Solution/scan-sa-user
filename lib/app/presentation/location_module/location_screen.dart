import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.isBack});
  final bool isBack;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final locationController = Get.put(
    LocationController(locationServiceInterface: Get.find()),
  );
  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (locationController.addressList.isEmpty ||
          locationController.isFromSplash.value) {
        locationController.getAddressList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GetBuilder<LocationController>(
        builder: (locationController) => Scaffold(
          // appBar: AppBar(title: Text('pickAddress'.tr)),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(24.735675, 46.660686),
                        zoom: 14,
                      ),
                      mapType: Get.find<GlobalController>().isDark
                          ? MapType.satellite
                          : MapType.normal,
                      markers: locationController.marker.toSet(),
                      zoomControlsEnabled: false,
                      onTap: (latLong) =>
                          locationController.addMarker(latLong, isLoad: true),
                      onMapCreated: (controller) {
                        locationController
                          ..mapController = controller
                          ..update();
                      },
                    ),
                    Positioned(
                      top: MediaQuery.paddingOf(context).top + 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'pickAddress'.tr,
                          style: context.style.s24w900,
                        ),
                      ),
                    ),
                    if ((!locationController.isFromSplash.value ||
                            locationController.isSearch.value) &&
                        widget.isBack)
                      Positioned(
                        top: MediaQuery.paddingOf(context).top + 10,
                        left: 10,
                        child: IconButton(
                          onPressed: locationController.isSearch.value
                              ? () {
                                  locationController
                                    ..isSearch.value = false
                                    ..update();
                                }
                              : Get.back,
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
                                  label:
                                      Get.find<GlobalController>().isGuestMode
                                      ? 'Select'
                                      : 'Add address',
                                  btnColor:
                                      locationController.buttonDisabled.value
                                      ? context.color.darkTextGrey
                                      : null,
                                  onPressed: () async {
                                    if (Get.find<GlobalController>()
                                        .isGuestMode) {
                                      if (locationController.addressModel !=
                                          null) {
                                        await AddressHelper.saveUserAddressInSharedPref(
                                          locationController.addressModel!,
                                        );
                                        if (widget.isBack) {
                                          Get.back();
                                        } else {
                                          AppPages.bottomBarScreen.offAll();
                                        }
                                      }
                                      return;
                                    }

                                    locationController
                                      ..addressController.text =
                                          locationController
                                              .addressModel
                                              ?.address ??
                                          ''
                                      ..additionalController.text =
                                          locationController
                                              .addressModel
                                              ?.additionalAddress ??
                                          ''
                                      ..contactPersonNameController.text =
                                          locationController
                                              .addressModel
                                              ?.contactPersonName ??
                                          ''
                                      ..contactPersonNumberController.text =
                                          locationController
                                              .addressModel
                                              ?.contactPersonNumber ??
                                          ''
                                      ..streetNumberController.text =
                                          locationController
                                              .addressModel
                                              ?.streetNumber ??
                                          ''
                                      ..houserNumberController.text =
                                          locationController
                                              .addressModel
                                              ?.house ??
                                          ''
                                      ..floorNumberController.text =
                                          locationController
                                              .addressModel
                                              ?.floor ??
                                          '';

                                    locationController.buttonDisabled.value
                                        ? null
                                        : AppPages.editAddressScreen.push();
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
                                          locationController.getZone(
                                            address.latitude,
                                            address.longitude,
                                            true,
                                          );
                                          if (locationController
                                              .isFromSplash
                                              .value) {
                                            AppPages.bottomBarScreen.offAll();
                                          } else {
                                            Get.back();
                                          }
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
                                                        id: address.id,
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

              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: AppSizes.appPadding,
              //     right: AppSizes.appPadding,
              //   ),
              //   child: GestureDetector(
              //     onTap: () => Get.find<LocationController>().checkPermission(() {
              //       Get.find<LocationController>().getCurrentLocation(false);
              //     }),
              //     child: CircleAvatar(
              //       backgroundColor: context.color.white,
              //       child: Icon(
              //         Icons.my_location,
              //         color: context.color.primary,
              //         size: 20,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
