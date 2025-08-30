import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/favourite/controllers/favourite_controller.dart';
import 'package:scan_sa_user/features/item/domain/models/item_model.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/common/widgets/custom_snackbar.dart';

class AddFavouriteView extends StatelessWidget {
  const AddFavouriteView({
    super.key,
    required this.item,
    this.top = 15,
    this.right = 15,
    this.left,
    this.storeId,
    this.isPosition = true,
  });
  final Item? item;
  final double? top, right;
  final double? left;
  final int? storeId;
  final bool isPosition;

  @override
  Widget build(BuildContext context) {
    Widget child = GetBuilder<FavouriteController>(
      builder: (favouriteController) {
        bool isWished;
        if (storeId != null) {
          isWished = favouriteController.wishStoreIdList.contains(storeId);
        } else {
          isWished = favouriteController.wishItemIdList.contains(item!.id);
        }
        return InkWell(
          onTap: () {
            if (AuthHelper.isLoggedIn()) {
              if (storeId != null) {
                isWished
                    ? favouriteController.removeFromFavouriteList(
                        storeId,
                        true,
                      )
                    : favouriteController.addToFavouriteList(
                        null,
                        storeId,
                        true,
                      );
              } else {
                isWished
                    ? favouriteController.removeFromFavouriteList(
                        item!.id,
                        false,
                      )
                    : favouriteController.addToFavouriteList(
                        item,
                        null,
                        false,
                      );
              }
            } else {
              showCustomSnackBar('you_are_not_logged_in'.tr);
            }
          },
          child: Icon(
            isWished ? Icons.favorite : Icons.favorite_border,
            color: context.color.secondary,
            size: 20,
          ),
        );
      },
    );
    return isPosition
        ? Positioned(
            top: top,
            right: right,
            left: left,
            child: child,
          )
        : child;
  }
}
