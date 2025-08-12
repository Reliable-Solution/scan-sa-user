import 'package:get/get.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(
    Response<dynamic> response, {
    bool getXSnackBar = false,
  }) {
    if (response.statusCode == 401) {
      // Get.find<AuthController>().clearSharedData(removeToken: false).then((
      //   value,
      // ) {
      //   Get.find<FavouriteController>().removeFavourite();
      //   Get.offAllNamed(RouteHelper.getInitialRoute());
      // });
    } else {
      if (response.statusText != 'The guest id field is required.') {
        showCustomSnackBar(response.statusText, getXSnackBar: getXSnackBar);
      }
    }
  }
}
