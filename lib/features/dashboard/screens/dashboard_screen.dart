import 'dart:async';
import 'dart:io';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/services.dart';
import 'package:scan_sa_user/features/cart/controllers/cart_controller.dart';
import 'package:scan_sa_user/features/dashboard/widgets/store_registration_success_bottom_sheet.dart';
import 'package:scan_sa_user/features/home/controllers/home_controller.dart';
import 'package:scan_sa_user/features/location/controllers/location_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/order/controllers/order_controller.dart';
import 'package:scan_sa_user/features/order/domain/models/order_model.dart';
import 'package:scan_sa_user/features/auth/controllers/auth_controller.dart';
import 'package:scan_sa_user/features/dashboard/widgets/bottom_nav_item_widget.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/common/widgets/custom_dialog.dart';
import 'package:scan_sa_user/features/checkout/widgets/congratulation_dialogue.dart';
import 'package:scan_sa_user/features/dashboard/widgets/address_bottom_sheet_widget.dart';
import 'package:scan_sa_user/features/favourite/screens/favourite_screen.dart';
import 'package:scan_sa_user/features/home/screens/home_screen.dart';
import 'package:scan_sa_user/features/menu/screens/menu_screen.dart';
import 'package:scan_sa_user/features/order/screens/order_screen.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/util/styles.dart';

