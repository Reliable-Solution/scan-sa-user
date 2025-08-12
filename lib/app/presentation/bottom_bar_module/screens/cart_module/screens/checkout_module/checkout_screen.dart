import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_repo/auth_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/controller/bottom_bar_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/controllers/checkout_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/delivery_instruction_view.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/payment_selection_sheet.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/controllers/coupon_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/controller/location_controller.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_drop_down.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_rich_text.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/app/widgets/selection_circle.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/date_converter.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, this.isFromBottom = false});
  final bool isFromBottom;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final checkoutController = Get.put(
    CheckoutController(checkoutServiceInterface: Get.find()),
  );

  final num _taxPercent = 0;
  bool? _isCashOnDeliveryActive = false;
  bool? _isDigitalPaymentActive = false;
  bool isOfflinePaymentActive = false;
  String deliveryChargeForView = '';
  num? _payableAmount = 0;
  final bool _isWalletActive = false;
  bool _firstTimeCheckPayment = false;

  bool isLoad = false;

  @override
  void initState() {
    isLoad = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoad = false;
      });
    });
    Get.put(LocationController(locationServiceInterface: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => checkoutController.initCall(widget.isFromBottom),
    );
    super.initState();
  }

  num badWeatherChargeForToolTip = 0;
  num extraChargeForToolTip = 0;
  bool isPassedVariationPrice = false;

  @override
  Widget build(BuildContext context) {
    final module =
        Get.find<GlobalController>().configModel!.moduleConfig!.module;
    // final guestCheckoutPermission =
    //     Get.find<GlobalController>().configModel!.guestCheckoutStatus!;

    final takeAway = checkoutController.orderType == 'take_away';
    final bottomScreen = Get.find<BottomBarController>().selectedScreen.value;
    final isHomeDelivery = bottomScreen == 1;
    final isFromQrScanner = Get.arguments is bool && Get.arguments as bool;
    return CommonSubScreen(
      appBarTitle: context.l10n.checkout,
      // btnText: context.l10n.placeOrder,
      // onTap: () {},
      child: isLoad
          ? const SizedBox.shrink()
          : GetBuilder<CheckoutController>(
              builder: (checkoutController) {
                final moduleData = _getModuleData(
                  store: checkoutController.store,
                );
                _isCashOnDeliveryActive = _checkCODActive(
                  store: checkoutController.store,
                );
                _isDigitalPaymentActive = _checkDigitalPaymentActive(
                  store: checkoutController.store,
                );
                isOfflinePaymentActive =
                    Get.find<GlobalController>()
                        .configModel!
                        .offlinePaymentStatus! &&
                    _checkZoneOfflinePaymentOnOff(
                      addressModel:
                          AddressHelper.getUserAddressFromSharedPref(),
                      checkoutController: checkoutController,
                    );
                final isTodayClosed = checkoutController.isStoreClosed(
                  true,
                  checkoutController.store?.active ?? true,
                  checkoutController.store?.schedules,
                )..print;
                final isTomorrowClosed = checkoutController.isStoreClosed(
                  false,
                  checkoutController.store?.active ?? true,
                  checkoutController.store?.schedules,
                )..print;
                // }

                return GetBuilder<CouponController>(
                  builder: (couponController) {
                    // num? maxCodOrderAmount;

                    if (moduleData != null) {
                      // maxCodOrderAmount = moduleData.maximumCodOrderAmount;
                    }
                    final price = _calculatePrice(
                      store: checkoutController.store,
                      cartList: checkoutController.cartList,
                    );

                    final addOns = _calculateAddonsPrice(
                      store: checkoutController.store,
                      cartList: checkoutController.cartList,
                    );

                    final variations = _calculateVariationPrice(
                      store: checkoutController.store,
                      cartList: checkoutController.cartList,
                      calculateWithoutDiscount: true,
                    );

                    final discount = _calculateDiscount(
                      store: checkoutController.store,
                      cartList: checkoutController.cartList,
                      price: price,
                      addOns: addOns,
                    );

                    final couponDiscount = PriceConverter.toFixed(
                      couponController.discount!,
                    );

                    final taxIncluded =
                        Get.find<GlobalController>().configModel!.taxIncluded ==
                        1;

                    final subTotal = _calculateSubTotal(
                      price: price,
                      addOns: addOns,
                      variations: variations,
                      cartList: checkoutController.cartList,
                    );

                    final referralDiscount = _calculateReferralDiscount(
                      subTotal,
                      discount,
                      couponDiscount,
                    );

                    final orderAmount = _calculateOrderAmount(
                      price: price,
                      variations: variations,
                      discount: discount,
                      addOns: addOns,
                      couponDiscount: couponDiscount,
                      cartList: checkoutController.cartList,
                      referralDiscount: referralDiscount,
                    );

                    final tax = _calculateTax(
                      taxIncluded: taxIncluded,
                      orderAmount: orderAmount,
                      taxPercent: _taxPercent,
                    );

                    final additionalCharge =
                        Get.find<GlobalController>()
                            .configModel!
                            .additionalChargeStatus!
                        ? Get.find<GlobalController>()
                              .configModel!
                              .additionCharge!
                        : 0;

                    // final originalCharge = _calculateOriginalDeliveryCharge(
                    //   store: checkoutController.store,
                    //   address: AddressHelper.getUserAddressFromSharedPref()!,
                    //   distance: checkoutController.distance,
                    //   extraCharge: checkoutController.extraCharge,
                    // );
                    final deliveryCharge = _calculateDeliveryCharge(
                      store: checkoutController.store,
                      address: AddressHelper.getUserAddressFromSharedPref()!,
                      distance: checkoutController.distance,
                      extraCharge: checkoutController.extraCharge,
                      orderType: checkoutController.orderType!,
                      orderAmount: orderAmount,
                    );

                    if (checkoutController.orderType != 'take_away' &&
                        checkoutController.store != null) {
                      deliveryChargeForView =
                          checkoutController.store!.freeDelivery!
                          ? 'free'.tr
                          : deliveryCharge != -1
                          ? PriceConverter.convertPrice(deliveryCharge)
                          : 'calculating'.tr;
                    }

                    final extraPackagingCharge = _calculateExtraPackagingCharge(
                      checkoutController,
                    );

                    var total = _calculateTotal(
                      subTotal: subTotal,
                      deliveryCharge: deliveryCharge,
                      discount: discount,
                      couponDiscount: couponDiscount,
                      taxIncluded: taxIncluded,
                      tax: tax,
                      orderType: checkoutController.orderType!,
                      tips: checkoutController.tips,
                      additionalCharge: additionalCharge,
                      extraPackagingCharge: extraPackagingCharge,
                    );

                    // final isPrescriptionRequired = _checkPrescriptionRequired();

                    total = total - referralDiscount;

                    if (checkoutController.store != null) {
                      checkoutController.setPaymentMethod(0, isUpdate: false);
                    }
                    checkoutController.viewTotalPrice =
                        total -
                        (checkoutController.isPartialPay
                            ? Get.find<GlobalController>()
                                  .userInfoModel!
                                  .walletBalance!
                            : 0);

                    if (_payableAmount != checkoutController.viewTotalPrice &&
                        checkoutController.distance != null) {
                      _payableAmount = checkoutController.viewTotalPrice;
                      // showCashBackSnackBar();
                    }

                    _setSinglePaymentActive();
                    return ListView(
                      padding: const EdgeInsets.only(top: 20),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.appPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isHomeDelivery)
                                Text(
                                  context.l10n.deliveryAddress,
                                  style: context.style.s18w700.copyWith(
                                    color: context.color.primary,
                                  ),
                                ),
                              if (isHomeDelivery)
                                GetBuilder<LocationController>(
                                  builder: (locationController) {
                                    return AppDropDown(
                                      itemList: locationController.addressList
                                          .map(
                                            (e) =>
                                                '${e.id}--${e.addressType}--${e.address}',
                                          )
                                          .toList(),
                                      selectedItem:
                                          checkoutController.selectedAddress,
                                      child: (item) => Row(
                                        spacing: 17,
                                        children: [
                                          SvgAssets(
                                            switch (item.split('--')[1]) {
                                              'Home' => AppIcons.homeAddressIc,
                                              'Office' =>
                                                AppIcons.officeAddressIc,
                                              _ => AppIcons.otherAddressIc,
                                            },
                                            color:
                                                Get.find<GlobalController>()
                                                    .isDark
                                                ? context.color.lightText
                                                : null,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              spacing: 3,
                                              children: [
                                                Text(
                                                  item.split('--')[1],
                                                  style: context.style.s18w700
                                                      .copyWith(
                                                        color: context
                                                            .color
                                                            .primary,
                                                      ),
                                                ),
                                                Text(
                                                  item.split('--').last,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: context.style.s12w700
                                                      .copyWith(
                                                        color: context
                                                            .color
                                                            .ff6c6c6c,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      onChanged: (value) => checkoutController
                                        ..selectedAddress = value
                                        ..update(),
                                    );
                                  },
                                ),
                              if (isHomeDelivery)
                                AppTextField(
                                  hintText: context.l10n.streetNumber,
                                ),
                              if (isHomeDelivery)
                                Row(
                                  spacing: 12,
                                  children: [
                                    Expanded(
                                      child: AppTextField(
                                        hintText: context.l10n.house,
                                        bottomPadding: 0,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppTextField(
                                        hintText: context.l10n.floor,
                                        bottomPadding: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              if (!(checkoutController.store?.scheduleOrder ??
                                      true) &&
                                  !isHomeDelivery &&
                                  !isFromQrScanner)
                                Text(
                                  context.l10n.preferenceTime,
                                  style: context.style.s18w700.copyWith(
                                    color: context.color.primary,
                                  ),
                                ),
                              if (!(checkoutController.store?.scheduleOrder ??
                                      true) &&
                                  !isHomeDelivery &&
                                  !isFromQrScanner)
                                GestureDetector(
                                  onTap: () {
                                    checkoutController.updateDateSlot(
                                      0,
                                      checkoutController
                                          .store!
                                          .orderPlaceToScheduleInterval,
                                    );
                                    AppPages.slotSelectionScreen.push(
                                      arguments: {
                                        'isTodayClosed': isTodayClosed,
                                        'isTomorrowClosed': isTomorrowClosed,
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: context.color.borderColor,
                                        width: 2,
                                      ),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.sp,
                                      vertical: 15.sp,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          checkoutController
                                                  .selectedTime
                                                  .value
                                                  .isEmpty
                                              ? context.l10n.select
                                              : checkoutController
                                                    .selectedTime
                                                    .value,
                                          style: context.style.s16w700.copyWith(
                                            color:
                                                checkoutController
                                                    .selectedTime
                                                    .value
                                                    .isEmpty
                                                ? context.color.ff9c9c9c
                                                : context.color.primary,
                                          ),
                                        ),
                                        SvgAssets(AppIcons.clockSuffixIc),
                                      ],
                                    ),
                                  ),
                                ),
                              if (isHomeDelivery)
                                const DeliveryInstructionView(),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: isFromQrScanner ? 0 : 20,
                                ),
                                child: Text(
                                  context.l10n.addNotes,
                                  style: context.style.s18w700.copyWith(
                                    color: context.color.primary,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: AppTextField(
                                  hintText:
                                      'Example: Please provide extra napkin',
                                  hintStyle: context.style.s16w700.copyWith(
                                    color: context.color.ff9c9c9c,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                              otherWidget(
                                context,
                                icon: AppIcons.card,
                                title: context.l10n.choosePaymentMethod,
                                onTap: showPaymentSelectionSheet,
                              ),
                              Obx(() {
                                final paymentMethod =
                                    checkoutController.selectedMethod.value;
                                return (paymentMethod?.isEmpty ?? false)
                                    ? const SizedBox.shrink()
                                    : Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons
                                                  .subdirectory_arrow_right_rounded,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 8,
                                            ),
                                            child: SvgAssets(
                                              switch (paymentMethod) {
                                                'Cash' => AppIcons.cash,
                                                'Wallet' => AppIcons.wallet,
                                                'Elm' => AppIcons.elm,
                                                _ => AppIcons.cashFree,
                                              },
                                            ),
                                          ),
                                          Text(
                                            paymentMethod ?? '',
                                            style: context.style.s18w700
                                                .copyWith(
                                                  color: context.color.ff6c6c6c,
                                                ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '120 ${AppStrings.dinar}',
                                            style: context.style.s18w700
                                                .copyWith(
                                                  color: context.color.ff6c6c6c,
                                                ),
                                          ),
                                        ],
                                      );
                              }),
                              Divider(
                                color: context.color.borderColor,
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: couponController.discount! > 0
                                      ? 0
                                      : 10,
                                ),
                                child: otherWidget(
                                  context,
                                  icon: AppIcons.promo,
                                  title: context.l10n.gotPromoCode,
                                  onTap: () => widget.isFromBottom
                                      ? AppPages.promoCodeScreen.push(
                                          arguments: {
                                            'order':
                                                (price - discount) +
                                                addOns +
                                                variations,
                                            'deliveryCharge': deliveryCharge,
                                            'storeId':
                                                checkoutController.store?.id,
                                            'total': total,
                                          },
                                        )
                                      : AppPages.promoCodeCartScreen.push(
                                          arguments: {
                                            'order':
                                                (price - discount) +
                                                addOns +
                                                variations,
                                            'deliveryCharge': deliveryCharge,
                                            'storeId':
                                                checkoutController.store?.id,
                                            'total': total,
                                          },
                                        ),
                                  turn: 3,
                                ),
                              ),
                              if (couponController.discount! > 0)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    spacing: 10,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons
                                              .subdirectory_arrow_right_rounded,
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //     left: 10,
                                      //     right: 8,
                                      //   ),
                                      //   child: SvgAssets(switch (paymentMethod) {
                                      //     'Cash' => AppIcons.cash,
                                      //     'Wallet' => AppIcons.wallet,
                                      //     'Elm' => AppIcons.elm,
                                      //     _ => AppIcons.cashFree,
                                      //   }),
                                      // ),
                                      Text(
                                        checkoutController.appliedCoupon,
                                        style: context.style.s18w700.copyWith(
                                          color: context.color.ff6c6c6c,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        PriceConverter.convertPrice(
                                          couponController.discount,
                                        ),
                                        style: context.style.s18w700.copyWith(
                                          color: context.color.ff6c6c6c,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          total =
                                              total +
                                              couponController.discount!;
                                          Get.find<CouponController>()
                                              .removeCouponData(true);
                                          checkoutController
                                                  .couponController
                                                  .text =
                                              '';
                                          if (checkoutController.isPartialPay ||
                                              checkoutController
                                                      .paymentMethodIndex ==
                                                  1) {
                                            checkoutController
                                                .checkBalanceStatus(total, 0);
                                          }
                                        },
                                        child: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SvgAssets(
                          AppIcons.zigZag,
                          width: MediaQuery.sizeOf(context).width,
                          color: Get.find<GlobalController>().isDark
                              ? context.color.whiteLight
                              : null,
                        ),
                        ColoredBox(
                          color: Get.find<GlobalController>().isDark
                              ? context.color.whiteLight
                              : context.color.fff5f5f5,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.appPadding,
                            ).copyWith(top: 15, bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n.summary,
                                  style: context.style.s18w700.copyWith(
                                    color: context.color.primary,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: rowText(
                                    context,
                                    title: (module?.addOn ?? false)
                                        ? 'Sub Total'
                                        : context.l10n.itemPrice,
                                    price: subTotal.toString(),
                                  ),
                                ),
                                rowText(
                                  context,
                                  title: context.l10n.discount,
                                  price:
                                      '(-) ${PriceConverter.convertPrice(discount)}',
                                ),
                                if (couponController.discount! > 0 ||
                                    couponController.freeDelivery)
                                  rowText(
                                    context,
                                    title: 'Coupon Discount',
                                    price:
                                        couponController.coupon != null &&
                                            couponController
                                                    .coupon!
                                                    .couponType ==
                                                'free_delivery'
                                        ? 'Free Delivery'
                                        : '(-) ${PriceConverter.convertPrice(couponController.discount)}',
                                  ),
                                if (referralDiscount > 0)
                                  rowText(
                                    context,
                                    title: 'Referral Discount',
                                    price:
                                        '(-) ${PriceConverter.convertPrice(referralDiscount)}',
                                  ),
                                rowText(
                                  context,
                                  title: context.l10n.vatTax,
                                  price:
                                      (taxIncluded ? '' : '(+) ') +
                                      PriceConverter.convertPrice(tax),
                                ),
                                if (!takeAway &&
                                    Get.find<GlobalController>()
                                            .configModel!
                                            .dmTipsStatus ==
                                        1)
                                  rowText(
                                    context,
                                    title: context.l10n.deliveryFee,
                                    price:
                                        '(+) ${PriceConverter.convertPrice(checkoutController.tips)}',
                                    // child: Container(
                                    //   decoration: BoxDecoration(
                                    //     color: context.color.secondary,
                                    //     borderRadius: BorderRadius.circular(3),
                                    //   ),
                                    //   padding: const EdgeInsets.symmetric(
                                    //     vertical: 3,
                                    //     horizontal: 6,
                                    //   ),
                                    //   child: Row(
                                    //     spacing: 4,
                                    //     children: [
                                    //       SvgAssets(AppIcons.deliveryBoyIc),
                                    //       Text(
                                    //         context.l10n.free,
                                    //         style: context.style.s12w700.copyWith(
                                    //           color: Colors.black,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ),
                                Builder(
                                  builder: (context) {
                                    '===... coupon $deliveryCharge'.print;
                                    return rowText(
                                      context,
                                      title: 'Delivery Fee',
                                      price: checkoutController.distance == -1
                                          ? 'Calculating'
                                          : (deliveryCharge == 0 ||
                                                (couponController.coupon !=
                                                        null &&
                                                    couponController
                                                            .coupon!
                                                            .couponType ==
                                                        'free_delivery'))
                                          ? 'Free'
                                          : '(+) ${PriceConverter.convertPrice(deliveryCharge)}',
                                    );
                                  },
                                ),
                                if (Get.find<GlobalController>()
                                    .configModel!
                                    .additionalChargeStatus!)
                                  rowText(
                                    context,
                                    title:
                                        Get.find<GlobalController>()
                                            .configModel!
                                            .additionalChargeName ??
                                        '',
                                    price:
                                        '(+) ${PriceConverter.convertPrice(Get.find<GlobalController>().configModel!.additionCharge)}',
                                  ),
                                if (checkoutController.isPartialPay)
                                  rowText(
                                    context,
                                    title: 'Paid by wallet',
                                    price:
                                        '(+) ${PriceConverter.convertPrice(Get.find<GlobalController>().configModel!.additionCharge)}',
                                  ),

                                if (checkoutController.isPartialPay)
                                  rowText(
                                    context,
                                    title: 'Due amount',
                                    price: checkoutController.viewTotalPrice
                                        .toString(),
                                  ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 11),
                                  child: Divider(
                                    color: Get.find<GlobalController>().isDark
                                        ? context.color.ff6c6c6c
                                        : const Color(0xFFCCCCCC),
                                    height: 20,
                                  ),
                                ),
                                AppRichText(
                                  text1: '${context.l10n.agreeWith} ',
                                  text2:
                                      '${context.l10n.privacyPolicy}, ${context.l10n.termsConditions}',
                                  text3: ' ${context.l10n.and} ',
                                  text4: context.l10n.refundPolicy,
                                  textStyle1: context.style.s16w700.copyWith(
                                    color: context.color.ff6c6c6c,
                                  ),
                                  textStyle2: context.style.s16w700.copyWith(
                                    color: context.color.secondary,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: AppButton(
                                    label:
                                        '${context.l10n.placeOrder} ${PriceConverter.convertPrice(total)}',
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }

  Widget selectionWidget(
    BuildContext context, {
    required String title,
    required String price,
    required bool isSelected,
  }) {
    final checkoutProvider = Get.find<CheckoutController>();
    return GestureDetector(
      onTap: () => checkoutProvider.changeDeliveryType(
        title == context.l10n.homeDelivery,
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? context.color.greenColor
                : context.color.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          spacing: 13,
          children: [
            SelectionCircle(isSelected: isSelected),
            Text(
              title,
              style: context.style.s18w700.copyWith(
                color: isSelected
                    ? context.color.greenColor
                    : context.color.ff6c6c6c,
              ),
            ),
            const Spacer(),
            Text(
              price,
              style: context.style.s16w700.copyWith(
                color: isSelected
                    ? context.color.greenColor
                    : context.color.ff6c6c6c,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowText(
    BuildContext context, {
    required String title,
    required String price,
    Widget? child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.style.s16w700.copyWith(
              color: Get.find<GlobalController>().isDark
                  ? context.color.ff6c6c6c
                  : context.color.ff455A64,
            ),
          ),
          child ??
              Text(
                price,
                style: context.style.s16w700.copyWith(
                  color: Get.find<GlobalController>().isDark
                      ? context.color.ff6c6c6c
                      : context.color.ff455A64,
                ),
              ),
        ],
      ),
    );
  }

  Widget otherWidget(
    BuildContext context, {
    required String icon,
    required String title,
    required Function() onTap,
    int? turn,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          spacing: 8,
          children: [
            SvgAssets(AppIcons.promo),
            Text(
              title,
              style: context.style.s18w700.copyWith(
                color: context.color.ff9c9c9c,
              ),
            ),
            const Spacer(),
            RotatedBox(
              quarterTurns: turn ?? 0,
              child: SvgAssets(
                AppIcons.arrowBottomIc,
                color: context.color.ff9c9c9c,
                height: 10.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Pivot? _getModuleData({required Store? store}) {
    Pivot? moduleData;
    if (store != null) {
      for (final zData
          in AddressHelper.getUserAddressFromSharedPref()?.zoneData ??
              <ZoneData>[]) {
        for (final m in zData.modules!) {
          if (m.id == Get.find<GlobalController>().module!.id &&
              m.pivot!.zoneId == store.zoneId) {
            moduleData = m.pivot;
            break;
          }
        }
      }
    }
    return moduleData;
  }

  bool _checkCODActive({required Store? store}) {
    var isCashOnDeliveryActive = false;
    if (store != null) {
      for (final zData
          in AddressHelper.getUserAddressFromSharedPref()?.zoneData ??
              <ZoneData>[]) {
        if (zData.id == store.zoneId) {
          isCashOnDeliveryActive =
              zData.cashOnDelivery! &&
              Get.find<GlobalController>().configModel!.cashOnDelivery!;
        }
      }
    }
    return isCashOnDeliveryActive;
  }

  bool _checkDigitalPaymentActive({required Store? store}) {
    var isDigitalPaymentActive = false;
    if (store != null) {
      for (final zData
          in AddressHelper.getUserAddressFromSharedPref()?.zoneData ??
              <ZoneData>[]) {
        if (zData.id == store.zoneId) {
          isDigitalPaymentActive =
              zData.digitalPayment! &&
              Get.find<GlobalController>().configModel!.digitalPayment!;
        }
      }
    }
    return isDigitalPaymentActive;
  }

  num _calculatePrice({
    required Store? store,
    required List<CartModel?> cartList,
  }) {
    num price = 0;
    try {
      'cartList ==. ${cartList.length}'.print;
      for (final cartModel in cartList) {
        if (Get.find<GlobalController>()
                .getModuleConfig(cartModel?.item!.moduleType)
                ?.newVariation ??
            false) {
          price += cartModel!.item!.price! * cartModel.quantity!;
        } else {
          '==>>> _calculatePrice ==>> ${cartModel!.variation?.isEmpty}'
                  ' == ${cartModel.item!.price! * cartModel.quantity!}'
              .print;
          price += cartModel.variation?.isEmpty ?? true
              ? (cartModel.item!.price! * cartModel.quantity!)
              : _calculateVariationPrice(store: store, cartList: cartList);
        }
      }
    } catch (e) {
      '==>>> _calculatePrice ==>> $e'.print;
    }
    return PriceConverter.toFixed(price);
  }

  num _calculateAddonsPrice({
    required Store? store,
    required List<CartModel?>? cartList,
  }) {
    num addOns = 0;
    if (store != null && cartList != null) {
      for (final cartModel in cartList) {
        final addOnList = <AddOns>[];
        for (final addOnId in cartModel?.addOnIds ?? <AddOn>[]) {
          for (final addOns in cartModel?.item?.addOns ?? <AddOns>[]) {
            if (addOns.id == addOnId.id) {
              addOnList.add(addOns);
              break;
            }
          }
        }
        for (var index = 0; index < addOnList.length; index++) {
          addOns =
              addOns +
              ((addOnList[index].price ?? 0) *
                  (cartModel?.addOnIds?[index].quantity ?? 0));
        }
      }
    }
    return PriceConverter.toFixed(addOns);
  }

  num _calculateVariationPrice({
    required Store? store,
    required List<CartModel?> cartList,
    bool calculateDiscount = false,
    bool calculateWithoutDiscount = false,
  }) {
    num variationPrice = 0;
    num variationDiscount = 0;
    if (store != null) {
      for (final cartModel in cartList) {
        final num? discount = cartModel!.item!.storeDiscount == 0
            ? cartModel.item!.discount
            : cartModel.item!.storeDiscount;
        final discountType = cartModel.item!.storeDiscount == 0
            ? cartModel.item!.discountType
            : 'percent';

        if (Get.find<GlobalController>()
                .getModuleConfig(cartModel.item!.moduleType)
                ?.newVariation ??
            false) {
          isPassedVariationPrice = true;
          for (
            var index = 0;
            index < cartModel.item!.foodVariations!.length;
            index++
          ) {
            for (
              var i = 0;
              i <
                  cartModel
                      .item!
                      .foodVariations![index]
                      .variationValues!
                      .length;
              i++
            ) {
              if (cartModel.foodVariations![index][i]!) {
                variationPrice +=
                    PriceConverter.convertWithDiscount(
                      cartModel
                          .item!
                          .foodVariations![index]
                          .variationValues![i]
                          .optionPrice,
                      discount,
                      discountType,
                      isFoodVariation: true,
                    )! *
                    cartModel.quantity!;
                variationDiscount +=
                    cartModel
                        .item!
                        .foodVariations![index]
                        .variationValues![i]
                        .optionPrice! *
                    cartModel.quantity!;
              }
            }
          }
        } else {
          var variationType = '';
          for (var i = 0; i < (cartModel.variation?.length ?? 0); i++) {
            variationType = cartModel.variation?[i].type ?? '';
          }
          if (cartModel.item?.variations?.isNotEmpty ?? false) {
            for (final variation in cartModel.item!.variations!) {
              if (variation.type == variationType) {
                variationPrice += variation.price! * cartModel.quantity!;
                break;
              }
            }
          } else {
            variationDiscount +=
                PriceConverter.convertWithDiscount(
                  cartModel.item!.price,
                  discount,
                  discountType,
                )! *
                cartModel.quantity!;
            variationPrice += cartModel.item!.price! * cartModel.quantity!;
          }
        }
      }
    }
    if (calculateDiscount) {
      return variationDiscount - variationPrice;
    } else if (calculateWithoutDiscount) {
      return variationDiscount;
    } else {
      return variationPrice;
    }
  }

  num _calculateDiscount({
    required Store? store,
    required List<CartModel?>? cartList,
    required num price,
    required num addOns,
  }) {
    num discount = 0;
    if (store != null && cartList != null) {
      for (final cartModel in cartList) {
        final dis =
            (store.discount != null &&
                    DateConverter.isAvailable(
                      store.discount!.startTime,
                      store.discount!.endTime,
                    )) &&
                cartModel!.item!.flashSale != 1
            ? store.discount!.discount
            : cartModel!.item!.discount;
        final disType =
            (store.discount != null &&
                    DateConverter.isAvailable(
                      store.discount!.startTime,
                      store.discount!.endTime,
                    )) &&
                cartModel.item!.flashSale != 1
            ? 'percent'
            : cartModel.item!.discountType;
        if (Get.find<GlobalController>()
                .getModuleConfig(cartModel.item!.moduleType)
                ?.newVariation ??
            false) {
          final num d =
              (cartModel.item!.price! -
                  PriceConverter.convertWithDiscount(
                    cartModel.item!.price,
                    dis,
                    disType,
                  )!) *
              cartModel.quantity!;
          discount = discount + d;
          if (disType == 'percent' && discount != 0) {
            discount =
                discount +
                _calculateFoodVariationDiscount(cartModel: cartModel);
          }
        } else {
          var variationType = '';
          num variationPrice = 0;
          num variationWithoutDiscountPrice = 0;
          for (var i = 0; i < cartModel.variation!.length; i++) {
            variationType = cartModel.variation![i].type!;
          }
          if (cartModel.item!.variations!.isNotEmpty) {
            for (final variation in cartModel.item!.variations!) {
              if (variation.type == variationType) {
                variationPrice +=
                    PriceConverter.convertWithDiscount(
                      variation.price,
                      dis,
                      disType,
                    )! *
                    cartModel.quantity!;
                variationWithoutDiscountPrice +=
                    variation.price! * cartModel.quantity!;
                break;
              }
            }
            discount =
                discount + (variationWithoutDiscountPrice - variationPrice);
          } else {
            final num d =
                (cartModel.item!.price! -
                    PriceConverter.convertWithDiscount(
                      cartModel.item!.price,
                      dis,
                      disType,
                    )!) *
                cartModel.quantity!;
            discount = discount + d;
          }
        }
      }
    }

    if (store != null && store.discount != null) {
      if (store.discount!.maxDiscount != 0 &&
          store.discount!.maxDiscount! < discount) {
        discount = store.discount!.maxDiscount!;
      }
      if (store.discount!.minPurchase != 0 &&
          store.discount!.minPurchase! > (price + addOns)) {
        discount = 0;
      }
    }
    return PriceConverter.toFixed(discount);
  }

  num _calculateFoodVariationDiscount({required CartModel? cartModel}) {
    num variationPrice = 0;
    num variationDiscount = 0;
    if (cartModel != null) {
      final num? discount = cartModel.item!.storeDiscount == 0
          ? cartModel.item!.discount
          : cartModel.item!.storeDiscount;
      final discountType = cartModel.item!.storeDiscount == 0
          ? cartModel.item!.discountType
          : 'percent';
      for (
        var index = 0;
        index < cartModel.item!.foodVariations!.length;
        index++
      ) {
        for (
          var i = 0;
          i < cartModel.item!.foodVariations![index].variationValues!.length;
          i++
        ) {
          if (cartModel.foodVariations![index][i]!) {
            variationPrice +=
                PriceConverter.convertWithDiscount(
                  cartModel
                      .item!
                      .foodVariations![index]
                      .variationValues![i]
                      .optionPrice,
                  discount,
                  discountType,
                  isFoodVariation: true,
                )! *
                cartModel.quantity!;
            variationDiscount +=
                cartModel
                    .item!
                    .foodVariations![index]
                    .variationValues![i]
                    .optionPrice! *
                cartModel.quantity!;
          }
        }
      }
    }
    return variationDiscount - variationPrice;
  }

  num _calculateOrderAmount({
    required num price,
    required num variations,
    required num discount,
    required num addOns,
    required num couponDiscount,
    required List<CartModel?>? cartList,
    required num referralDiscount,
  }) {
    num orderAmount = 0;
    num variationPrice = 0;
    if (cartList != null &&
        cartList.isNotEmpty &&
        (Get.find<GlobalController>()
                .getModuleConfig(cartList[0]?.item?.moduleType)
                ?.newVariation ??
            false)) {
      variationPrice = variations;
    }
    orderAmount =
        (price + variationPrice - discount) +
        addOns -
        couponDiscount -
        referralDiscount;
    return PriceConverter.toFixed(orderAmount);
  }

  num _calculateTax({
    required bool taxIncluded,
    required num orderAmount,
    required num? taxPercent,
  }) {
    num tax = 0;
    if (taxIncluded) {
      tax = orderAmount * taxPercent! / (100 + taxPercent);
    } else {
      tax = PriceConverter.calculation(orderAmount, taxPercent, 'percent', 1);
    }
    return PriceConverter.toFixed(tax);
  }

  num _calculateSubTotal({
    required num price,
    required num addOns,
    required num variations,
    required List<CartModel?>? cartList,
  }) {
    '==>>> here sub total calcultation $price == $addOns'.print;
    num subTotal = 0;
    var isFoodVariation = false;

    if (cartList != null && cartList.isNotEmpty) {
      isFoodVariation =
          Get.find<GlobalController>()
              .getModuleConfig(cartList[0]!.item!.moduleType)
              ?.newVariation ??
          false;
    }
    if (isFoodVariation) {
      subTotal = price + addOns + variations;
    } else {
      subTotal = price;
    }

    return subTotal;
  }

  num _calculateOriginalDeliveryCharge({
    required Store? store,
    required AddressModel address,
    required num? distance,
    required num? extraCharge,
  }) {
    num deliveryCharge = -1;

    Pivot? moduleData;
    ZoneData? zoneData;
    if (store != null) {
      for (final zData in address.zoneData ?? <ZoneData>[]) {
        for (final m in zData.modules!) {
          if (m.id == Get.find<GlobalController>().module!.id &&
              m.pivot!.zoneId == store.zoneId) {
            moduleData = m.pivot;
            break;
          }
        }

        if (zData.id == store.zoneId) {
          zoneData = zData;
        }
      }
    }
    num perKmCharge = 0;
    num minimumCharge = 0;
    num? maximumCharge = 0;
    if (store != null &&
        distance != null &&
        distance != -1 &&
        store.selfDeliverySystem == 1) {
      perKmCharge = store.perKmShippingCharge ?? 0;
      minimumCharge = store.minimumShippingCharge ?? 0;
      maximumCharge = store.maximumShippingCharge;
    } else if (store != null &&
        distance != null &&
        distance != -1 &&
        moduleData != null) {
      perKmCharge = moduleData.perKmShippingCharge ?? 0;
      minimumCharge = moduleData.minimumShippingCharge ?? 0;
      maximumCharge = moduleData.maximumShippingCharge;
    }
    if (store != null && distance != null) {
      deliveryCharge = distance * perKmCharge;
      ('===>>> here calculation 6 $distance $deliveryCharge').print;
      if (deliveryCharge < minimumCharge) {
        deliveryCharge = minimumCharge;
      } else if (deliveryCharge > (maximumCharge ?? 0)) {
        deliveryCharge = maximumCharge ?? 0;
      }
    }
    ('===>>> here calculation 7 $deliveryCharge').print;

    if (store != null && store.selfDeliverySystem == 0 && extraCharge != null) {
      extraChargeForToolTip = extraCharge;
      deliveryCharge = deliveryCharge + extraCharge;
    }
    ('===>>> here calculation 8 $deliveryCharge').print;
    if (store != null &&
        store.selfDeliverySystem == 0 &&
        zoneData != null &&
        zoneData.increaseDeliveryFeeStatus == 1) {
      badWeatherChargeForToolTip =
          deliveryCharge * (zoneData.increaseDeliveryFee! / 100);
      deliveryCharge =
          deliveryCharge +
          (deliveryCharge * (zoneData.increaseDeliveryFee! / 100));
    }
    ('===>>> here calculation  $deliveryCharge').print;
    return deliveryCharge;
  }

  num _calculateDeliveryCharge({
    required Store? store,
    required AddressModel address,
    required num? distance,
    required num? extraCharge,
    required num orderAmount,
    required String orderType,
  }) {
    var deliveryCharge = _calculateOriginalDeliveryCharge(
      store: store,
      address: address,
      distance: distance,
      extraCharge: extraCharge,
    );

    final configModel = Get.find<GlobalController>().configModel;
    if (orderType == 'take_away' ||
        (store != null && store.freeDelivery!) ||
        /// below condition is to give free delivery for all
        ((configModel?.adminFreeDelivery?.status ?? false) &&
            (configModel?.adminFreeDelivery?.type != null &&
                configModel?.adminFreeDelivery?.type ==
                    'free_delivery_to_all_store')) ||
        /// below condition is to give free delivery for
        /// below order amount
        ((configModel?.adminFreeDelivery?.status ?? false) &&
            (configModel?.adminFreeDelivery?.type != null &&
                configModel?.adminFreeDelivery?.type ==
                    'free_delivery_by_order_amount') &&
            (configModel!.adminFreeDelivery?.freeDeliveryOver != null &&
                orderAmount >=
                    configModel.adminFreeDelivery!.freeDeliveryOver!)) ||
        /// below condition is to give free delivery for
        /// min km
        ((configModel?.adminFreeDelivery?.status ?? false) &&
            (configModel?.adminFreeDelivery?.type != null &&
                configModel?.adminFreeDelivery?.type ==
                    'free_delivery_by_min_km')
        // (configModel!.adminFreeDelivery?.freeDeliveryKm != null &&
        //     (configModel.adminFreeDelivery?.freeDeliveryKm ?? 0) >=
        //         (distance ?? 0))
        ) ||
        Get.find<CouponController>().freeDelivery ||
        (Get.find<CheckoutController>().guestAddress == null &&
            Get.find<CheckoutController>().orderType != 'take_away')) {
      deliveryCharge = 0;
    }

    return PriceConverter.toFixed(deliveryCharge);
  }

  void _setSinglePaymentActive() {
    if ((!_firstTimeCheckPayment &&
            !_isCashOnDeliveryActive! &&
            _isDigitalPaymentActive! &&
            Get.find<GlobalController>()
                    .configModel!
                    .activePaymentMethodList!
                    .length ==
                1) &&
        ((!_isWalletActive &&
                Get.find<AuthRepositoryInterface>().isLoggedIn()) ||
            !Get.find<AuthRepositoryInterface>().isLoggedIn())) {
      Future.delayed(const Duration(milliseconds: 600), () {
        Get.find<CheckoutController>().setPaymentMethod(2, isUpdate: false);
        Get.find<CheckoutController>().changeDigitalPaymentName(
          Get.find<GlobalController>()
              .configModel!
              .activePaymentMethodList![0]
              .getWay!,
          willUpdate: false,
        );
        _firstTimeCheckPayment = true;
      });
    }
  }

  num _calculateTotal({
    required num subTotal,
    required num deliveryCharge,
    required num discount,
    required num couponDiscount,
    required bool taxIncluded,
    required num tax,
    required String orderType,
    required num tips,
    required num additionalCharge,
    required num extraPackagingCharge,
  }) {
    '===>>>>> here totla subTotal $subTotal'.print;
    return PriceConverter.toFixed(
      subTotal +
          deliveryCharge -
          discount -
          couponDiscount +
          (taxIncluded ? 0 : tax) +
          ((orderType != 'take_away' &&
                  Get.find<GlobalController>().configModel!.dmTipsStatus == 1)
              ? tips
              : 0) +
          additionalCharge +
          extraPackagingCharge,
    );
  }

  bool _checkZoneOfflinePaymentOnOff({
    required AddressModel? addressModel,
    required CheckoutController checkoutController,
  }) {
    ZoneData? zoneData;
    for (final data in addressModel?.zoneData ?? <ZoneData>[]) {
      if (data.id == checkoutController.store?.zoneId) {
        zoneData = data;
        break;
      }
    }
    return zoneData?.offlinePayment ?? false;
  }

  // bool _checkPrescriptionRequired() {
  //   if (widget.storeId == null &&
  //       Get.find<GlobalController>()
  //           .configModel!
  //           .moduleConfig!
  //           .module!
  //           .orderAttachment!) {
  //     for (final cart in checkoutController.cartList!) {
  //       if (cart!.item!.isPrescriptionRequired!) {
  //         return true;
  //       }
  //     }
  //   }
  //   return false;
  // }

  num _calculateExtraPackagingCharge(CheckoutController checkoutController) {
    if ((checkoutController.store?.extraPackagingStatus ?? true) &&
        (Get.find<CartController>().needExtraPackage)) {
      return checkoutController.store?.extraPackagingAmount ?? 0;
    }
    return 0;
  }

  num _calculateReferralDiscount(
    num subTotal,
    num discount,
    num couponDiscount,
  ) {
    num referralDiscount = 0;
    if (Get.find<GlobalController>().userInfoModel != null &&
        Get.find<GlobalController>().userInfoModel!.isValidForDiscount!) {
      if (Get.find<GlobalController>().userInfoModel!.discountAmountType! ==
          'percentage') {
        referralDiscount =
            (Get.find<GlobalController>().userInfoModel!.discountAmount! /
                100) *
            (subTotal - discount - couponDiscount);
      } else {
        referralDiscount =
            Get.find<GlobalController>().userInfoModel!.discountAmount!;
      }
    }
    return PriceConverter.toFixed(referralDiscount);
  }

  // bool _checkPrescriptionRequired() {
  //   if (Get.find<GlobalController>()
  //           .configModel
  //           ?.moduleConfig
  //           ?.module
  //           ?.orderAttachment ??
  //       false) {
  //     for (final cart in checkoutController.cartList) {
  //       if (cart!.item!.isPrescriptionRequired!) {
  //         return true;
  //       }
  //     }
  //   }
  //   return false;
  // }
}
