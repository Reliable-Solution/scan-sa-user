import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/cart/controllers/cart_controller.dart';
import 'package:scan_sa_user/features/item/controllers/item_controller.dart';
import 'package:scan_sa_user/features/item/domain/models/item_model.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';

class CartCountView extends StatelessWidget {
  const CartCountView({
    super.key,
    required this.item,
    this.child,
    this.index = -1,
  });
  final Item item;
  final Widget? child;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) {
        int cartQty = cartController.cartQuantity(item.id!);
        int cartIndex = cartController.isExistInCart(
          item.id,
          cartController.cartVariant(item.id!),
          false,
          null,
        );
        return cartQty != 0
            ? Container(
                decoration: BoxDecoration(
                  color: context.color.secondary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10,
                  children: [
                    InkWell(
                      onTap: cartController.isLoading
                          ? null
                          : () {
                              if (cartController.cartList[cartIndex].quantity! >
                                  1) {
                                cartController.setDirectlyAddToCartIndex(index);
                                cartController.setQuantity(
                                  false,
                                  cartIndex,
                                  cartController.cartList[cartIndex].stock,
                                  cartController
                                      .cartList[cartIndex].item!.quantityLimit,
                                );
                              } else {
                                cartController.removeFromCart(cartIndex);
                              }
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.color.secondary,
                          ),
                        ),
                        padding: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraSmall,
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 16,
                          color: context.color.white,
                        ),
                      ),
                    ),
                    cartController.isLoading &&
                            cartController.directAddCartItemIndex == index
                        ? SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).cardColor,
                              strokeWidth: 1,
                            ),
                          )
                        : Text(
                            cartQty.toString(),
                            style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                    InkWell(
                      onTap: cartController.isLoading
                          ? null
                          : () {
                              cartController.setDirectlyAddToCartIndex(index);
                              cartController.setQuantity(
                                true,
                                cartIndex,
                                cartController.cartList[cartIndex].stock,
                                cartController
                                    .cartList[cartIndex].quantityLimit,
                              );
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.color.secondary,
                          ),
                        ),
                        padding: const EdgeInsets.all(
                          Dimensions.paddingSizeExtraSmall,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: context.color.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : InkWell(
                onTap: () {
                  Get.find<ItemController>()
                      .itemDirectlyAddToCart(item, context);
                },
                child: child ??
                    Container(
                      alignment: Alignment.center,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: context.color.greenColor,
                        boxShadow: [
                          BoxShadow(
                            color:
                                context.color.secondary.withValues(alpha: .25),
                            blurRadius: 10,
                            spreadRadius: -1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 3,
                      ),
                      child: Text(
                        'ADD',
                        style: context.style.s14w600.copyWith(
                          color: context.color.white,
                        ),
                      ),
                    ),
              );
      },
    );
  }
}
