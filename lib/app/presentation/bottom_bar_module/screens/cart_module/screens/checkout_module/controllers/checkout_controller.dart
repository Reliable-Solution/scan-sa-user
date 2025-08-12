import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_repo/auth_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/offline_method_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/place_order_body_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/timeslote_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/services/checkout_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/repositories/store_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/controller/restaurant_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/controllers/coupon_controller.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/location_module/module_helper.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/date_converter.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CheckoutController extends GetxController implements GetxService {
  CheckoutController({required this.checkoutServiceInterface});
  final CheckoutServiceInterface checkoutServiceInterface;
  String appliedCoupon = '';

  final couponController = TextEditingController();
  final noteController = TextEditingController();
  final streetNumberController = TextEditingController();
  final houseController = TextEditingController();
  final floorController = TextEditingController();
  final tipController = TextEditingController();
  final streetNode = FocusNode();
  final houseNode = FocusNode();
  final floorNode = FocusNode();

  RxBool isHomeDelivery = true.obs;

  void changeDeliveryType(bool value) {
    isHomeDelivery.value = value;
    update();
  }

  Rx<String?> selectedMethod = ''.obs;
  void paymentMethod(String method) {
    selectedMethod.value = method;
    Get.back();
    update();
  }

  RxBool isToday = true.obs;
  void changeTime(bool value) {
    isToday.value = value;
    update();
  }

  RxString selectedTime = ''.obs;
  RxBool isSecToday = true.obs;
  void changeSelectedTime(String value) {
    selectedTime.value = value;
    isSecToday.value = isToday.value;
    update();
  }

  List<CartModel?> cartList = [];
  bool isWalletActive = false;

  Future<void> initCall(bool isFromBottom) async {
    'checkoutController.cartList ${Get.find<CartController>().cartList.length}'
        .print;
    selectedTime.value = '';
    final isLoggedIn = Get.find<AuthRepositoryInterface>().isLoggedIn();
    EasyLoading.load();
    try {
      initAdditionData();
      streetNumberController.text =
          AddressHelper.getUserAddressFromSharedPref()!.streetNumber ?? '';
      houseController.text =
          AddressHelper.getUserAddressFromSharedPref()!.house ?? '';
      floorController.text =
          AddressHelper.getUserAddressFromSharedPref()!.floor ?? '';
      couponController.text = '';

      await getDmTipMostTapped();
      setPreferenceTimeForView('', isUpdate: false);

      await getOfflineMethodList();

      if (isCreateAccount) {
        toggleCreateAccount(willUpdate: false);
      }

      if (isPartialPay) {
        changePartialPayment(isUpdate: false);
      }

      if (isLoggedIn) {
        if (Get.find<GlobalController>().userInfoModel == null) {
          await Get.find<GlobalController>().getUserInfo();
        }

        await Get.put(
          CouponController(couponServiceInterface: Get.find()),
        ).getCouponList();
      }
      if (isLoggedIn) {
        // if (Get.find<ProfileController>().userInfoModel == null) {
        //   Get.find<ProfileController>().getUserInfo();
        // }

        await Get.put(
          CouponController(couponServiceInterface: Get.find()),
        ).getCouponList();

        if (Get.put(
          LocationController(locationServiceInterface: Get.find()),
        ).addressList.isEmpty) {
          await Get.find<LocationController>().getAddressList();
        }
      }

      cartList = [];
      cartList.addAll(Get.find<CartController>().cartList);
      if (store?.id == null) {
        'checkoutController.cartList ${Get.find<CartController>().cartList.length}'
            .print;
        // if (GetPlatform.isWeb) {
        //   await Get.find<CartController>().getCartDataOnline();
        // }
        if (cartList.isNotEmpty) {
          await initCheckoutData(cartList[0]!.item!.storeId, isFromBottom);
        }
      }
      if (store?.id != null) {
        await initCheckoutData(store?.id, isFromBottom);
        Get.find<CouponController>().removeCouponData(false);
      }
      await pickPrescriptionImage(isRemove: true, isCamera: false);
      isWalletActive =
          Get.find<GlobalController>().configModel!.customerWalletStatus == 1;
      updateTips(
        getSharedPrefDmTipIndex().isNotEmpty
            ? int.parse(getSharedPrefDmTipIndex())
            : 0,
        notify: false,
      );
      tipController.text = selectedTips != -1
          ? AppConstants.tips[selectedTips]
          : '';
    } finally {
      EasyLoading.dismiss();
    }
  }

  // String? countryDialCode =
  //     Get.find<AuthController>().getUserCountryCode().isNotEmpty
  //     ? Get.find<AuthController>().getUserCountryCode()
  //     : CountryCode.fromCountryCode(
  //             Get.find<GlobalController>().configModel!.country!,
  //           ).dialCode ??
  //           Get.find<GlobalController>().locale.value.countryCode;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AddressModel? _guestAddress;
  AddressModel? get guestAddress => _guestAddress;

  int? _mostDmTipAmount;
  int? get mostDmTipAmount => _mostDmTipAmount;

  String _preferableTime = '';
  String get preferableTime => _preferableTime;

  List<OfflineMethodModel>? _offlineMethodList;
  List<OfflineMethodModel>? get offlineMethodList => _offlineMethodList;

  bool _isPartialPay = false;
  bool get isPartialPay => _isPartialPay;

  num _tips = 0.0;
  num get tips => _tips;

  int _selectedTips = 0;
  int get selectedTips => _selectedTips;

  Store? _store;
  Store? get store => _store;

  int? _addressIndex = 0;
  int? get addressIndex => _addressIndex;

  String? selectedAddress;

  XFile? _orderAttachment;
  XFile? get orderAttachment => _orderAttachment;

  Uint8List? _rawAttachment;
  Uint8List? get rawAttachment => _rawAttachment;

  bool _acceptTerms = true;
  bool get acceptTerms => _acceptTerms;

  int _paymentMethodIndex = -1;
  int get paymentMethodIndex => _paymentMethodIndex;

  int _selectedDateSlot = 0;
  int get selectedDateSlot => _selectedDateSlot;

  int _selectedTimeSlot = 0;
  int get selectedTimeSlot => _selectedTimeSlot;

  num? _distance;
  num? get distance => _distance;

  List<TimeSlotModel> _timeSlots = [];
  List<TimeSlotModel> get timeSlots => _timeSlots;

  List<TimeSlotModel>? _allTimeSlots;

  List<XFile> _pickedPrescriptions = [];
  List<XFile> get pickedPrescriptions => _pickedPrescriptions;

  num? _extraCharge;
  num? get extraCharge => _extraCharge;

  String? _orderType = 'delivery';
  String? get orderType => _orderType;

  num _viewTotalPrice = 0;
  num? get viewTotalPrice => _viewTotalPrice;
  set viewTotalPrice(num? amount) => _viewTotalPrice = amount ?? 0;

  int _selectedOfflineBankIndex = 0;
  int get selectedOfflineBankIndex => _selectedOfflineBankIndex;

  int _selectedInstruction = -1;
  int get selectedInstruction => _selectedInstruction;

  bool _isDmTipSave = false;
  bool get isDmTipSave => _isDmTipSave;

  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;

  bool _canShowTipsField = false;
  bool get canShowTipsField => _canShowTipsField;

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  bool _isExpand = false;
  bool get isExpand => _isExpand;

  void initAdditionData() {
    noteController.clear();
    _selectedInstruction = -1;
  }

  Future<void> initCheckoutData(int? storeId, bool isFromBottom) async {
    Get.find<CouponController>().removeCouponData(false);
    clearPrevData();
    _store = isFromBottom
        ? await getStoreDetails(Store(id: storeId), false)
        : Get.find<RestaurantController>().store;
    await initializeTimeSlot(_store!);
  }

  void showTipsField() {
    _canShowTipsField = !_canShowTipsField;
    update();
  }

  Future<void> addTips(num tips) async {
    _tips = tips;
    update();
  }

  void expandedUpdate(bool status) {
    _isExpanded = status;
    update();
  }

  void setPaymentMethod(int index, {bool isUpdate = true}) {
    _paymentMethodIndex = index;
    if (isUpdate) {
      update();
    }
  }

  void changeDigitalPaymentName(String name, {bool willUpdate = true}) {
    _digitalPaymentName = name;
    if (willUpdate) {
      update();
    }
  }

  void setOrderType(String? type, {bool notify = true}) {
    _orderType = type;
    if (notify) {
      update();
    }
  }

  void changePartialPayment({bool isUpdate = true}) {
    _isPartialPay = !_isPartialPay;
    if (isUpdate) {
      update();
    }
  }

  void setAddressIndex(int? index) {
    _addressIndex = index;
    update();
  }

  void setGuestAddress(AddressModel? address, {bool isUpdate = true}) {
    _guestAddress = address;
    if (isUpdate) {
      update();
    }
  }

  Future<void> getDmTipMostTapped() async {
    _mostDmTipAmount = await checkoutServiceInterface.getDmTipMostTapped();
    update();
  }

  void setPreferenceTimeForView(String time, {bool isUpdate = true}) {
    _preferableTime = time;
    if (isUpdate) {
      update();
    }
  }

  Future<void> getOfflineMethodList() async {
    _offlineMethodList = null;
    _offlineMethodList = await checkoutServiceInterface.getOfflineMethodList();
    update();
  }

  void updateTips(int index, {bool notify = true}) {
    _selectedTips = index;
    if (_selectedTips == 0 || _selectedTips == 5) {
      _tips = 0;
    } else {
      _tips = num.parse(AppConstants.tips[index]);
    }
    if (notify) {
      update();
    }
  }

  void saveSharedPrefDmTipIndex(String i) {
    checkoutServiceInterface.saveSharedPrefDmTipIndex(i);
  }

  String getSharedPrefDmTipIndex() {
    return checkoutServiceInterface.getSharedPrefDmTipIndex();
  }

  // void setTotalAmount(num amount) => _viewTotalPrice = amount;

  void clearPrevData() {
    _addressIndex = 0;
    _acceptTerms = true;
    _paymentMethodIndex = -1;
    _selectedDateSlot = 0;
    _selectedTimeSlot = 0;
    _distance = null;
    _orderAttachment = null;
    _rawAttachment = null;
  }

  Future<void> initializeTimeSlot(Store store) async {
    _timeSlots =
        await checkoutServiceInterface.initializeTimeSlot(
          store,
          Get.find<GlobalController>().configModel!.scheduleOrderSlotDuration,
        ) ??
        [];
    _allTimeSlots = await checkoutServiceInterface.initializeTimeSlot(
      store,
      Get.find<GlobalController>().configModel!.scheduleOrderSlotDuration,
    );

    _validateSlot(_allTimeSlots!, 0, store.orderPlaceToScheduleInterval);
  }

  void _validateSlot(
    List<TimeSlotModel> slots,
    int dateIndex,
    int? interval, {
    bool notify = true,
  }) {
    _timeSlots =
        checkoutServiceInterface.validateTimeSlot(
          slots,
          dateIndex,
          interval,
          Get.find<GlobalController>()
              .configModel!
              .moduleConfig!
              .module!
              .orderPlaceToScheduleInterval,
        ) ??
        [];

    if (notify) {
      update();
    }
  }

  Future<void> pickPrescriptionImage({
    required bool isRemove,
    required bool isCamera,
  }) async {
    if (isRemove) {
      _pickedPrescriptions = [];
    } else {
      final xFile = await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );
      if (xFile != null) {
        _pickedPrescriptions.add(xFile);
      }
      update();
    }
  }

  void removePrescriptionImage(int index) {
    _pickedPrescriptions.removeAt(index);
    update();
  }

  bool isStoreClosed(bool today, bool active, List<Schedules>? schedules) {
    if (!active) {
      return true;
    }
    var date = DateTime.now();
    if (!today) {
      date = date.add(const Duration(days: 1));
    }
    var weekday = date.weekday;
    if (weekday == 7) {
      weekday = 0;
    }
    for (var index = 0; index < (schedules?.length ?? 0); index++) {
      if (weekday == schedules?[index].day) {
        return false;
      }
    }
    return true;
  }

  bool isStoreOpenNow(bool active, List<Schedules>? schedules) {
    if (isStoreClosed(true, active, schedules)) {
      return false;
    }
    var weekday = DateTime.now().weekday;
    if (weekday == 7) {
      weekday = 0;
    }
    for (var index = 0; index < schedules!.length; index++) {
      if (weekday == schedules[index].day &&
          DateConverter.isAvailable(
            schedules[index].openingTime,
            schedules[index].closingTime,
          )) {
        return true;
      }
    }
    return false;
  }

  bool isOpenNow(Store store) => store.open == 1 && store.active!;

  Future<num?> getDistanceInKM(
    LatLng originLatLng,
    LatLng destinationLatLng, {
    bool isDuration = false,
    bool fromDashboard = false,
  }) async {
    _distance = -1;
    final response = await checkoutServiceInterface.getDistanceInMeter(
      originLatLng,
      destinationLatLng,
    );
    try {
      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        if (isDuration) {
          final duration = response.body['duration'] as String;
          final parsedDuration = parseDuration(duration);
          _distance = parsedDuration / 3600;
        } else {
          final distanceMater = response.body['distanceMeters'] as num;
          _distance = distanceMater / 1000;
        }
      } else {
        if (!isDuration) {
          _distance =
              Geolocator.distanceBetween(
                originLatLng.latitude,
                originLatLng.longitude,
                destinationLatLng.latitude,
                destinationLatLng.longitude,
              ) /
              1000;
        }
      }
    } catch (e) {
      if (!isDuration) {
        _distance =
            Geolocator.distanceBetween(
              originLatLng.latitude,
              originLatLng.longitude,
              destinationLatLng.latitude,
              destinationLatLng.longitude,
            ) /
            1000;
      }
    }
    if (!fromDashboard) {
      await _getExtraCharge(_distance);
    }
    update();
    return _distance;
  }

  num parseDuration(String duration) {
    return num.tryParse(duration.replaceAll('s', '')) ?? 0.0;
  }

  Future<num?> _getExtraCharge(num? distance) async {
    _extraCharge = null;
    _extraCharge = await checkoutServiceInterface.getExtraCharge(distance);
    return _extraCharge;
  }

  Future<bool> checkBalanceStatus(num totalPrice, num discount) async {
    // final total = totalPrice - discount;
    if (isPartialPay) {
      changePartialPayment();
    }
    setPaymentMethod(-1);
    // if ((Get.find<GlobalController>().userInfoModel!.walletBalance! <
    //         total) &&
    //     (Get.find<GlobalController>().userInfoModel!.walletBalance! != 0.0)) {
    //   Get.dialog(
    //     PartialPayDialogWidget(isPartialPay: true, totalPrice: total),
    //     useSafeArea: false,
    //   );
    // } else {
    //   Get.dialog(
    //     PartialPayDialogWidget(isPartialPay: false, totalPrice: total),
    //     useSafeArea: false,
    //   );
    // }
    update();
    return true;
  }

  void selectOfflineBank(int index, {bool canUpdate = true}) {
    _selectedOfflineBankIndex = index;
    if (canUpdate) {
      update();
    }
  }

  void setInstruction(int index) {
    if (_selectedInstruction == index) {
      _selectedInstruction = -1;
    } else {
      _selectedInstruction = index;
    }
    update();
  }

  void toggleDmTipSave() {
    _isDmTipSave = !_isDmTipSave;
    update();
  }

  void stopLoader({bool canUpdate = true}) {
    _isLoading = false;
    if (canUpdate) {
      update();
    }
  }

  Future<String> placeOrder(
    PlaceOrderBodyModel placeOrderBody,
    int? zoneID,
    num amount,
    num? maximumCodOrderAmount,
    bool fromCart,
    bool isCashOnDeliveryActive,
    List<XFile>? orderAttachment, {
    bool isOfflinePay = false,
  }) async {
    final multiParts = <MultipartBody>[];
    for (final file in orderAttachment!) {
      multiParts.add(MultipartBody('order_attachment[]', file));
    }
    _isLoading = true;
    update();
    var orderID = '';
    var userID = '';
    final response = await checkoutServiceInterface.placeOrder(
      placeOrderBody,
      multiParts,
    );
    _isLoading = false;
    if (response.statusCode == 200) {
      final message = response.body['message'] as String?;
      orderID = response.body['order_id'].toString();
      if (response.body['user_id'] != null) {
        userID = response.body['user_id'].toString();
      }

      if (!isOfflinePay) {
        await callback(
          true,
          message,
          orderID,
          zoneID,
          amount,
          maximumCodOrderAmount,
          fromCart,
          isCashOnDeliveryActive,
          placeOrderBody.contactPersonNumber,
          userID,
        );
      } else {
        await Get.find<CartController>().getCartDataOnline();
      }
      _orderAttachment = null;
      _rawAttachment = null;
      if (kDebugMode) {
        debugPrint('-------- Order placed successfully $orderID ----------');
      }
    } else {
      if (!isOfflinePay) {
        await callback(
          false,
          response.statusText,
          '-1',
          zoneID,
          amount,
          maximumCodOrderAmount,
          fromCart,
          isCashOnDeliveryActive,
          placeOrderBody.contactPersonNumber,
          userID,
        );
      } else {
        showCustomSnackBar(response.statusText);
      }
    }
    update();

    return orderID;
  }

  Future<void> placePrescriptionOrder(
    int? storeId,
    int? zoneID,
    num? distance,
    String address,
    String longitude,
    String latitude,
    String note,
    List<XFile> orderAttachment,
    String dmTips,
    String deliveryInstruction,
    num orderAmount,
    num maxCodAmount,
    bool fromCart,
    bool isCashOnDeliveryActive,
  ) async {
    final multiParts = <MultipartBody>[];
    for (final file in orderAttachment) {
      multiParts.add(MultipartBody('order_attachment[]', file));
    }
    _isLoading = true;
    update();
    final response = await checkoutServiceInterface.placePrescriptionOrder(
      storeId,
      distance,
      address,
      longitude,
      latitude,
      note,
      multiParts,
      dmTips,
      deliveryInstruction,
    );
    _isLoading = false;
    if (response.statusCode == 200) {
      final message = response.body['message'] as String?;
      final orderID = response.body['order_id'].toString();
      await callback(
        true,
        message,
        orderID,
        zoneID,
        orderAmount,
        maxCodAmount,
        fromCart,
        isCashOnDeliveryActive,
        null,
        '',
      );
      _orderAttachment = null;
      _rawAttachment = null;
      if (kDebugMode) {
        debugPrint('-------- Order placed successfully $orderID ----------');
      }
    } else {
      await callback(
        false,
        response.statusText,
        '-1',
        zoneID,
        orderAmount,
        maxCodAmount,
        fromCart,
        isCashOnDeliveryActive,
        null,
        '',
      );
    }
    update();
  }

  Future<void> callback(
    bool isSuccess,
    String? message,
    String orderID,
    int? zoneID,
    num amount,
    num? maximumCodOrderAmount,
    bool fromCart,
    bool isCashOnDeliveryActive,
    String? contactNumber,
    String userID,
  ) async {
    // if (isSuccess) {
    //   if (fromCart) {
    //     Get.find<CartController>().clearCartList();
    //   }
    //   setGuestAddress(null);
    //   if (!Get.find<OrderController>().showBottomSheet) {
    //     Get.find<OrderController>().showRunningOrders(canUpdate: false);
    //   }
    //   if (isDmTipSave) {
    //     saveSharedPrefDmTipIndex(selectedTips.toString());
    //   }
    //   stopLoader(canUpdate: false);
    //   HomeScreen.loadData(true);
    //   if (paymentMethodIndex == 2) {
    //     if (GetPlatform.isWeb) {
    //       // Get.back();
    //       await Get.find<AuthController>().saveGuestNumber(contactNumber ?? '');
    //       final hostname = html.window.location.hostname;
    //       final protocol = html.window.location.protocol;
    //       String selectedUrl;
    //       selectedUrl =
    //           '${AppConstants.baseUrl}/payment-mobile?order_id=$orderID&&customer_id=${Get.find<GlobalController>().userInfoModel?.id ?? (userID.isNotEmpty ? userID : AuthHelper.getGuestId())}'
    //           '&payment_method=$digitalPaymentName&payment_platform=web&&callback=$protocol//$hostname${RouteHelper.orderSuccess}?id=$orderID&status=';

    //       html.window.open(selectedUrl, '_self');
    //     } else {
    //       Get.offNamed(
    //         RouteHelper.getPaymentRoute(
    //           orderID,
    //           Get.find<GlobalController>().userInfoModel?.id ??
    //               (userID.isNotEmpty ? int.parse(userID) : 0),
    //           orderType,
    //           amount,
    //           isCashOnDeliveryActive,
    //           digitalPaymentName,
    //           guestId: userID.isNotEmpty ? userID : AuthHelper.getGuestId(),
    //           contactNumber: contactNumber,
    //         ),
    //       );
    //     }
    //   } else {
    //     final num total = (amount / 100) *
    //         Get.find<GlobalController>()
    //             .configModel!
    //             .loyaltyPointItemPurchasePoint!;
    //     if (AuthHelper.isLoggedIn()) {
    //       Get.find<AuthController>().saveEarningPoint(total.toStringAsFixed(0));
    //     }
    //     if (ResponsiveHelper.isDesktop(Get.context) &&
    //         AuthHelper.isLoggedIn()) {
    //       Get.offNamed(RouteHelper.getInitialRoute());
    //       Future.delayed(
    //         const Duration(seconds: 2),
    //         () => Get.dialog(
    //           Center(
    //             child: SizedBox(
    //               height: 350,
    //               width: 500,
    //               child: OrderSuccessfulDialog(orderID: orderID),
    //             ),
    //           ),
    //         ),
    //       );
    //     } else {
    //       Get.offNamed(
    //         RouteHelper.getOrderSuccessRoute(
    //           orderID,
    //           contactNumber,
    //           createAccount: _isCreateAccount,
    //         ),
    //       );
    //     }
    //   }
    //   clearPrevData();
    //   Get.find<CouponController>().removeCouponData(false);
    //   updateTips(
    //     getSharedPrefDmTipIndex().isNotEmpty
    //         ? int.parse(getSharedPrefDmTipIndex())
    //         : 0,
    //     notify: false,
    //   );
    // } else {
    showCustomSnackBar(message);
    // }
  }

  void toggleExpand() {
    _isExpand = !_isExpand;
    update();
  }

  void updateTimeSlot(int index) {
    _selectedTimeSlot = index;
    update();
  }

  void updateDateSlot(int index, int? interval) {
    _selectedDateSlot = index;
    if (_allTimeSlots != null) {
      validateSlot(_allTimeSlots!, index, interval);
    }
    update();
  }

  void validateSlot(
    List<TimeSlotModel> slots,
    int dateIndex,
    int? interval, {
    bool notify = true,
  }) {
    _timeSlots = [];
    var now = DateTime.now();
    if (Get.find<GlobalController>()
        .configModel!
        .moduleConfig!
        .module!
        .orderPlaceToScheduleInterval!) {
      now = now.add(Duration(minutes: interval!));
    }
    var day = 0;
    if (dateIndex == 0) {
      day = DateTime.now().weekday;
    } else {
      day = DateTime.now().add(const Duration(days: 1)).weekday;
    }
    if (day == 7) {
      day = 0;
    }
    for (final slot in slots) {
      if (day == slot.day && (dateIndex == 1 || slot.endTime!.isAfter(now))) {
        // print('===>>> here slot filter $now = $dateIndex == $');
        _timeSlots.add(slot);
      }
    }
    if (notify) {
      update();
    }
  }

  bool _isCreateAccount = false;
  bool get isCreateAccount => _isCreateAccount;

  void toggleCreateAccount({bool willUpdate = true}) {
    _isCreateAccount = !_isCreateAccount;
    if (willUpdate) {
      update();
    }
  }

  Future<Store?> getStoreDetails(
    Store store,
    bool fromModule, {
    bool fromCart = false,
    String slug = '',
  }) async {
    _isLoading = true;
    _store = null;
    final storeDetails = await Get.find<StoreRepositoryInterface>()
        .getStoreDetails(
          store.id.toString(),
          fromCart,
          slug,
          Get.find<GlobalController>().locale.value.languageCode,
          ModuleHelper.getModule(),
          ModuleHelper.getCacheModule()?.id,
          ModuleHelper.getModule()?.id,
        );
    '===>>>> storeDetails api called === ${storeDetails?.toJson()}'.print;
    _store = storeDetails;
    await Get.find<CheckoutController>().initializeTimeSlot(_store!);
    if (!fromCart && slug.isEmpty) {
      await Get.find<CheckoutController>().getDistanceInKM(
        LatLng(
          double.parse(AddressHelper.getUserAddressFromSharedPref()!.latitude!),
          double.parse(
            AddressHelper.getUserAddressFromSharedPref()!.longitude!,
          ),
        ),
        LatLng(
          double.parse(_store!.latitude!),
          double.parse(_store!.longitude!),
        ),
      );
    }

    // Get.find<CheckoutController>().clearPrevData();
    Get.find<CheckoutController>().setOrderType(
      _store != null
          ? _store!.delivery!
                ? 'delivery'
                : 'take_away'
          : 'delivery',
      notify: false,
    );
    _isLoading = false;
    update();
    return _store;
  }
}
