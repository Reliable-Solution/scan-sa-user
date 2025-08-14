import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/controllers/favorite_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/login_sheet.dart';

class BottomBarController extends GetxController {
  BottomBarController(this.context) {
    Get.find<GlobalController>().getUserInfo(isNavigate: false);
    Get.find<FavoriteController>().getFavoriteList();
    Get.find<CartController>().getCartDataOnline();
  }

  BuildContext context;

  /// below variables and function is used to select bottom bar screen
  /// and change values
  final RxInt _selectedScreen = 0.obs;
  RxInt get selectedScreen => _selectedScreen;
  void changeScreen(int screen) {
    if (Get.find<GlobalController>().isGuestMode &&
        (screen == 1 || screen == 3)) {
      showLoginSheet();
      return;
    }
    _selectedScreen.value = screen;
    update();
  }

  // /// below variables and function is used to select bottom bar screen
  // /// and change values
  // final RxInt _selectedCatIndex = 0.obs;
  // RxInt get selectedCatIndex => _selectedCatIndex;
  // void changeCategory(int category) {
  //   _selectedCatIndex.value = category;
  //   update();
  //   Get.back();
  // }
}
