import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/controllers/business_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/package_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/store_body_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/translation.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/services/store_registration_service_interface.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_data_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/services/location_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class StoreRegistrationController extends GetxController
    implements GetxService {
  StoreRegistrationController({
    required this.locationServiceInterface,
    required this.storeRegistrationServiceInterface,
  });

  final vendorName = TextEditingController();
  final addressController = TextEditingController();
  final vatController = TextEditingController();
  final confirmPassController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ibanController = TextEditingController();

  RxBool passObscureText = true.obs;
  RxBool conPassObscureText = true.obs;

  // String businessPlan = 'commission_base'.tr;
  bool isSubscriptionPlan = false;

  void toggleObscureText({bool isPass = true}) {
    if (isPass) {
      passObscureText.value = !passObscureText.value;
    } else {
      conPassObscureText.value = !conPassObscureText.value;
    }
  }

  final StoreRegistrationServiceInterface storeRegistrationServiceInterface;
  final LocationServiceInterface locationServiceInterface;

  int? selectedPlan;

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  num _storeStatus = 0.1;
  num get storeStatus => _storeStatus;

  XFile? _pickedLogo;
  XFile? get pickedLogo => _pickedLogo;

  XFile? _pickedCover;
  XFile? get pickedCover => _pickedCover;

  LatLng? _restaurantLocation;
  LatLng? get restaurantLocation => _restaurantLocation;

  List<int>? _zoneIds;
  List<int>? get zoneIds => _zoneIds;

  int? _selectedZoneIndex = 0;
  int? get selectedZoneIndex => _selectedZoneIndex;

  List<ZoneDataModel> _zoneList = [];
  List<ZoneDataModel> get zoneList => _zoneList;

  List<ModuleModel> _moduleList = [];
  List<ModuleModel> get moduleList => _moduleList;

  int? _selectedModuleIndex = -1;
  int? get selectedModuleIndex => _selectedModuleIndex;

  bool _showPassView = false;
  bool get showPassView => _showPassView;

  String? _storeAddress;
  String? get storeAddress => _storeAddress;

  String _storeMinTime = '--';
  String get storeMinTime => _storeMinTime;

  String _storeMaxTime = '--';
  String get storeMaxTime => _storeMaxTime;

  String _storeTimeUnit = 'minute';
  String get storeTimeUnit => _storeTimeUnit;

  bool _lengthCheck = false;
  bool get lengthCheck => _lengthCheck;

  bool _numberCheck = false;
  bool get numberCheck => _numberCheck;

  bool _uppercaseCheck = false;
  bool get uppercaseCheck => _uppercaseCheck;

  bool _lowercaseCheck = false;
  bool get lowercaseCheck => _lowercaseCheck;

  bool _spatialCheck = false;
  bool get spatialCheck => _spatialCheck;

  bool _inZone = false;
  bool get inZone => _inZone;

  int _activeSubscriptionIndex = 0;
  int get activeSubscriptionIndex => _activeSubscriptionIndex;

  String _businessPlanStatus = 'business';
  String get businessPlanStatus => _businessPlanStatus;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;

  PackageModel? _packageModel;
  PackageModel? get packageModel => _packageModel;

  String? _selectedPickupZone;
  String? get selectedPickupZone => _selectedPickupZone;

  final List<String> _pickupZoneList = [];
  List<String> get pickupZoneList => _pickupZoneList;

  final List<int> _pickupZoneIdList = [];
  List<int> get pickupZoneIdList => _pickupZoneIdList;

  void setSelectedPickupZone(String? zone, int? zoneId) {
    if (zone != null && zoneId != null) {
      if (_pickupZoneList.contains(zone) ||
          _pickupZoneIdList.contains(zoneId)) {
        showCustomSnackBar('zone_already_added_please_select_another'.tr);
      } else {
        _selectedPickupZone = zone;
        _pickupZoneList.add(zone);
        _pickupZoneIdList.add(zoneId);
        update();
      }
    }
  }

  void removePickupZone(String zone, int zoneId) {
    _selectedPickupZone = null;
    _pickupZoneList.remove(zone);
    _pickupZoneIdList.remove(zoneId);
    update();
  }

  void clearPickupZone() {
    _selectedModuleIndex = -1;
    _selectedPickupZone = null;
    _pickupZoneList.clear();
    _pickupZoneIdList.clear();
  }

  void showHidePass({bool isUpdate = true}) {
    _showPassView = !_showPassView;
    if (isUpdate) {
      update();
    }
  }

  Future<void> setZoneIndex(int? index, {bool canUpdate = true}) async {
    _selectedZoneIndex = index;
    _moduleList = [];
    _selectedModuleIndex = -1;
    update();
    if (canUpdate) {
      await getModules(zoneList[selectedZoneIndex!].id);
      update();
    }
  }

  void minTimeChange(String time) {
    _storeMinTime = time;
    update();
  }

  void maxTimeChange(String time) {
    _storeMaxTime = time;
    update();
  }

  void timeUnitChange(String unit) {
    _storeTimeUnit = unit;
    update();
  }

  void storeStatusChange(num value, {bool isUpdate = true}) {
    _storeStatus = value;
    if (isUpdate) {
      update();
    }
  }

  void selectModuleIndex(int? index, {bool canUpdate = true}) {
    _selectedModuleIndex = index;
    if (canUpdate) {
      update();
    }
  }

  Future<void> pickImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickedLogo = null;
      _pickedCover = null;
    } else {
      if (isLogo) {
        _pickedLogo = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
      } else {
        _pickedCover = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
      }
      update();
    }
  }

  void validPassCheck(String pass, {bool isUpdate = true}) {
    _lengthCheck = false;
    _numberCheck = false;
    _uppercaseCheck = false;
    _lowercaseCheck = false;
    _spatialCheck = false;

    if (pass.length > 7) {
      _lengthCheck = true;
    }
    if (pass.contains(RegExp('[a-z]'))) {
      _lowercaseCheck = true;
    }
    if (pass.contains(RegExp('[A-Z]'))) {
      _uppercaseCheck = true;
    }
    if (pass.contains(RegExp(r'[ .!@#$&*~^%]'))) {
      _spatialCheck = true;
    }
    if (pass.contains(RegExp(r'[\d+]'))) {
      _numberCheck = true;
    }
    if (isUpdate) {
      update();
    }
  }

  Future<void> getZoneList() async {
    _pickedLogo = null;
    _pickedCover = null;
    _selectedZoneIndex = 0;
    _restaurantLocation = null;
    _zoneIds = null;
    final zones = await storeRegistrationServiceInterface.getZoneList();
    if (zones != null) {
      _zoneList = [];
      final dummy = zones;
      _zoneList = dummy;
      update();
      await setLocation(
        LatLng(
          double.parse(
            Get.find<GlobalController>().configModel!.defaultLocation!.lat ??
                '0',
          ),
          double.parse(
            Get.find<GlobalController>().configModel!.defaultLocation!.lng ??
                '0',
          ),
        ),
        forStoreRegistration: true,
        zoneId: _zoneList[0].id,
      );
      await getModules(_zoneList[0].id);
    }
    update();
  }

  Future<void> setLocation(
    LatLng location, {
    bool forStoreRegistration = false,
    int? zoneId,
  }) async {
    // ZoneResponseModel response = await Get.find<LocationController>().getZone(
    //   location.latitude.toString(), location.longitude.toString(), false, handleError: true,
    // );
    final response = await locationServiceInterface.getZone(
      location.latitude.toString(),
      location.longitude.toString(),
      handleError: true,
    );

    if (zoneId != null) {
      _inZone = await storeRegistrationServiceInterface.checkInZone(
        location.latitude.toString(),
        location.longitude.toString(),
        zoneId,
      );
    }

    _storeAddress = await Get.find<LocationController>().getAddressFromGeocode(
      LatLng(location.latitude, location.longitude),
    );
    if (response.isSuccess && response.zoneIds.isNotEmpty) {
      _restaurantLocation = location;
      _zoneIds = response.zoneIds;
      // _selectedZoneIndex = storeRegistrationServiceInterface.prepareSelectedZoneIndex(_zoneIds, _zoneList);
      for (var index = 0; index < zoneList.length; index++) {
        if (zoneIds!.contains(zoneList[index].id)) {
          if (!forStoreRegistration) {
            _selectedZoneIndex = index;
          }
          break;
        }
      }
    } else {
      _restaurantLocation = null;
      _zoneIds = null;
    }
    update();
  }

  Future<void> getModules(int? zoneId) async {
    final modules = await storeRegistrationServiceInterface.getModules(zoneId);
    if (modules != null) {
      _moduleList = [];
      _moduleList.addAll(modules);
    }
    update();
  }

  void resetStoreRegistration() {
    _pickedLogo = null;
    _pickedCover = null;
    _selectedModuleIndex = -1;
    _selectedModuleIndex = -1;
    _storeMinTime = '--';
    _storeMaxTime = '--';
    _storeTimeUnit = 'minute';
    update();
  }

  Future<void> registerStore() async {
    EasyLoading.load();
    // try {

    final translation = <Translation>[];
    translation.add(
      Translation(locale: 'en', key: 'name', value: vendorName.text.trim()),
    );
    translation.add(
      Translation(locale: 'en', key: 'address', value: addressController.text),
    );
    final storeBody = StoreBodyModel(
      translation: jsonEncode(translation),
      tax: vatController.text,
      minDeliveryTime: storeMinTime,
      maxDeliveryTime: storeMaxTime,
      lat: restaurantLocation?.latitude.toString(),
      email: emailController.text,
      lng: restaurantLocation?.longitude.toString(),
      fName: fNameController.text,
      lName: lNameController.text,
      phone: phoneController.text,
      password: passwordController.text,
      iban: 'Helo',
      zoneId: zoneList[selectedZoneIndex!].id.toString(),
      moduleId: moduleList[selectedModuleIndex!].id.toString(),
      deliveryTimeType: storeTimeUnit,
      businessPlan: !isSubscriptionPlan ? 'commission' : 'subscription',
      packageId: !isSubscriptionPlan
          ? ''
          : packageModel!.packages![activeSubscriptionIndex].id!.toString(),
      pickUpZoneIds: pickupZoneIdList.map((e) => e.toString()).toList(),
    );

    final response = await storeRegistrationServiceInterface.registerStore(
      storeBody,
      _pickedLogo,
      _pickedCover,
    );
    if (response.statusCode == 200) {
      // Get.find<GlobalController>().saveRegistrationSuccessfulSharedPref(true);
      final storeId = response.body['store_id'] as int?;
      final packageId = response.body['package_id'] as int?;

      '==>>>>> here storeId -== $storeId =====>>>>>>>>>>> packageId $packageId'
          .print;

      if (packageId == null) {
        '===>>>> here submit plan api call'.print;
        await Get.put<BusinessController>(
          BusinessController(businessServiceInterface: Get.find()),
        ).submitBusinessPlan(storeId: storeId!, packageId: null);
      } else {
        '===>>>> here subscriptionPayment screen'.print;
        AppPages.subscriptionPayment.push(
          arguments: {'storeId': storeId, 'packageId': packageId},
        );
      }
    }
    EasyLoading.dismiss();
    // } catch (e) {
    //   '==>>> register store error $e'.print;
    // EasyLoading.dismiss();
    // } finally {
    // }
  }

  void resetBusiness() {
    isSubscriptionPlan =
        Get.find<GlobalController>().configModel!.commissionBusinessModel != 0;
    _activeSubscriptionIndex = 0;
    _businessPlanStatus = 'business';
    // _isFirstTime = true;
    _paymentIndex =
        Get.find<GlobalController>().configModel!.subscriptionFreeTrialStatus ??
            false
        ? 1
        : 0;
  }

  Future<void> getPackageList({bool isUpdate = true, int? moduleId}) async {
    _packageModel = await storeRegistrationServiceInterface.getPackageList(
      moduleId: moduleId,
    );
    if (isUpdate) {
      update();
    }
  }

  void changeDigitalPaymentName(String? name, {bool canUpdate = true}) {
    _digitalPaymentName = name;
    if (canUpdate) {
      update();
    }
  }

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setBusinessStatus(String status) {
    _businessPlanStatus = status;
    update();
  }

  void selectSubscriptionCard(int index) {
    _activeSubscriptionIndex = index;
    update();
  }
}
