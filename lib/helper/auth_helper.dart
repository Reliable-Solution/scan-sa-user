import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';

class GlobalHelper {
  static bool isGuestLoggedIn() {
    return Get.find<GlobalController>().isGuestLoggedIn();
  }

  static String getGuestId() {
    return Get.find<GlobalController>().getGuestId();
  }

  static bool isLoggedIn() {
    return Get.find<GlobalController>().isLoggedIn();
  }
}
