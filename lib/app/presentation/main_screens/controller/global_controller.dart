import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/update_user_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/userinfo_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/services/profile_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/presentation/main_screens/services/global_service_interface.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/common/models/config_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/common/models/notification_body_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/splash_route_helper.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

class GlobalController extends GetxController {
  GlobalController(this.authServiceInterface, this.globalServiceInterface) {
    initSharedData();
  }

  /// this is authentication service to get all apis
  final AuthServiceInterface authServiceInterface;
  final GlobalServiceInterface globalServiceInterface;

  List<ModuleModel?> _moduleList = [];
  List<ModuleModel?> get moduleList => _moduleList;

  ModuleModel? _module;
  ModuleModel? get module => _module;
  set module(ModuleModel? module) => _module = module;

  bool isGuestMode = false;

  ModuleModel? _cacheModule;
  ModuleModel? get cacheModule => _cacheModule;

  DateTime get currentTime => DateTime.now();

  /// theme variable
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  bool get isDark => themeMode.value == ThemeMode.dark;

  Future<void> toggleTheme() async {
    final pref = await SharedPreferences.getInstance();
    themeMode.value = themeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    await pref.setBool('theme', themeMode.value == ThemeMode.light);
  }

  Future<void> getTheme() async {
    final pref = await SharedPreferences.getInstance();
    final isLight = pref.getBool('theme') ?? true;
    " === ..... theme ${pref.getBool('theme')}".print;
    themeMode.value = isLight ? ThemeMode.light : ThemeMode.dark;
  }

  /// for localization
  final Rx<Locale> locale = Rx<Locale>(const Locale('en'));

  /// is from left to right
  final RxBool _isLTR = true.obs;
  RxBool get isLTR => _isLTR;

  void changeLocale(Locale newLan) {
    locale.value = newLan;
    isLTR.value = newLan.languageCode == 'en';
    update();
  }

  Future<void> initSharedData() async {
    _module = await globalServiceInterface.initSharedData();
    _cacheModule = globalServiceInterface.getCacheModule();
    await getModuleList();
    '==>> _cacheModule ${_cacheModule?.toJson()}'.print;
  }

  /// loader
  RxBool isLoader = false.obs;

  /// to check user is login or not
  bool isLoggedIn() => authServiceInterface.isLoggedIn();

  /// to check user is guest or not
  bool isGuestLoggedIn() =>
      authServiceInterface.isGuestLoggedIn() &&
      !authServiceInterface.isLoggedIn();

  /// to get guest id
  String getGuestId() => authServiceInterface.getSharedPrefGuestId();

  /// to update token
  Future<void> updateToken() async => authServiceInterface.updateToken();

  /// this function is used for clear shared address data
  Future<bool> clearSharedAddress() async {
    return authServiceInterface.clearSharedAddress();
  }

  /// variable for check internet connection status
  bool _hasConnection = true;
  bool get hasConnection => _hasConnection;

  /// this variable is used to store config data
  Map<String, dynamic>? _data = {};
  ConfigModel? _configModel;
  ConfigModel? get configModel => _configModel;

  /// selected address model
  Rx<AddressModel?> addressModel = Rx<AddressModel?>(null);

  /// this function is for login as guest
  Future<ResponseModel> guestLogin() async {
    EasyLoading.load();
    final responseModel = await authServiceInterface.guestLogin();
    EasyLoading.dismiss();
    return responseModel;
  }

  Future<void> getConfigData({
    NotificationBodyModel? notificationBody,
    bool loadModuleData = false,
    bool loadLandingData = false,
    DataSourceEnum source = DataSourceEnum.local,
    bool fromMainFunction = false,
    bool fromDemoReset = false,
  }) async {
    _hasConnection = true;
    Response<dynamic> response;
    // if (source == DataSourceEnum.local && !fromDemoReset) {
    //   response = await globalServiceInterface.getConfigData(
    //     source: DataSourceEnum.local,
    //   );

    //   await _handleConfigResponse(
    //     response,
    //     loadModuleData,
    //     fromDemoReset,
    //     notificationBody,
    //     isNavigation: false,
    //   );
    //   await getConfigData(
    //     loadModuleData: loadModuleData,
    //     loadLandingData: loadLandingData,
    //     source: DataSourceEnum.client,
    //   );
    // } else {
    response = await globalServiceInterface.getConfigData(
      source: DataSourceEnum.client,
    );
    'response.body = ?> ${response.body}'.print;

    await _handleConfigResponse(
      response,
      loadModuleData,
      fromDemoReset,
      notificationBody,
    );
    // }
  }

  Future<void> getModuleList() async {
    _hasConnection = true;
    // if (source == DataSourceEnum.local && !fromDemoReset) {
    //   response = await globalServiceInterface.getConfigData(
    //     source: DataSourceEnum.local,
    //   );

    //   await _handleConfigResponse(
    //     response,
    //     loadModuleData,
    //     fromDemoReset,
    //     notificationBody,
    //     isNavigation: false,
    //   );
    //   await getConfigData(
    //     loadModuleData: loadModuleData,
    //     loadLandingData: loadLandingData,
    //     source: DataSourceEnum.client,
    //   );
    // } else {
    _moduleList =
        await globalServiceInterface.getModules(
          source: DataSourceEnum.client,
        ) ??
        [];

    // }
  }

