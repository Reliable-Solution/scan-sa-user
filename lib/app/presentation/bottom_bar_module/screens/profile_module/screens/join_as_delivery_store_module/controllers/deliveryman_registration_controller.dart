import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/models/delivery_man_body.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/models/delivery_man_vehicles_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/services/deliveryman_registration_service_interface.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_data_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/module_model.dart';

class DeliverymanRegistrationController extends GetxController
    implements GetxService {
  DeliverymanRegistrationController({
    required this.deliverymanRegistrationServiceInterface,
  });
  final DeliverymanRegistrationServiceInterface
  deliverymanRegistrationServiceInterface;

  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final identityNumberController = TextEditingController();

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _showPassView = false;
  bool get showPassView => _showPassView;

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  List<XFile> _pickedIdentities = [];
  List<XFile> get pickedIdentities => _pickedIdentities;

  double _dmStatus = 0.4;
  double get dmStatus => _dmStatus;

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

  RxBool passObscureText = true.obs;
  RxBool conPassObscureText = true.obs;

  void toggleObscureText({bool isPass = true}) {
    if (isPass) {
      passObscureText.value = !passObscureText.value;
    } else {
      conPassObscureText.value = !conPassObscureText.value;
    }
  }

  final List<String> _identityTypeList = ['passport', 'driving_license', 'nid'];
  List<String> get identityTypeList => _identityTypeList;

  int _identityTypeIndex = -1;
  int get identityTypeIndex => _identityTypeIndex;

  int _dmTypeIndex = -1;
  int get dmTypeIndex => _dmTypeIndex;

  List<ZoneDataModel>? _zoneList;
  List<ZoneDataModel>? get zoneList => _zoneList;

  int _selectedZoneIndex = -1;
  int get selectedZoneIndex => _selectedZoneIndex;

  List<int>? _zoneIds;
  List<int>? get zoneIds => _zoneIds;

  List<ModuleModel>? _moduleList;
  List<ModuleModel>? get moduleList => _moduleList;

  List<DeliveryManVehicleModel>? _vehicles;
  List<DeliveryManVehicleModel>? get vehicles => _vehicles;

  List<int?>? _vehicleIds;
  List<int?>? get vehicleIds => _vehicleIds;

  final List<String?> _dmTypeList = [
    'select_delivery_type',
    'freelancer',
    'salary_based',
  ];
  List<String?> get dmTypeList => _dmTypeList;

  int _vehicleIndex = 0;
  int get vehicleIndex => _vehicleIndex;
  bool _acceptTerms = true;
  bool get acceptTerms => _acceptTerms;

  void showHidePass({bool isUpdate = true}) {
    _showPassView = !_showPassView;
    if (isUpdate) {
      update();
    }
  }

  Future<void> setZoneIndex(int index, {bool canUpdate = true}) async {
    _selectedZoneIndex = index;
    if (canUpdate) {
      await getModules(zoneList![selectedZoneIndex].id);
      update();
    }
  }

  void setVehicleIndex(int index, bool notify) {
    _vehicleIndex = index;
    if (notify) {
      update();
    }
  }

  void removeIdentityImage(int index) {
    _pickedIdentities.removeAt(index);
    update();
  }

  Future<void> pickDmImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickedImage = null;
      _pickedIdentities = [];
    } else {
      if (isLogo) {
        _pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
      } else {
        final xFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (xFile != null) {
          _pickedIdentities.add(xFile);
        }
      }
      update();
    }
  }

  void removeDmImage() {
    _pickedImage = null;
    update();
  }

  void dmStatusChange(double value, {bool isUpdate = true}) {
    _dmStatus = value;
    if (isUpdate) {
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

  void setIdentityTypeIndex(int identityType, bool notify) {
    _identityTypeIndex = identityType;
    if (notify) {
      update();
    }
  }

  void setDMTypeIndex(int dmType, bool notify) {
    _dmTypeIndex = dmType;
    if (notify) {
      update();
    }
  }

  Future<void> getZoneList() async {
    _selectedZoneIndex = -1;
    _zoneIds = null;
    final zones = await deliverymanRegistrationServiceInterface.getZoneList();
    if (zones != null) {
      _zoneList = [];
      _zoneList!.addAll(zones);
      await _setLocation(
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
      );
      await getModules(_zoneList![0].id);
    }
    update();
  }

  Future<void> _setLocation(LatLng location) async {
    final response =
        await Get.put(
          LocationController(locationServiceInterface: Get.find()),
        ).getZone(
          location.latitude.toString(),
          location.longitude.toString(),
          false,
        );
    if (response.isSuccess && response.zoneIds.isNotEmpty) {
      _zoneIds = response.zoneIds;
      _selectedZoneIndex =
          deliverymanRegistrationServiceInterface.prepareSelectedZoneIndex(
            _zoneIds,
            _zoneList,
          ) ??
          0;
    } else {
      _zoneIds = null;
    }
    update();
  }

  Future<void> getModules(int? zoneId) async {
    final modules = await deliverymanRegistrationServiceInterface.getModules(
      zoneId,
    );
    if (modules != null) {
      _moduleList = [];
      _moduleList!.addAll(modules);
    }
    update();
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  Future<void> getVehicleList() async {
    final vehicleList = await deliverymanRegistrationServiceInterface
        .getVehicleList();
    if (vehicleList != null) {
      _vehicles = [];
      _vehicles!.addAll(vehicleList);
      _vehicleIds = deliverymanRegistrationServiceInterface.prepareVehicleIds(
        vehicleList,
      );
    }
    update();
  }

  Future<void> registerDeliveryMan() async {
    if (identityNumberController.text.isEmpty) {
      showCustomSnackBar('enter_delivery_man_identity_number'.tr);
    } else if (pickedImage == null) {
      showCustomSnackBar('upload_delivery_man_image'.tr);
    } else if (vehicleIndex == -1) {
      showCustomSnackBar('please_select_vehicle_for_the_deliveryman'.tr);
    } else if (pickedIdentities.isEmpty) {
      showCustomSnackBar('please_upload_identity_image'.tr);
    } else if (dmTypeIndex == 0) {
      showCustomSnackBar('please_select_deliveryman_type'.tr);
    } else {
      EasyLoading.load();
      final multiParts = deliverymanRegistrationServiceInterface
          .prepareMultipart(_pickedImage, _pickedIdentities);
      await deliverymanRegistrationServiceInterface
          .registerDeliveryMan(
            DeliveryManBody(
              fName: fNameController.text,
              email: emailController.text,
              lName: lNameController.text,
              identityNumber: identityNumberController.text,
              password: passwordController.text,
              phone: phoneController.text,
              earning: dmTypeIndex == 1 ? '1' : '0',
              identityType: identityTypeList[identityTypeIndex],
              zoneId: zoneList![selectedZoneIndex].id.toString(),
              vehicleId: vehicles![vehicleIndex].id.toString(),
            ),
            multiParts,
          )
          .then((value) {
            if (value) Get.back();
          });
      EasyLoading.dismiss();
    }
  }

  void resetDeliveryRegistration() {
    _identityTypeIndex = 0;
    _dmTypeIndex = 0;
    _selectedZoneIndex = -1;
    _pickedImage = null;
    _pickedIdentities = [];
    update();
  }
}
