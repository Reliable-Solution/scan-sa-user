import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/cart_widget.dart';
import 'package:scan_sa_user/common/widgets/veg_filter_widget.dart';
import 'package:scan_sa_user/common/widgets/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.backButton = true,
    this.onBackPressed,
    this.showCart = false,
    this.leadingIcon,
    this.onVegFilterTap,
    this.type,
  });
  final String title;
  final bool backButton;
  final Function? onBackPressed;
  final bool showCart;
  final Function(String value)? onVegFilterTap;
  final String? type;
  final String? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)
        ? const WebMenuBar()
        : AppBar(
            surfaceTintColor: Colors.transparent,
            leadingWidth: backButton ? AppSizes.appPadding + 40 : 0,
            leading: backButton
                ? Padding(
                    padding: EdgeInsets.only(left: AppSizes.appPadding),
                    child: const BackBtn(),
                  )
                : const SizedBox.shrink(),
            title: Text(
              title,
              style: robotoMedium.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            centerTitle: true,
            elevation: 2,
            actions: showCart || onVegFilterTap != null
                ? [
                    showCart
                        ? IconButton(
                            onPressed: () =>
                                Get.toNamed(RouteHelper.getCartRoute()),
                            icon: CartWidget(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              size: 25,
                            ),
                          )
                        : const SizedBox(),
                    onVegFilterTap != null
                        ? VegFilterWidget(
                            type: type,
                            onSelected: onVegFilterTap,
                            fromAppBar: true,
                          )
                        : const SizedBox(),
                  ]
                : [const SizedBox()],
          );
    // AppBar(
    //     title: Text(
    //       title,
    //       style: robotoMedium.copyWith(
    //         fontSize: Dimensions.fontSizeLarge,
    //         fontWeight: FontWeight.w600,
    //         color: Theme.of(context).textTheme.bodyLarge!.color,
    //       ),
    //     ),
    //     centerTitle: true,
    //     leading: backButton
    //         ? IconButton(
    //             icon: leadingIcon != null
    //                 ? Image.asset(leadingIcon!, height: 22, width: 22)
    //                 : const Icon(Icons.arrow_back_ios),
    //             color: Theme.of(context).textTheme.bodyLarge!.color,
    //             onPressed: () => onBackPressed != null
    //                 ? onBackPressed!()
    //                 : Navigator.pop(context),
    //           )
    //         : const SizedBox(),
    //     backgroundColor: Theme.of(context).cardColor,
    //     surfaceTintColor: Theme.of(context).cardColor,
    //     shadowColor: Theme.of(context).disabledColor.withValues(alpha: 0.5),
    //     elevation: 2,
    //     actions: showCart || onVegFilterTap != null
    //         ? [
    //             showCart
    //                 ? IconButton(
    //                     onPressed: () =>
    //                         Get.toNamed(RouteHelper.getCartRoute()),
    //                     icon: CartWidget(
    //                       color:
    //                           Theme.of(context).textTheme.bodyLarge!.color,
    //                       size: 25,
    //                     ),
    //                   )
    //                 : const SizedBox(),
    //             onVegFilterTap != null
    //                 ? VegFilterWidget(
    //                     type: type,
    //                     onSelected: onVegFilterTap,
    //                     fromAppBar: true,
    //                   )
    //                 : const SizedBox(),
    //           ]
    //         : [const SizedBox()],
    //   );
  }

  @override
  Size get preferredSize => Size(Get.width, GetPlatform.isDesktop ? 100 : 50);
}
