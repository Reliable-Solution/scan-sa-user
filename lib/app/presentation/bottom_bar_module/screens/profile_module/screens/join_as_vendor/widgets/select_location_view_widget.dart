import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/location_search_dialog_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/module_view_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/pickup_zone_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/widgets/zone_selection_widget.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_data_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/widgets/permission_dialog_widget.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class SelectLocationViewWidget extends StatefulWidget {
  const SelectLocationViewWidget({
    super.key,
    required this.fromView,
    this.mapController,
    this.mapView = false,
    this.zoneModuleView = false,
    this.addressController,
    this.addressFocus,
    this.inDialog = false,
  });
  final bool fromView;
  final bool mapView;
  final bool zoneModuleView;
  final GoogleMapController? mapController;
  final TextEditingController? addressController;
  final FocusNode? addressFocus;
  final bool inDialog;

  @override
  State<SelectLocationViewWidget> createState() =>
      _SelectLocationViewWidgetState();
}

class _SelectLocationViewWidgetState extends State<SelectLocationViewWidget> {
  late CameraPosition _cameraPosition;
  Set<Polygon> _polygons = {};
  GoogleMapController? _mapController;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreRegistrationController>(
      builder: (storeRegController) {
        if (storeRegController.storeAddress != null) {
          storeRegController.addressController.text = storeRegController
              .storeAddress
              .toString();
        }
        final isRentalModule =
            widget.fromView && storeRegController.moduleList.isNotEmpty;
        storeRegController.selectedModuleIndex != -1 &&
            storeRegController
                    .moduleList[storeRegController.selectedModuleIndex!]
                    .moduleType ==
                AppConstants.taxi;

        final zoneIndexList = <int>[];
        final zoneList = <String>[];
        if (storeRegController.zoneIds != null) {
          for (
            var index = 0;
            index < storeRegController.zoneList.length;
            index++
          ) {
            zoneIndexList.add(index);
            zoneList.add(storeRegController.zoneList[index].name ?? '');
          }
        }
        return Container(
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
          // decoration: widget.fromView
          //     ? BoxDecoration(
          //         color: Theme.of(context).cardColor,
          //         borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          //         boxShadow: const [
          //           BoxShadow(
          //             color: Colors.black12,
          //             blurRadius: 5,
          //             spreadRadius: 1,
          //           ),
          //         ],
          //       )
          //     : null,
          alignment: Alignment.center,
          height: widget.fromView ? null : context.height,
          padding: widget.fromView
              ? const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeDefault,
                )
              : EdgeInsets.zero,
          margin: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Padding(
              padding: EdgeInsets.all(widget.fromView ? 0 : 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    if (widget.fromView)
                      ZoneSelectionWidget(
                        storeRegController: storeRegController,
                        zoneList: zoneList,
                        callBack: () {
                          _setPolygon(
                            storeRegController.zoneList[storeRegController
                                .selectedZoneIndex!],
                          );
                        },
                      ),
                    const ModuleViewWidget(),
                    if (isRentalModule) const PickupZoneWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: mapView(storeRegController),
                    ),
                    if (!widget.fromView && !widget.inDialog)
                      AppButton(
                        label: 'set_location'.tr,
                        onPressed: () {
                          try {
                            widget.mapController!.moveCamera(
                              CameraUpdate.newCameraPosition(_cameraPosition),
                            );
                            Get.back();
                          } catch (_) {
                            Get.back();
                          }
                        },
                      ),
                    if (!storeRegController.inZone)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          '* ${'please_place_the_marker_inside_the_zone'.tr}',
                        ),
                      ),
                    if (widget.fromView)
                      AppTextField(
                        hintText: 'write_store_address'.tr,
                        controller: storeRegController.addressController,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget webView(
    StoreRegistrationController storeRegController,
    List<String> zoneList,
  ) {
    return Row(
      children: [
        if (widget.fromView && widget.zoneModuleView)
          const SizedBox()
        else
          const SizedBox(width: Dimensions.paddingSizeLarge),
        if (widget.fromView && widget.mapView)
          Expanded(
            child: Column(
              children: [
                ZoneSelectionWidget(
                  storeRegController: storeRegController,
                  zoneList: zoneList,
                  callBack: () {
                    _setPolygon(
                      storeRegController.zoneList[storeRegController
                          .selectedZoneIndex!],
                    );
                  },
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                mapView(storeRegController),
              ],
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }

  Widget mapView(StoreRegistrationController storeRegController) {
    return storeRegController.zoneList.isNotEmpty
        ? Center(
            child: Container(
              height: widget.fromView ? 150 : (context.height * 0.87),
              width: widget.inDialog
                  ? MediaQuery.of(context).size.width * 0.7
                  : MediaQuery.of(context).size.width,
              decoration: widget.fromView
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radiusDefault,
                      ),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    )
                  : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          double.parse(
                            Get.find<GlobalController>()
                                    .configModel!
                                    .defaultLocation!
                                    .lat ??
                                '0',
                          ),
                          double.parse(
                            Get.find<GlobalController>()
                                    .configModel!
                                    .defaultLocation!
                                    .lng ??
                                '0',
                          ),
                        ),
                        zoom: 16,
                      ),
                      minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      polygons: _polygons,
                      onCameraIdle: () {
                        storeRegController.setLocation(
                          _cameraPosition.target,
                          forStoreRegistration: true,
                          zoneId: storeRegController
                              .zoneList[storeRegController.selectedZoneIndex!]
                              .id,
                        );
                        if (!widget.fromView) {
                          widget.mapController!.moveCamera(
                            CameraUpdate.newCameraPosition(_cameraPosition),
                          );
                        }
                      },
                      onCameraMove: (position) => _cameraPosition = position,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                        _setPolygon(
                          storeRegController.zoneList[storeRegController
                              .selectedZoneIndex!],
                        );
                      },
                      myLocationButtonEnabled: false,
                      gestureRecognizers:
                          const <Factory<OneSequenceGestureRecognizer>>{
                            Factory<OneSequenceGestureRecognizer>(
                              EagerGestureRecognizer.new,
                            ),
                            Factory<PanGestureRecognizer>(
                              PanGestureRecognizer.new,
                            ),
                            Factory<ScaleGestureRecognizer>(
                              ScaleGestureRecognizer.new,
                            ),
                            Factory<TapGestureRecognizer>(
                              TapGestureRecognizer.new,
                            ),
                            Factory<VerticalDragGestureRecognizer>(
                              VerticalDragGestureRecognizer.new,
                            ),
                          },
                    ),
                    Center(
                      child: Image.asset(
                        AppIcons.markerStore,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Positioned(
                      top: widget.fromView ? 10 : 20,
                      left: widget.fromView ? 10 : 20,
                      right: widget.fromView ? null : 20,
                      child: InkWell(
                        onTap: () async {
                          final p = await Get.dialog(
                            LocationSearchDialogWidget(
                              mapController: _mapController,
                            ),
                          );
                          final position = p as Position?;
                          if (position != null) {
                            _cameraPosition = CameraPosition(
                              target: LatLng(
                                position.latitude,
                                position.longitude,
                              ),
                              zoom: 16,
                            );
                            if (!widget.fromView) {
                              await widget.mapController!.moveCamera(
                                CameraUpdate.newCameraPosition(_cameraPosition),
                              );
                              await storeRegController.setLocation(
                                _cameraPosition.target,
                                forStoreRegistration: true,
                                zoneId: storeRegController
                                    .zoneList[storeRegController
                                        .selectedZoneIndex!]
                                    .id,
                              );
                            }
                          }
                        },
                        child: Container(
                          height: widget.fromView ? 30 : 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusSmall,
                            ),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'search'.tr,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    if (widget.inDialog)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: Get.back,
                          icon: const Icon(Icons.clear, color: Colors.black),
                        ),
                      ),
                    // if (widget.fromView)
                    //   Positioned(
                    //     bottom: 50,
                    //     right: 0,
                    //     child: InkWell(
                    //       onTap: () {
                    //         if (storeRegController.selectedZoneIndex == -1) {
                    //           showCustomSnackBar('please_select_zone'.tr);
                    //         } else {
                    //           // Get.to(
                    //           //   Scaffold(
                    //           //     appBar: CustomAppBar(
                    //           //       title: 'set_your_store_location'.tr,
                    //           //     ),
                    //           //     body: SelectLocationViewWidget(
                    //           //       fromView: false,
                    //           //       mapController: _mapController,
                    //           //     ),
                    //           //   ),
                    //           // );
                    //         }
                    //       },
                    //       child: Container(
                    //         width: 30,
                    //         height: 30,
                    //         margin: const EdgeInsets.only(
                    //           right: Dimensions.paddingSizeDefault,
                    //         ),
                    //         decoration: const BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: Colors.white,
                    //         ),
                    //         child: const Icon(
                    //           Icons.fullscreen,
                    //           color: Colors.black,
                    //           size: 20,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    Positioned(
                      bottom: widget.fromView ? 10 : 210,
                      right: 0,
                      child: InkWell(
                        onTap: () => _checkPermission(() {
                          Get.find<LocationController>().getCurrentLocation(
                            false,
                          );
                        }),
                        child: Container(
                          padding: EdgeInsets.all(
                            widget.fromView
                                ? Dimensions.paddingSizeExtraSmall
                                : Dimensions.paddingSizeSmall,
                          ),
                          margin: const EdgeInsets.only(
                            right: Dimensions.paddingSizeDefault,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.my_location_outlined,
                            color: Colors.black,
                            size: widget.fromView ? 20 : 25,
                          ),
                        ),
                      ),
                    ),
                    if (!widget.fromView)
                      Positioned(
                        bottom: 100,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: Dimensions.paddingSizeDefault,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusDefault,
                            ),
                            color: Theme.of(context).cardColor,
                          ),
                          padding: const EdgeInsets.all(
                            Dimensions.paddingSizeSmall,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  var currentZoomLevel = await _mapController
                                      ?.getZoomLevel();
                                  currentZoomLevel = currentZoomLevel! + 1;
                                  await _mapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: _cameraPosition.target,
                                        zoom: currentZoomLevel,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.add, size: 25),
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () async {
                                  var currentZoomLevel = await _mapController
                                      ?.getZoomLevel();
                                  currentZoomLevel = currentZoomLevel! - 1;
                                  await _mapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: _cameraPosition.target,
                                        zoom: currentZoomLevel,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.remove, size: 25),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                    if (!widget.fromView)
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 20,
                        child: AppButton(
                          label: storeRegController.inZone
                              ? 'set_location'.tr
                              : 'not_in_zone'.tr,
                          onPressed: () => storeRegController.inZone
                              ? () {
                                  try {
                                    widget.mapController!.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                        _cameraPosition,
                                      ),
                                    );
                                    Get.back();
                                  } catch (e) {
                                    showCustomSnackBar(
                                      'please_setup_the_marker_in_your_required_location'
                                          .tr,
                                    );
                                  }
                                }
                              : null,
                        ),
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  void _setPolygon(ZoneDataModel zoneModel) {
    final polygonList = <Polygon>[];
    final zoneLatLongList = <LatLng>[];

    zoneModel.formatedCoordinates?.forEach((coordinate) {
      zoneLatLongList.add(
        LatLng(
          coordinate.lat?.toDouble() ?? 0,
          coordinate.lng?.toDouble() ?? 0,
        ),
      );
    });

    polygonList.add(
      Polygon(
        polygonId: PolygonId('${zoneModel.id!}'),
        points: zoneLatLongList,
        strokeWidth: 2,
        strokeColor: Colors.black45,
        fillColor: Colors.black.withValues(alpha: .1),
      ),
    );

    _polygons = HashSet<Polygon>.of(polygonList);

    Future.delayed(const Duration(milliseconds: 500), () {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          boundsFromLatLngList(zoneLatLongList),
          100.5,
        ),
      );
    });

    setState(() {});
  }

  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0;
    double? x1;
    double? y0;
    double? y1;
    for (final latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1 ?? 0, y1 ?? 0),
      southwest: LatLng(x0 ?? 0, y0 ?? 0),
    );
  }

  Future<void> _checkPermission(Function onTap) async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
    } else if (permission == LocationPermission.deniedForever) {
      await Get.dialog(const PermissionDialogWidget());
    } else {
      onTap();
    }
  }
}
