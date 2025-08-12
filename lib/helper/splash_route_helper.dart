import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/common/models/notification_body_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

// class SplashRouteHelper{

void route({NotificationBodyModel? body}) {
  // final minimumVersion = _getMinimumVersion();
  // final isMaintenanceMode =
  //     Get.find<GlobalController>().configModel?.maintenanceMode;
  // final needsUpdate = AppConstants.appVersion < (minimumVersion ?? 0);

  // if (needsUpdate || (isMaintenanceMode ?? false)) {
  //   // Get.offNamed(RouteHelper.getUpdateRoute(needsUpdate));
  // } else
  if (body != null) {
    _forNotificationRouteProcess(body);
  } else {
    _handleUserRouting();
  }
}

// num? _getMinimumVersion() {
//   if (GetPlatform.isAndroid) {
//     return Get.find<GlobalController>().configModel?.appMinimumVersionAndroid;
//   } else if (GetPlatform.isIOS) {
//     return Get.find<GlobalController>().configModel?.appMinimumVersionIos;
//   }
//   return 0;
// }

void _forNotificationRouteProcess(NotificationBodyModel? notificationBody) {
  // final notificationType = notificationBody?.notificationType;

  // final notificationActions = <NotificationType, Function>{
  //   NotificationType.order: () => Get.toNamed(
  //     RouteHelper.getOrderDetailsRoute(
  //       notificationBody!.orderId,
  //       fromNotification: true,
  //     ),
  //   ),
  //   NotificationType.block: () =>
  //       Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.notification)),
  //   NotificationType.unblock: () =>
  //       Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.notification)),
  //   NotificationType.message: () => Get.toNamed(
  //     RouteHelper.getChatRoute(
  //       notificationBody: notificationBody,
  //       conversationID: notificationBody!.conversationId,
  //       fromNotification: true,
  //     ),
  //   ),
  //   NotificationType.otp: () => null,
  //   NotificationType.add_fund: () =>
  //       Get.toNamed(RouteHelper.getWalletRoute(fromNotification: true)),
  //   NotificationType.referral_earn: () =>
  //       Get.toNamed(RouteHelper.getWalletRoute(fromNotification: true)),
  //   NotificationType.cashback: () =>
  //       Get.toNamed(RouteHelper.getWalletRoute(fromNotification: true)),
  //   NotificationType.loyalty_point: () =>
  //       Get.toNamed(RouteHelper.getLoyaltyRoute(fromNotification: true)),
  //   NotificationType.general: () =>
  //       Get.toNamed(RouteHelper.getNotificationRoute(fromNotification: true)),
  // };

  // notificationActions[notificationType]?.call();
}

Future<void> _forLoggedInUserRouteProcess() async {
  await Get.find<GlobalController>().updateToken();
  if (AddressHelper.getUserAddressFromSharedPref() != null) {
    AppPages.bottomBarScreen.push();
  } else {
    AppPages.locationScreen.push(arguments: {AppStrings.fromSplash: true});
  }
}

void _newlyRegisteredRouteProcess() => AppPages.login.offAll();

void _forGuestUserRouteProcess() {
  AppPages.login.offAll();
  if (AddressHelper.getUserAddressFromSharedPref() != null) {
    // Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
  } else {
    // Get.find<LocationController>().navigateToLocationScreen(
    //   'splash',
    //   offNamed: true,
    // );
  }
}

Future<void> _handleUserRouting() async {
  if (GlobalHelper.isLoggedIn()) {
    'object1'.print;
    await _forLoggedInUserRouteProcess();
  } else if ((Get.find<GlobalController>().showIntro()) ?? false) {
    'object2'.print;
    _newlyRegisteredRouteProcess();
  } else if (GlobalHelper.isGuestLoggedIn()) {
    'object3'.print;
    _forGuestUserRouteProcess();
  } else {
    'object4'.print;
    await Get.find<GlobalController>().guestLogin();
    _forGuestUserRouteProcess();
  }
}

// }