import '../widgets/running_order_view_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.pageIndex,
    this.fromSplash = false,
    this.fromBookTable = false,
  });
  final int pageIndex;
  final bool fromSplash;
  final bool fromBookTable;

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();

  late bool _isLogin;
  bool active = false;

  @override
  void initState() {
    super.initState();

    _isLogin = AuthHelper.isLoggedIn();

    _showRegistrationSuccessBottomSheet();

    if (_isLogin) {
      if (Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 &&
          Get.find<AuthController>().getEarningPint().isNotEmpty &&
          !ResponsiveHelper.isDesktop(Get.context)) {
        Future.delayed(
          const Duration(seconds: 1),
          () => showAnimatedDialog(
            Get.context!,
            const CongratulationDialogue(),
          ),
        );
      }
      suggestAddressBottomSheet();
      Get.find<OrderController>().getRunningOrders(1, fromDashboard: true);
    }

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);
    _screens = [
      HomeScreen(
        fromBookTable: widget.fromBookTable,
      ),
      const FavouriteScreen(),
      const SizedBox(),
      const OrderScreen(),
      const MenuScreen(),
    ];
  }

  _showRegistrationSuccessBottomSheet() {
    bool canShowBottomSheet =
        Get.find<HomeController>().getRegistrationSuccessfulSharedPref();
    if (canShowBottomSheet) {
      Future.delayed(const Duration(seconds: 1), () {
        ResponsiveHelper.isDesktop(Get.context)
            ? Get.dialog(
                const Dialog(child: StoreRegistrationSuccessBottomSheet()),
              ).then((value) {
                Get.find<HomeController>()
                    .saveRegistrationSuccessfulSharedPref(false);
                Get.find<HomeController>()
                    .saveIsStoreRegistrationSharedPref(false);
                setState(() {});
              })
            : showModalBottomSheet(
                context: Get.context!,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (con) => const StoreRegistrationSuccessBottomSheet(),
              ).then((value) {
                Get.find<HomeController>()
                    .saveRegistrationSuccessfulSharedPref(false);
                Get.find<HomeController>()
                    .saveIsStoreRegistrationSharedPref(false);
                setState(() {});
              });
      });
    }
  }

  Future<void> suggestAddressBottomSheet() async {
    active = await Get.find<LocationController>().checkLocationActive();
    if (widget.fromSplash &&
        Get.find<LocationController>().showLocationSuggestion &&
        active) {
      Future.delayed(const Duration(seconds: 1), () {
        showModalBottomSheet(
          context: Get.context!,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (con) => const AddressBottomSheetWidget(),
        ).then((value) {
          Get.find<LocationController>().showSuggestedLocation(false);
          setState(() {});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (_pageIndex != 0) {
              _setPage(0);
            } else {
              if (!ResponsiveHelper.isDesktop(context) &&
                  Get.find<SplashController>().module != null &&
                  Get.find<SplashController>().configModel!.module == null) {
                Get.find<SplashController>().setModule(null);
                Get.find<StoreController>().resetStoreData();
              } else {
                if (_canExit) {
                  if (GetPlatform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (GetPlatform.isIOS) {
                    exit(0);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'back_press_again_to_exit'.tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    ),
                  );
                  _canExit = true;
                  Timer(const Duration(seconds: 2), () {
                    _canExit = false;
                  });
                }
              }
            }
          },
          child: GetBuilder<OrderController>(
            builder: (orderController) {
              List<OrderModel> runningOrder =
                  orderController.runningOrderModel != null
                      ? orderController.runningOrderModel!.orders!
                      : [];

              List<OrderModel> reversOrder = List.from(runningOrder.reversed);

              return SafeArea(
                top: false,
                bottom: GetPlatform.isAndroid,
                child: Scaffold(
                  key: _scaffoldKey,
                  body: ExpandableBottomSheet(
                    background: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: _screens.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _screens[index];
                          },
                        ),
                        ResponsiveHelper.isDesktop(context) || keyboardVisible
                            ? const SizedBox()
                            : Align(
                                alignment: Alignment.bottomCenter,
                                child: GetBuilder<SplashController>(
                                  builder: (splashController) {
                                    _screens = [
                                      HomeScreen(
                                        fromBookTable: widget.fromBookTable,
                                      ),
                                      const FavouriteScreen(),
                                      const SizedBox(),
                                      const OrderScreen(index: 0),
                                      const MenuScreen(),
                                    ];
                                    return Container(
                                      width: size.width,
                                      height: GetPlatform.isIOS ? 80 : 70,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(
                                            Dimensions.radiusLarge,
                                          ),
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          ResponsiveHelper.isDesktop(context)
                                              ? const SizedBox()
                                              : (widget.fromSplash &&
                                                      Get.find<
                                                              LocationController>()
                                                          .showLocationSuggestion &&
                                                      active)
                                                  ? const SizedBox()
                                                  : (orderController
                                                              .showBottomSheet &&
                                                          orderController
                                                                  .runningOrderModel !=
                                                              null &&
                                                          orderController
                                                              .runningOrderModel!
                                                              .orders!
                                                              .isNotEmpty &&
                                                          _isLogin)
                                                      ? const SizedBox()
                                                      : Center(
                                                          child: SizedBox(
                                                            width: size.width,
                                                            height: 80,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                BottomNavItemWidget(
                                                                  title:
                                                                      'home'.tr,
                                                                  selectedIcon:
                                                                      Images
                                                                          .homeDarkIc,
                                                                  unSelectedIcon:
                                                                      Images
                                                                          .homeIc,
                                                                  isSelected:
                                                                      _pageIndex ==
                                                                          0,
                                                                  onTap: () =>
                                                                      _setPage(
                                                                    0,
                                                                  ),
                                                                ),
                                                                BottomNavItemWidget(
                                                                  title:
                                                                      'favourite'
                                                                          .tr,
                                                                  selectedIcon:
                                                                      Images
                                                                          .favoriteDarkIc,
                                                                  unSelectedIcon:
                                                                      Images
                                                                          .favoriteIc,
                                                                  isSelected:
                                                                      _pageIndex ==
                                                                          1,
                                                                  onTap: () =>
                                                                      _setPage(
                                                                    1,
                                                                  ),
                                                                ),
                                                                BottomNavItemWidget(
                                                                  title:
                                                                      'cart'.tr,
                                                                  selectedIcon:
                                                                      Images
                                                                          .cartDarkIc,
                                                                  unSelectedIcon:
                                                                      Images
                                                                          .cartIc,
                                                                  isSelected:
                                                                      _pageIndex ==
                                                                          2,
                                                                  widget: GetBuilder<
                                                                      CartController>(
                                                                    builder:
                                                                        (cartController) {
                                                                      return cartController
                                                                              .cartList
                                                                              .isNotEmpty
                                                                          ? Container(
                                                                              width: 13,
                                                                              height: 13,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                border: Border.all(
                                                                                  width: 1,
                                                                                  color: context.color.redColor,
                                                                                ),
                                                                                color: context.color.redColor,
                                                                              ),
                                                                              child: Text(
                                                                                cartController.cartList.length.toString(),
                                                                                style: robotoRegular.copyWith(
                                                                                  fontSize: 8,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : const SizedBox();
                                                                    },
                                                                  ),
                                                                  onTap: () {
                                                                    Get.toNamed(
                                                                      RouteHelper
                                                                          .getCartRoute(),
                                                                    );
                                                                  },
                                                                ),
                                                                BottomNavItemWidget(
                                                                  title:
                                                                      'orders'
                                                                          .tr,
                                                                  selectedIcon:
                                                                      Images
                                                                          .orderDarkIc,
                                                                  unSelectedIcon:
                                                                      Images
                                                                          .orderIc,
                                                                  isSelected:
                                                                      _pageIndex ==
                                                                          3,
                                                                  onTap: () =>
                                                                      _setPage(
                                                                    3,
                                                                  ),
                                                                ),
                                                                BottomNavItemWidget(
                                                                  title:
                                                                      'menu'.tr,
                                                                  selectedIcon:
                                                                      Images
                                                                          .menuDarkIc,
                                                                  unSelectedIcon:
                                                                      Images
                                                                          .menuIc,
                                                                  isSelected:
                                                                      _pageIndex ==
                                                                          4,
                                                                  onTap: () =>
                                                                      _setPage(
                                                                    4,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                    persistentContentHeight: (widget.fromSplash &&
                            Get.find<LocationController>()
                                .showLocationSuggestion &&
                            active)
                        ? 0
                        : GetPlatform.isIOS
                            ? 110
                            : 100,
                    onIsContractedCallback: () {
                      if (!orderController.showOneOrder) {
                        orderController.showOrders();
                      }
                    },
                    onIsExtendedCallback: () {
                      if (orderController.showOneOrder) {
                        orderController.showOrders();
                      }
                    },
                    enableToggle: true,
                    expandableContent: (widget.fromSplash &&
                            Get.find<LocationController>()
                                .showLocationSuggestion &&
                            active &&
                            !ResponsiveHelper.isDesktop(context))
                        ? const SizedBox()
                        : (ResponsiveHelper.isDesktop(context) ||
                                !_isLogin ||
                                orderController.runningOrderModel == null ||
                                orderController
                                    .runningOrderModel!.orders!.isEmpty ||
                                !orderController.showBottomSheet)
                            ? const SizedBox()
                            : Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {
                                  if (orderController.showBottomSheet) {
                                    orderController.showRunningOrders();
                                  }
                                },
                                child: RunningOrderViewWidget(
                                  reversOrder: reversOrder,
                                  onOrderTap: () {
                                    _setPage(3);
                                    if (orderController.showBottomSheet) {
                                      orderController.showRunningOrders();
                                    }
                                  },
                                ),
                              ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  Widget trackView(BuildContext context, {required bool status}) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        color: status
            ? context.color.secondary
            : Theme.of(context).disabledColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
    );
  }
}
