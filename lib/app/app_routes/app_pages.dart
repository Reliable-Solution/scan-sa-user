class AppRoutes {
  static const String initial = '/';

  /// authentication routes
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String otp = '/otp';
  static const String forgotPass = '/forgotPass';
  static const String resetPass = '/resetPass';
  static const String newUser = '/new-user-setup-screen';
  static const String locationScreen = '/locationScreen';
  static const String categoryScreen = '/categoryScreen';
  static const String bottomBarScreen = '/bottomBarScreen';
  static const String homeScreen = '/homeScreen';
  static const String restaurantScreen = '/restaurantScreen';
  static const String cartScreen = '/cartScreen';
  static const String checkOutScreen = '/checkOutScreen';
  static const String slotSelectionScreen = '/slotSelectionScreen';
  static const String promoCodeScreen = '/promoCodeScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String changePassScreen = '/changePassScreen';
  static const String editAddressScreen = '/editAddressScreen';
  static const String reservationScreen = '/reservationScreen';
  static const String confirmationScreen = '/confirmationScreen';
  static const String successFailedScreen = '/successFailedScreen';
  static const String searchScreen = '/searchScreen';
  static const String qrScannerScreen = '/qrScannerScreen';
  static const String helpNSupport = '/HelpNSupport';
  static const String htmlViewerScreen = '/htmlViewerScreen';
  static const String categoryDetailScreen = '/categoryDetailScreen';
  static const String couponScreen = '/couponScreen';
  static const String loyalPoint = '/loyalPoint';
  static const String walletScreen = '/walletScreen';
  static const String joinAsDeliveryScreen = '/joinAsDeliveryScreen';
  static const String joinAsVendorScreen = '/joinAsVendorScreen';
  static const String subscriptionPayment = '/subscription-payment';
  static const String subscriptionSuccess = '/subscription-success';
  static const String paymentWebView = '/paymentWebView';
}

class AppPages {
  /// authentication routes
  static const String login = AppRoutes.login;
  static const String locationScreen = AppRoutes.locationScreen;
  static const String newUser = '$login${AppRoutes.newUser}';
  static const String signUp = '$login${AppRoutes.signUp}';
  static const String signUpOtp = '$signUp${AppRoutes.otp}';
  static const String forgotPass = '$login${AppRoutes.forgotPass}';
  static const String forgotOtp = '$forgotPass${AppRoutes.otp}';
  static const String resetPass = '$forgotOtp${AppRoutes.resetPass}';

  /// bottom screens pages
  static const String categoryScreen = AppRoutes.categoryScreen;
  static const String bottomBarScreen = AppRoutes.bottomBarScreen;
  static const String homeScreen = '$bottomBarScreen${AppRoutes.homeScreen}';
  static const String locationHomeScreen =
      '$bottomBarScreen${AppRoutes.locationScreen}';
  static const String bottomCategoryScreen =
      '$bottomBarScreen${AppRoutes.categoryScreen}';
  static const String qrScannerScreen =
      '$bottomBarScreen${AppRoutes.qrScannerScreen}';
  static const String restaurantScreen =
      '$homeScreen${AppRoutes.restaurantScreen}';
  static const String reservationScreen =
      '$homeScreen${AppRoutes.reservationScreen}';
  static const String confirmationScreen =
      '$reservationScreen${AppRoutes.confirmationScreen}';
  static const String successFailedScreen =
      '$confirmationScreen${AppRoutes.successFailedScreen}';
  static const String searchScreen = '$homeScreen${AppRoutes.searchScreen}';
  static const String helpNSupport =
      '$bottomBarScreen${AppRoutes.helpNSupport}';
  static const String htmlViewerScreen =
      '$bottomBarScreen${AppRoutes.htmlViewerScreen}';
  static const String categoryDetailScreen =
      '$bottomBarScreen${AppRoutes.categoryDetailScreen}';

  /// cart screens that come from bottom screen
  static const String checkOutHomeScreen =
      '$bottomBarScreen${AppRoutes.checkOutScreen}';
  static const String slotSelectionScreen =
      '$checkOutHomeScreen${AppRoutes.slotSelectionScreen}';
  static const String promoCodeScreen =
      '$checkOutHomeScreen${AppRoutes.promoCodeScreen}';

  /// cart screens that come from cart screen
  static const String restaurantCartScreen =
      '$restaurantScreen${AppRoutes.cartScreen}';
  static const String checkOutCartScreen =
      '$restaurantCartScreen${AppRoutes.checkOutScreen}';
  static const String slotSelectionCartScreen =
      '$checkOutCartScreen${AppRoutes.slotSelectionScreen}';
  static const String promoCodeCartScreen =
      '$checkOutCartScreen${AppRoutes.promoCodeScreen}';

  /// setting screens
  static const String editProfileScreen =
      '$bottomBarScreen${AppRoutes.editProfileScreen}';
  static const String changePassScreen =
      '$editProfileScreen${AppRoutes.changePassScreen}';
  static const String editAddressScreen =
      '$bottomBarScreen${AppRoutes.editAddressScreen}';
  static const String couponScreen =
      '$bottomBarScreen${AppRoutes.couponScreen}';
  static const String loyalPoint = '$bottomBarScreen${AppRoutes.loyalPoint}';
  static const String walletScreen =
      '$bottomBarScreen${AppRoutes.walletScreen}';
  static const String joinAsDeliveryScreen =
      '$bottomBarScreen${AppRoutes.joinAsDeliveryScreen}';
  static const String joinAsVendorScreen =
      '$bottomBarScreen${AppRoutes.joinAsVendorScreen}';
  static const String subscriptionPayment =
      '$joinAsVendorScreen${AppRoutes.subscriptionPayment}';
  static const String subscriptionSuccess =
      '$joinAsVendorScreen${AppRoutes.subscriptionSuccess}';
  static const String paymentWebView =
      '$bottomBarScreen${AppRoutes.paymentWebView}';
}
