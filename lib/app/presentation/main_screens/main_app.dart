import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_routings.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_service/auth_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/services/global_service_interface.dart';
import 'package:scan_sa_user/app/theme/app_theme.dart' show AppTheme;
import 'package:scan_sa_user/app/theme/system_overlay_style.dart';
import 'package:scan_sa_user/l10n/locale.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_strings.dart' show AppStrings;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(
    GlobalController(
      Get.find<AuthServiceInterface>(),
      Get.find<GlobalServiceInterface>(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 957),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return Obx(() {
          SystemOverlayStyle(
            isDarkMode: controller.themeMode.value != ThemeMode.dark,
          ).apply();

          return GetMaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: controller.themeMode.value,
            locale: LocalizationService.defaultLocale,
            translations: LocalizationService(),
            supportedLocales: LocalizationService().getSupportedLocales(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            getPages: AppRoutings.routes,
            builder: (context, child) {
              return Stack(children: [child!, const _Loader()]);
            },
          );
        });
      },
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GlobalController>();
    return Obx(
      () => controller.isLoader.value
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(AppIcons.loading)
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(
                      duration: const Duration(seconds: 2),
                      delay: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class EasyLoading {
  EasyLoading._();

  static void load() {
    Get.find<GlobalController>().isLoader.value = true;
  }

  static void dismiss() {
    Get.find<GlobalController>().isLoader.value = false;
  }
}