  Future<void> _handleConfigResponse(
    Response<dynamic> response,
    bool loadModuleData,
    bool fromDemoReset,
    NotificationBodyModel? notificationBody, {
    bool isNavigation = true,
  }) async {
    if (response.statusCode == 200) {
      _data = response.body is String
          ? jsonDecode(response.body as String) as Map<String, dynamic>
          : response.body as Map<String, dynamic>;
      _configModel = ConfigModel.fromJson(_data!);
      if (isNavigation) {
        if (fromDemoReset) {
          if (isNavigation) AppPages.login.offAll();
        } else {
          if (GlobalHelper.getGuestId().trim().isEmpty) {
            route(body: notificationBody);
          } else {
            isGuestMode = true;
            AppPages.bottomBarScreen.offAll();
          }
        }
      }
      _onRemoveLoader();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        _hasConnection = false;
      }
    }
    update();
  }

  void _onRemoveLoader() {
    final preloader = html.document.querySelector('.preloader');
    if (preloader != null) {
      preloader.remove();
    }
  }

  UserInfoModel? userInfoModel;

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getUserInfo({bool isNavigate = true}) async {
    userInfoModel = await globalServiceInterface.getUserInfo();
    update();
    if (isNavigate) {
      AppPages.locationScreen.offAll(arguments: {AppStrings.fromSplash: true});
      isGuestMode = false;
    }
  }

  void removeUserData() {
    userInfoModel = null;
    update();
  }

  Future<void> deleteUser() async {
    EasyLoading.load();
    final response = await Get.find<ProfileServiceInterface>().deleteUser();

    if (response.statusCode == 200) {
      await Get.put<AuthService>(
        AuthService(authRepositoryInterface: Get.find()),
      ).clearSharedData(removeToken: false);
      // await Get.find<AuthController>().clearUserNumberAndPassword();
      await Get.find<CartController>().clearCartList();
      // Get.find<LocationController>().addressList.clear();
      addressModel.value = null;
      // if (Get.find<AuthController>().isActiveRememberMe) {
      //   // Get.find<LoginController>().toggleRememberMe();
      // }
      // Get.find<AuthService>().removeFavourite();
      userInfoModel = null;
      showCustomSnackBar('your_account_remove_successfully'.tr, isError: false);
      update();
      AppPages.login.offAll();
    }
    EasyLoading.dismiss();
  }

  Future<void> logout() async {
    EasyLoading.load();

    await Get.put<AuthService>(
      AuthService(authRepositoryInterface: Get.find()),
    ).clearSharedData(removeToken: false);
    // await Get.find<AuthController>().clearUserNumberAndPassword();
    await Get.find<CartController>().clearCartList();
    addressModel.value = null;
    // Get.find<LocationController>().addressList.clear();
    addressModel.value = null;
    // if (Get.find<AuthController>().isActiveRememberMe) {
    //   // Get.find<LoginController>().toggleRememberMe();
    // }
    // Get.find<AuthService>().removeFavourite();
    userInfoModel = null;
    showCustomSnackBar('your_account_remove_successfully'.tr, isError: false);
    update();
    AppPages.login.offAll();
    EasyLoading.dismiss();
  }

  /// to set cache data
  void setCacheConfigModule(ModuleModel? cacheModule) {
    _configModel!.moduleConfig!.module = Module.fromJson(
      _data!['module_config'][cacheModule!.moduleType] as Map<String, dynamic>,
    );
  }

  bool? showIntro() => globalServiceInterface.showIntro();

  void disableIntro() => globalServiceInterface.disableIntro();

  Module? getModuleConfig(String? moduleType) {
    final module = _data?['module_config'][moduleType] == null
        ? null
        : Module.fromJson(
            _data?['module_config'][moduleType] as Map<String, dynamic>,
          );
    moduleType == 'food'
        ? module?.newVariation = true
        : module?.newVariation = false;

    return module;
  }

  /// verify mobile number
  Future<void> firebaseVerifyPhoneNumber(
    String phoneNumber,
    String? token,
    String loginType, {
    bool fromSignUp = true,
    bool canRoute = true,
    UpdateUserModel? updateUserModel,
  }) async {
    // EasyLoading.load();
    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: phoneNumber,
    //   verificationCompleted: (PhoneAuthCredential credential) {},
    //   verificationFailed: (FirebaseAuthException e) {
    //     EasyLoading.dismiss();

    //     if (Get.isDialogOpen!) {
    //       Get.back();
    //     }

    //     if (e.code == 'invalid-phone-number') {
    //       showCustomSnackBar('please_submit_a_valid_phone_number'.tr);
    //     } else {
    //       showCustomSnackBar(e.message?.replaceAll('_', ' '));
    //     }
    //   },
    //   codeSent: (String vId, int? resendToken) {
    //     if (Get.isDialogOpen!) {
    //       Get.back();
    //     }

    //     EasyLoading.dismiss();

    //     if (updateUserModel != null) {
    //       updateUserModel.sessionInfo = vId;
    //     }

    //     if (canRoute) {
    //       AppPages.signUpOtp.push<Map<String, dynamic>>(
    //         arguments: {'mobile': phoneNumber},
    //       );
    //     }
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     if (Get.isDialogOpen!) {
    //       Get.back();
    //     }
    //     showCustomSnackBar('timed_out_please_try_again_after_few_minutes'.tr);
    //   },
    // );
  }

  /// to save device token
  Future<String?> saveDeviceToken() async {
    return authServiceInterface.saveDeviceToken();
  }

  @override
  void onInit() {
    getTheme();
    super.onInit();
  }
}
