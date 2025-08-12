import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/controller/bottom_bar_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/controllers/checkout_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/widget/delete_cart_sheet.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_rich_text.dart';
import 'package:scan_sa_user/app/widgets/cart_btn.dart';
import 'package:scan_sa_user/app/widgets/circular_btn.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/app/widgets/login_sheet.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, this.isFromBottom = false});
  final bool isFromBottom;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        Get.put(CheckoutController(checkoutServiceInterface: Get.find()));
        final isGuest = Get.find<GlobalController>().isGuestMode;
        if (cartController.cartList.isEmpty && !isFromBottom) Get.back();
        return CommonSubScreen(
          appBarTitle: context.l10n.cart,
          btnText: cartController.cartList.isEmpty
              ? null
              : context.l10n.goToCheckout,
          onTap: cartController.cartList.isEmpty
              ? null
              : isGuest
              ? showLoginSheet
              : () {
                  if (isFromBottom) {
                    AppPages.checkOutHomeScreen.push(
                      arguments: Get.arguments is bool ? Get.arguments : null,
                    );
                  } else {
                    AppPages.checkOutCartScreen.push(
                      arguments: Get.arguments is bool ? Get.arguments : null,
                    );
                  }
                },
          isBack: !isFromBottom,
          child: cartController.cartList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgAssets(AppIcons.emptyCart),
                    Text(
                      context.l10n.mealStart,
                      textAlign: TextAlign.center,
                      style: context.style.s24w700,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 20),
                      child: Text(
                        context.l10n.emptyCartMessage,
                        textAlign: TextAlign.center,
                        style: context.style.s16w700.copyWith(
                          color: context.color.ff6c6c6c,
                        ),
                      ),
                    ),
                    AppButton(
                      label: context.l10n.browseRestaurants,
                      onPressed: () =>
                          Get.find<BottomBarController>().changeScreen(0),
                      isBottomPad: true,
                    ),
                  ],
                )
              : ListView(
                  padding: AppPadding.commonSubPad,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.yourCart,
                              style: context.style.s28w900,
                            ),
                            AppRichText(
                              text1:
                                  '${cartController.cartList.length} ${context.l10n.productFrom} ',
                              text2:
                                  '${cartController.cartList.firstOrNull?.item?.storeName}',
                              textStyle1: context.style.s16w700.copyWith(
                                color: context.color.ff9c9c9c,
                              ),
                              textStyle2: context.style.s16w700.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                              onTap1: Get.back,
                            ),
                          ],
                        ),
                        CircularBtn(
                          icon: AppIcons.deleteIc,
                          radius: 22.5,
                          color: context.color.redColor.withValues(alpha: .15),
                          iconColor: context.color.redColor,
                          onTap: () =>
                              showDeleteSheet(isFromHome: isFromBottom),
                        ),
                      ],
                    ),
                    Text(
                      '${AppStrings.dinar} ${cartController.cartTotalPrice()}',
                      style: context.style.s18w700.copyWith(
                        color: context.color.primary,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      itemCount: cartController.cartList.length,
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Divider(height: 32, color: context.color.grey),
                      ),
                      itemBuilder: (context, index) {
                        final cartData = cartController.cartList[index];
                        return Row(
                          spacing: 10,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 17),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child:
                                        (cartData
                                                .item
                                                ?.imagesFullUrl
                                                ?.firstOrNull
                                                ?.isEmpty ??
                                            true)
                                        ? Image.asset(
                                            AppIcons.logo,
                                            height:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .28,
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .35,
                                          )
                                        : Image.network(
                                            cartData
                                                    .item
                                                    ?.imagesFullUrl
                                                    ?.firstOrNull ??
                                                '',
                                            height:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .28,
                                            width:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                .35,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                CartBtn(
                                  cartValue: cartData.quantity ?? 0,
                                  isAddBtn: cartData.quantity == 0,
                                  onTapAdd: () =>
                                      cartController.itemDirectlyAddToCart(
                                        cartData.item,
                                        context,
                                      ),
                                  onTap: (isRemove) =>
                                      (cartData.quantity == 1 && isRemove)
                                      ? cartController.removeFromCart(index)
                                      : cartController.setQuantity(
                                          !isRemove,
                                          index,
                                          10,
                                          10,
                                        ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 6,
                                children: [
                                  Text(
                                    cartData.item?.name ?? '',
                                    style: context.style.s18w700.copyWith(
                                      color: context.color.primary,
                                    ),
                                  ),
                                  Text(
                                    '${AppStrings.dinar} '
                                    '${cartController.calculatePriceWithVariation(item: cartData.item, selectedVariant: cartData.variation?.firstOrNull?.type) ?? ''}',
                                    style: context.style.s18w700.copyWith(
                                      color: context.color.primary,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SvgAssets(
                                        AppIcons.thumbIc,
                                        color: context.color.greenColor,
                                        width: 15,
                                      ),
                                      Text(
                                        '  ${cartData.item?.avgRating ?? '0'} ',
                                        style: context.style.s14w700.copyWith(
                                          color: context.color.greenColor,
                                        ),
                                      ),
                                      Text(
                                        '(${cartData.item?.ratingCount ?? '0'})',
                                        style: context.style.s14w700.copyWith(
                                          color: context.color.ff9c9c9c,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if ((cartData.variation?.isNotEmpty ??
                                          false) &&
                                      (cartController
                                              .setupVariationText(
                                                cart: cartData,
                                              )
                                              ?.isNotEmpty ??
                                          false))
                                    Text(
                                      cartController.setupVariationText(
                                            cart: cartData,
                                          ) ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: context.style.s14w700.copyWith(
                                        color: context.color.ff9c9c9c,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: GestureDetector(
                    //     // onTap: () => AppPages.restaurantScreen.push(
                    //     //   arguments: {'store': cartController.cartList.firstOrNull?.item?.store?.toJson()},
                    //     // ),
                    //     child: DecoratedBox(
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(40),
                    //         color: context.color.greenColor.withValues(
                    //           alpha: .15,
                    //         ),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //           horizontal: 24,
                    //           vertical: 12,
                    //         ),
                    //         child: Text(
                    //           context.l10n.addMoreItems,
                    //           style: context.style.s16w700.copyWith(
                    //             color: context.color.greenColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
        );
      },
    );
  }
}
