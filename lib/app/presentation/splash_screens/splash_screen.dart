import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/no_internet_screen.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/utils/app_hero_tags.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<List<ConnectivityResult>>? _onConnectivityChanged;
  bool isLight = true;
  Future<void> getTheme() async {
    final pref = Get.find<SharedPreferences>();
    isLight = pref.getBool('theme') ?? true;
  }

  @override
  void initState() {
    super.initState();
    getTheme();

    var firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) async {
      final isConnected =
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile);

      if (!firstTime) {
        isConnected
            ? ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar()
            : const SizedBox();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            backgroundColor: isConnected ? Colors.green : Colors.red,
            duration: Duration(seconds: isConnected ? 3 : 6000),
            content: Text(
              isConnected
                  ? Get.context!.l10n.connected
                  : Get.context!.l10n.notConnected,
              textAlign: TextAlign.center,
            ),
          ),
        );
        if (isConnected) {
          await Get.find<GlobalController>().getConfigData();
        }
      }

      firstTime = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<GlobalController>().getConfigData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (AddressHelper.getUserAddressFromSharedPref() != null &&
        AddressHelper.getUserAddressFromSharedPref()!.zoneIds == null) {
      Get.find<GlobalController>().clearSharedAddress();
    }

    return Scaffold(
      key: _globalKey,
      backgroundColor: isLight ? Colors.white : Colors.black,
      body: GetBuilder<GlobalController>(
        builder: (globalController) {
          return Center(
            child: globalController.hasConnection
                ? Hero(
                    tag: AppHeroTags.splashLogo,
                    child: SvgAssets(AppIcons.logoIc, width: 150, height: 150)
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(
                          duration: const Duration(seconds: 2),
                          delay: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                  )
                : const NoInternetScreen(),
          );
        },
      ),
    );
  }
}
