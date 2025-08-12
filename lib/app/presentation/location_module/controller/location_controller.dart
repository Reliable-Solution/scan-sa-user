import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/prediction_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/services/location_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class LocationController extends GetxController {
  LocationController({required this.locationServiceInterface});
  final LocationServiceInterface locationServiceInterface;

  final contactPersonNameController = TextEditingController();
  final contactPersonNumberController = TextEditingController();
  final streetNumberController = TextEditingController();
  final houserNumberController = TextEditingController();
  final floorNumberController = TextEditingController();
  final addressController = TextEditingController();
  final additionalController = TextEditingController();

  GoogleMapController? mapController;
  GoogleMapController? mapController2;

  final RxBool _isFromSplash = false.obs;
  RxBool get isFromSplash => _isFromSplash;

  bool _inZone = false;
  bool get inZone => _inZone;

  int _zoneID = 0;
  int get zoneID => _zoneID;

  String? _address = '';
  String? get address => _address;

  String? _pickAddress = '';
  String? get pickAddress => _pickAddress;

  RxBool buttonDisabled = false.obs;

  final RxBool _isSearch = false.obs;
  RxBool get isSearch => _isSearch;

  List<AddressModel> addressList = [];

  AddressModel? _addressModel;
  AddressModel? get addressModel => _addressModel;

  final bool _isAddressLoading = false;
  bool get isAddressLoading => _isAddressLoading;

  // final Set<Marker> _marker = {};
  RxList<Marker> marker = <Marker>[].obs;

  Position _position = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
    altitudeAccuracy: 1,
    headingAccuracy: 1,
  );
  Position get position => _position;

  Position _pickPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
    altitudeAccuracy: 1,
    headingAccuracy: 1,
  );
  Position get pickPosition => _pickPosition;

  Future<void> checkPermission(Function onTap) async {
    locationServiceInterface.checkLocationPermission(onTap);
  }

  /// add marker to my location
  Future<void> addMarker(
    LatLng latLng, {
    bool isLoad = false,
    bool isEdit = false,
    int? id,
    AddressModel? addressModel,
  }) async {
    EasyLoading.load();
    (
      'Marker Added: ${_addressModel?.latitude}, ${_addressModel?.longitude}',
    ).print;
    if (isLoad) {
      final addressFromGeocode = await getAddressFromGeocode(latLng);
      _addressModel =
          addressModel ?? await _getAddressModel(latLng, addressFromGeocode)
            ..id = id;
      _isSearch.value = true;
    }
    if (isEdit) {
      contactPersonNameController.text =
          _addressModel?.contactPersonName ?? contactPersonNameController.text;
      contactPersonNumberController.text =
          _addressModel?.contactPersonNumber ??
          contactPersonNumberController.text;
      streetNumberController.text =
          _addressModel?.streetNumber ?? streetNumberController.text;
      houserNumberController.text =
          _addressModel?.house ?? houserNumberController.text;
      floorNumberController.text =
          _addressModel?.floor ?? floorNumberController.text;
      addressController.text = _addressModel?.address ?? addressController.text;
      additionalController.text =
          _addressModel?.additionalAddress ?? additionalController.text;
      addressLabel.value = switch (_addressModel?.addressType) {
        'Home' => AppIcons.homeAddressIc,
        'Office' => AppIcons.officeAddressIc,
        _ => AppIcons.otherAddressIc,
      };
    }
    marker
      ..clear()
      ..add(Marker(markerId: const MarkerId('location'), position: latLng));
    // await mapController?.animateCamera( 24.680637819256425, 46.70330196619034
    //   CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 15)),
    // );

    (
      'Marker Added: ${_addressModel?.latitude}, ${_addressModel?.longitude}',
    ).print;
    update();
    EasyLoading.dismiss();
  }

  Future<AddressModel> getCurrentLocation(
    bool fromAddress, {
    LatLng? defaultLatLng,
    bool notify = true,
  }) async {
    EasyLoading.load();
    AddressModel addressModel;
    final myPosition = await locationServiceInterface.getPosition(
      defaultLatLng,
      LatLng(
        double.parse(
          Get.find<GlobalController>().configModel!.defaultLocation!.lat ?? '0',
        ),
        double.parse(
          Get.find<GlobalController>().configModel!.defaultLocation!.lng ?? '0',
        ),
      ),
    );
    fromAddress ? _position = myPosition : _pickPosition = myPosition;

    await addMarker(LatLng(myPosition.latitude, myPosition.longitude));

    locationServiceInterface.handleMapAnimation(mapController, myPosition);
    final addressFromGeocode = await getAddressFromGeocode(
      LatLng(myPosition.latitude, myPosition.longitude),
    );
    fromAddress
        ? _address = addressFromGeocode
        : _pickAddress = addressFromGeocode;

    addressModel = await _getAddressModel(
      LatLng(position.latitude, position.longitude),
      addressFromGeocode,
    );
    EasyLoading.dismiss();
    return addressModel;
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    return locationServiceInterface.getAddressFromGeocode(latLng);
  }

  /// get zones to get facility is available or not in my location
  Future<ZoneResponseModel> getZone(
    String? lat,
    String? lng,
    bool markerLoad, {
    bool updateInAddress = false,
    bool handleError = false,
  }) async {
    EasyLoading.load();
    final responseModel = await locationServiceInterface.getZone(
      lat,
      lng,
      handleError: handleError,
    );
    _inZone = responseModel.isSuccess;
    _zoneID = responseModel.zoneIds.isNotEmpty ? responseModel.zoneIds[0] : 0;
    if (updateInAddress && responseModel.isSuccess) {
      final address = AddressHelper.getUserAddressFromSharedPref()!;
      address.zoneData = responseModel.zoneData;
      await AddressHelper.saveUserAddressInSharedPref(address);
    }
    buttonDisabled.value = !responseModel.isSuccess;
    EasyLoading.dismiss();
    return responseModel;
  }

  /// get address from zone
  Future<AddressModel> _getAddressModel(
    LatLng myPosition,
    String addressFromGeocode,
  ) async {
    final responseModel = await getZone(
      myPosition.latitude.toString(),
      myPosition.longitude.toString(),
      true,
    );
    addressController.text = addressFromGeocode;
    // address.removeRange(
    //   addressFromGeocode.split(', ').length - 2,
    //   addressFromGeocode.split(', ').length,
    // );

    final addressModel = AddressModel(
      latitude: myPosition.latitude.toString(),
      longitude: myPosition.longitude.toString(),
      zoneId: responseModel.isSuccess ? responseModel.zoneIds[0] : 0,
      zoneIds: responseModel.zoneIds,
      address: addressFromGeocode,
      zoneData: responseModel.zoneData,
      areaIds: responseModel.areaIds,
    );
    return addressModel;
  }

  /// add pr new address functions, variables and controllers
  final RxString addressLabel = RxString(AppIcons.homeAddressIc);

  void changeAddressLabel(String label) {
    addressLabel.value = label;
    update();
  }

  Future<void> getAddressList() async {
    this.addressList.clear();
    update();
    EasyLoading.load();
    final addressList = await locationServiceInterface.getAllAddress();
    this.addressList = addressList ?? [];
    EasyLoading.dismiss();
    update();
  }

  Future<void> addAddress(BuildContext context, bool isEdit) async {
    ('Add Address Called === ${addressController.text}').print;
    if (!Form.of(context).validate()) {
      return;
    }
    EasyLoading.load();

    final address = AddressModel(
      id: isEdit ? _addressModel?.id : null,
      addressType: switch (addressLabel.value) {
        AppIcons.homeAddressIc => 'Home',
        AppIcons.officeAddressIc => 'Office',
        _ => 'Others',
      },
      contactPersonName: contactPersonNameController.text.trim(),
      contactPersonNumber: contactPersonNumberController.text.trim(),
      address: addressController.text,
      latitude: addressModel?.latitude.toString(),
      longitude: addressModel?.longitude.toString(),
      zoneId: _zoneID,
      zoneIds: _zoneID > 0 ? [_zoneID] : [],
      streetNumber: streetNumberController.text.trim(),
      house: houserNumberController.text.trim(),
      floor: floorNumberController.text.trim(),
    );

    final responseModel = isEdit
        ? await locationServiceInterface.updateAddress(
            address,
            _addressModel?.id,
          )
        : await locationServiceInterface.addAddress(address);

    if (responseModel.isSuccess) {
      if (_isFromSplash.value) {
        await AddressHelper.saveUserAddressInSharedPref(address);
        AppPages.bottomBarScreen.offAll();
      } else {
        _isSearch.value = false;
        await getAddressList();
        Get.back();
      }
    } else {
      showCustomSnackBar(responseModel.message);
    }
    EasyLoading.dismiss();
  }

  Future<AddressModel> setLocation(
    String? placeID,
    String? address,
    GoogleMapController? mapController,
  ) async {
    EasyLoading.load();
    final latLng = await locationServiceInterface.getLatLng(placeID);

    _pickPosition = Position(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      altitudeAccuracy: 1,
      headingAccuracy: 1,
    );

    _pickAddress = address;

    if (mapController != null) {
      await mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 17),
        ),
      );
    }
    EasyLoading.dismiss();

    update();
    return AddressModel(
      latitude: _pickPosition.latitude.toString(),
      longitude: _pickPosition.longitude.toString(),
      addressType: 'others',
      address: _pickAddress,
    );
  }

  List<PredictionModel> _predictionList = [];
  List<PredictionModel> get predictionList => _predictionList;

  Future<List<PredictionModel>> searchLocation(
    BuildContext context,
    String text,
  ) async {
    if (text.isNotEmpty) {
      _predictionList = await locationServiceInterface.searchLocation(text);
    }
    return _predictionList;
  }

  @override
  void onInit() {
    Get.arguments != null
        ? _isFromSplash.value = (Get.arguments['fromSplash'] as bool?) ?? false
        : _isFromSplash.value = false;

    super.onInit();
  }
}
