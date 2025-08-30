import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:scan_sa_user/features/auth/controllers/auth_controller.dart';
import 'package:scan_sa_user/features/cart/controllers/cart_controller.dart';
import 'package:scan_sa_user/features/language/controllers/language_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/common/controllers/theme_controller.dart';
import 'package:scan_sa_user/features/notification/domain/models/notification_body_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/notification_helper.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/theme/dark_theme.dart';
import 'package:scan_sa_user/theme/light_theme.dart';
import 'package:scan_sa_user/util/app_constants.dart';
import 'package:scan_sa_user/util/extension/string_ext.dart';
import 'package:scan_sa_user/util/messages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/home/widgets/cookies_view.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  ("object 0").print;
  WidgetsFlutterBinding.ensureInitialized();

  ("object 1").print;

  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }
  ("object 2").print;
  setPathUrlStrategy();
  ("object 3").print;

  /*///Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };


  ///Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };*/

  if (GetPlatform.isWeb) {
    ("object 4").print;
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDxqQyRjpUFeoNUzSa4Blm2KdIBOYJ4YYw",
        authDomain: "scan-sa.firebaseapp.com",
        projectId: "scan-sa",
        storageBucket: "scan-sa.firebasestorage.app",
        messagingSenderId: "221589331538",
        appId: "1:221589331538:web:303dff190786e794fa498b",
        measurementId: "G-LYQ9DXQ61E",
      ),
    );
    ("object 5").print;
  } else if (GetPlatform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCJ5fHpupJKww00L4_rVtXu0F7_CyAcnjQ',
        appId: '1:221589331538:android:c5d6b2f89344124bfa498b',
        messagingSenderId: '221589331538',
        projectId: 'scan-sa',
        storageBucket: 'scan-sa.firebasestorage.app',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  ("object 6").print;
  Map<String, Map<String, String>> languages = await di.init();
  ("object 7").print;

  NotificationBodyModel? body;
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        body = NotificationHelper.convertNotification(remoteMessage.data);
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (_) {}

  ("object 8").print;
  // if (ResponsiveHelper.isWeb()) {
  //   await FacebookAuth.instance.webAndDesktopInitialize(
  //     appId: "380903914182154",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v15.0",
  //   );
  // }

  runApp(MyApp(languages: languages, body: body));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.languages, required this.body});
  final Map<String, Map<String, String>>? languages;
  final NotificationBodyModel? body;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    _route();
  }

  Future<void> _route() async {
    if (GetPlatform.isWeb) {
      Get.find<SplashController>().initSharedData();
      if (AddressHelper.getUserAddressFromSharedPref() != null &&
          AddressHelper.getUserAddressFromSharedPref()!.zoneIds == null) {
        Get.find<AuthController>().clearSharedAddress();
      }

      if (!AuthHelper.isLoggedIn() &&
          !AuthHelper
              .isGuestLoggedIn() /*&& !ResponsiveHelper.isDesktop(Get.context!)*/) {
        await Get.find<AuthController>().guestLogin();
      }

      if ((AuthHelper.isLoggedIn() || AuthHelper.isGuestLoggedIn()) &&
          Get.find<SplashController>().cacheModule != null) {
        Get.find<CartController>().getCartDataOnline();
      }

      Get.find<SplashController>().getConfigData(
        loadLandingData: GetPlatform.isWeb &&
            AddressHelper.getUserAddressFromSharedPref() == null,
        fromMainFunction: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return GetBuilder<SplashController>(
              builder: (splashController) {
                return (GetPlatform.isWeb &&
                        splashController.configModel == null)
                    ? const SizedBox()
                    : GetMaterialApp(
                        title: AppConstants.appName,
                        debugShowCheckedModeBanner: false,
                        navigatorKey: Get.key,
                        scrollBehavior: const MaterialScrollBehavior().copyWith(
                          dragDevices: {
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.touch,
                          },
                        ),
                        theme: themeController.darkTheme ? dark() : light(),
                        locale: localizeController.locale,
                        translations: Messages(languages: widget.languages),
                        fallbackLocale: Locale(
                          AppConstants.languages[0].languageCode!,
                          AppConstants.languages[0].countryCode,
                        ),
                        initialRoute: GetPlatform.isWeb
                            ? RouteHelper.getInitialRoute()
                            : RouteHelper.getSplashRoute(widget.body),
                        getPages: RouteHelper.routes,
                        defaultTransition: Transition.topLevel,
                        transitionDuration: const Duration(milliseconds: 500),
                        builder: (BuildContext context, widget) {
                          return MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaler: const TextScaler.linear(1),
                            ),
                            child: Material(
                              child: Stack(
                                children: [
                                  widget!,
                                  GetBuilder<SplashController>(
                                    builder: (splashController) {
                                      if (!splashController.savedCookiesData &&
                                          !splashController
                                              .getAcceptCookiesStatus(
                                            splashController.configModel != null
                                                ? splashController
                                                    .configModel!.cookiesText!
                                                : '',
                                          )) {
                                        return ResponsiveHelper.isWeb()
                                            ? const Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: CookiesView(),
                                              )
                                            : const SizedBox();
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
