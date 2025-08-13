import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/controller/bottom_bar_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/cart_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/category_module/category_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/screens/favourite_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/profile_screen.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  BottomBarController get controller => Get.put(BottomBarController(context));
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if ((Get.arguments as bool?) ?? true) {
        // AppPages.categoryScreen.push();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenList = <({String icon, String name, Widget screen})>[
      (
        icon: AppIcons.homeIc,
        name: Get.context!.l10n.home,
        screen: const CategoryScreen(),
      ),
      (
        icon: AppIcons.favoriteIc,
        name: 'Favorite',
        screen: const FavoriteScreen(),
      ),
      // (
      //   icon: AppIcons.pickupIc,
      //   name: Get.context!.l10n.pickup,
      //   screen: const HomeScreen(isPickupScreen: true),
      // ),
      // (
      //   icon: AppIcons.slotIc,
      //   name: Get.context!.l10n.slot,
      //   screen: const HomeScreen(isSlotScreen: true),
      // ),
      (
        icon: AppIcons.cartIc,
        name: Get.context!.l10n.cart,
        screen: const CartScreen(isFromBottom: true),
      ),
      (icon: AppIcons.orderIc, name: 'order'.tr, screen: Container()),
      (
        icon: AppIcons.profileIc,
        name: Get.context!.l10n.profile,
        screen: const ProfileScreen(),
      ),
    ];
    return Obx(() {
      final bottomIndex = controller.selectedScreen.value;
      return Scaffold(
        backgroundColor: bottomIndex == 4 ? context.color.secondary : null,
        bottomNavigationBar: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(color: context.color.whiteLight),
            padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: screenList.map((e) {
                final index = screenList.indexOf(e);
                final isSelected = bottomIndex == index;
                return GestureDetector(
                  onTap: () => controller.changeScreen(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // width: 80,
                    color: Colors.transparent,

                    child: Column(
                      spacing: 2,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 10,
                          ),
                          child: SvgAssets(
                            e.icon,
                            color: isSelected ? context.color.secondary : null,
                          ),
                        ),
                        Text(
                          e.name,
                          textAlign: TextAlign.center,
                          style: context.style.s14w700.copyWith(
                            color: bottomIndex == index
                                ? context.color.secondary
                                : context.color.darkTextGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        body: screenList[bottomIndex].screen,
      );
    });
  }
}
