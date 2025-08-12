import 'dart:developer';

import 'package:get/get.dart';
import 'package:scan_sa_user/utils/app_strings.dart';

extension StringExt on String {
  /// to push to screen
  void push<T>({T? arguments}) {
    Get.toNamed(this, arguments: arguments);
  }

  /// to off all from screen to screen
  // Future<dynamic>? get offAll => Get.offAllNamed(this);
  void offAll<T>({T? arguments}) {
    Get.offAllNamed(this, arguments: arguments);
  }
}

extension Print on dynamic {
  dynamic get print {
    log('$this', name: AppStrings.appName);
    return this;
  }
}
