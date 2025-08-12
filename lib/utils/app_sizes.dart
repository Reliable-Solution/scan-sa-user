import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';

class AppSizes {
  AppSizes._();

  static double appPadding = 24.w;
  static const double topPad = 10;
}

class AppPadding {
  static EdgeInsets bottomPad(BuildContext context) => EdgeInsets.only(
    bottom: (MediaQuery.paddingOf(context).bottom / 1.5) + 10,
    top: 10,
    right: AppSizes.appPadding,
    left: AppSizes.appPadding,
  );
  static EdgeInsets commonSubPad = EdgeInsets.symmetric(
    horizontal: AppSizes.appPadding,
    vertical: 20,
  );

  static EdgeInsets rightPad(double pad) => EdgeInsets.only(
    right: Get.find<GlobalController>().isLTR.value ? pad : 0,
    left: Get.find<GlobalController>().isLTR.value ? 0 : pad,
  );
  static EdgeInsets leftPad(double pad) => EdgeInsets.only(
    left: Get.find<GlobalController>().isLTR.value ? pad : 0,
    right: Get.find<GlobalController>().isLTR.value ? 0 : pad,
  );
}
