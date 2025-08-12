import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/cart_btn.dart';
import 'package:scan_sa_user/app/widgets/item_card_widgets/item_detail_sheet.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/box_shimmer.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({
    super.key,
    required this.cartValue,
    required this.isAddBtn,
    required this.onCartTap,
    this.isLoad = false,
    this.item,
  });
  final int cartValue;
  final bool isAddBtn;
  final bool isLoad;
  final Item? item;
  final Function(bool isRemove) onCartTap;

  @override
  Widget build(BuildContext context) {
    // final cartController = Get.find<CartController>();
    // final itemController = Get.find<ItemController>();
    // int? stock = 0;
    // CartModel? cartModel;
    // OnlineCart? cart;
    // num priceWithAddons = 0;
    // final cartId = cartController.getCartId(itemController.cartIndex);
    // if (itemController.item != null && itemController.variationIndex != null) {
    //   final variationList = <String>[];
    //   for (
    //     var index = 0;
    //     index < itemController.item!.choiceOptions!.length;
    //     index++
    //   ) {
    //     variationList.add(
    //       itemController
    //           .item!
    //           .choiceOptions![index]
    //           .options![itemController.variationIndex![index]]
    //           .replaceAll(' ', ''),
    //     );
    //   }
    //   var variationType = '';
    //   var isFirst = true;
    //   for (final variation in variationList) {
    //     if (isFirst) {
    //       variationType = '$variationType$variation';
    //       isFirst = false;
    //     } else {
    //       variationType = '$variationType-$variation';
    //     }
    //   }

    //   num? price = itemController.item!.price;
    //   Variation? variation;
    //   stock = itemController.item!.stock ?? 0;
    //   for (final v in itemController.item!.variations!) {
    //     if (v.type == variationType) {
    //       price = v.price;
    //       variation = v;
    //       stock = v.stock;
    //       break;
    //     }
    //   }

    //   final num? discount =
    //       (itemController.item!.availableDateStarts != null ||
    //           itemController.item!.storeDiscount == 0)
    //       ? itemController.item!.discount
    //       : itemController.item!.storeDiscount;
    //   final discountType =
    //       (itemController.item!.availableDateStarts != null ||
    //           itemController.item!.storeDiscount == 0)
    //       ? itemController.item!.discountType
    //       : 'percent';
    //   final priceWithDiscount = PriceConverter.convertWithDiscount(
    //     price,
    //     discount,
    //     discountType,
    //   )!;
    //   final priceWithQuantity = priceWithDiscount * itemController.quantity!;
    //   num addonsCost = 0;
    //   final addOnIdList = <AddOn>[];
    //   final addOnsList = <AddOns>[];
    //   for (
    //     var index = 0;
    //     index < itemController.item!.addOns!.length;
    //     index++
    //   ) {
    //     if (itemController.addOnActiveList[index]) {
    //       addonsCost =
    //           addonsCost +
    //           (itemController.item!.addOns![index].price! *
    //               itemController.addOnQtyList[index]!);
    //       addOnIdList.add(
    //         AddOn(
    //           id: itemController.item!.addOns![index].id,
    //           quantity: itemController.addOnQtyList[index],
    //         ),
    //       );
    //       addOnsList.add(itemController.item!.addOns![index]);
    //     }
    //   }

    //   cartModel = CartModel(
    //     null,
    //     price,
    //     priceWithDiscount,
    //     variation != null ? [variation] : [],
    //     [],
    //     price! -
    //         PriceConverter.convertWithDiscount(price, discount, discountType)!,
    //     itemController.quantity,
    //     addOnIdList,
    //     addOnsList,
    //     itemController.item!.availableDateStarts != null,
    //     stock,
    //     itemController.item,
    //     itemController.item?.quantityLimit,
    //   );

    //   final listOfAddOnId = _getSelectedAddonIds(addOnIdList: addOnIdList);
    //   final listOfAddOnQty = _getSelectedAddonQtnList(addOnIdList: addOnIdList);

    //   cart = OnlineCart(
    //     cartId,
    //     item!.id,
    //     null,
    //     priceWithDiscount.toString(),
    //     '',
    //     variation != null ? [variation] : [],
    //     null,
    //     itemController.cartIndex != -1
    //         ? cartController.cartList[itemController.cartIndex].quantity
    //         : itemController.quantity,
    //     listOfAddOnId,
    //     addOnsList,
    //     listOfAddOnQty,
    //     'Item',
    //   );
    //   priceWithAddons =
    //       priceWithQuantity +
    //       (Get.find<GlobalController>()
    //               .configModel!
    //               .moduleConfig!
    //               .module!
    //               .addOn!
    //           ? addonsCost
    //           : 0);
    // }

    return GestureDetector(
      onTap: () => showItemDetailSheet(item!),
      child: Row(
        spacing: 10,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 17),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: (item?.imagesFullUrl?.firstOrNull?.isEmpty ?? true)
                      ? Image.asset(
                          AppIcons.logo,
                          height: MediaQuery.sizeOf(context).width * .28,
                          width: MediaQuery.sizeOf(context).width * .35,
                        ).shimmer(context, isLoad: isLoad)
                      : Image.network(
                          item?.imagesFullUrl?.firstOrNull ?? '',
                          height: MediaQuery.sizeOf(context).width * .28,
                          width: MediaQuery.sizeOf(context).width * .35,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              if (isLoad)
                const BoxShimmer(height: 30, width: 80)
              else
                GetBuilder<CartController>(
                  builder: (cartController) {
                    final cartValue = cartController.cartQuantity(
                      item?.id ?? 0,
                    );
                    final cartIndex = cartController.isExistInCart(
                      item?.id,
                      cartController.cartVariant(item?.id ?? 0),
                      false,
                      null,
                    );
                    return CartBtn(
                      cartValue: cartValue,
                      isAddBtn: cartValue == 0,
                      onTapAdd: () =>
                          cartController.itemDirectlyAddToCart(item, context),
                      onTap: (isRemove) => (cartValue == 1 && isRemove)
                          ? cartController.removeFromCart(cartIndex)
                          : cartController.setQuantity(
                              !isRemove,
                              cartIndex,
                              10,
                              10,
                            ),
                    );
                  },
                ),
            ],
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                if (isLoad)
                  const BoxShimmer(height: 14, width: 80)
                else
                  Text(
                    item?.name ?? 'Veg Momos',
                    style: context.style.s18w700.copyWith(
                      color: context.color.primary,
                    ),
                  ),
                if (isLoad)
                  const BoxShimmer(height: 10, width: 50)
                else
                  Text(
                    '${AppStrings.dinar} ${item?.price ?? 120}',
                    style: context.style.s18w700.copyWith(
                      color: context.color.primary,
                    ),
                  ),
                if (isLoad)
                  const BoxShimmer(height: 10, width: 100)
                else
                  Row(
                    children: [
                      SvgAssets(
                        AppIcons.thumbIc,
                        color: context.color.greenColor,
                        width: 15,
                      ),
                      Text(
                        '  ${item?.avgRating} ',
                        style: context.style.s14w700.copyWith(
                          color: context.color.greenColor,
                        ),
                      ),
                      Text(
                        '(${item?.ratingCount})',
                        style: context.style.s14w700.copyWith(
                          color: context.color.ff9c9c9c,
                        ),
                      ),
                    ],
                  ),
                if (isLoad)
                  const BoxShimmer(height: 25, width: 120)
                else
                  Text(
                    item?.description ??
                        'Veg moms are steamed dumplings filled with spiced mixed vegetables.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.style.s14w700.copyWith(
                      color: context.color.lightText,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // List<int?> _getSelectedAddonIds({required List<AddOn> addOnIdList}) {
  //   final listOfAddOnId = <int?>[];
  //   for (final addOn in addOnIdList) {
  //     listOfAddOnId.add(addOn.id);
  //   }
  //   return listOfAddOnId;
  // }

  // List<int?> _getSelectedAddonQtnList({required List<AddOn> addOnIdList}) {
  //   final listOfAddOnQty = <int?>[];
  //   for (final addOn in addOnIdList) {
  //     listOfAddOnQty.add(addOn.quantity);
  //   }
  //   return listOfAddOnQty;
  // }
}
