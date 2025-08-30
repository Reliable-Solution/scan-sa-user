import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/common/widgets/custom_ink_well.dart';
import 'package:scan_sa_user/common/widgets/hover/text_hover.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/features/favourite/controllers/favourite_controller.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/features/store/domain/models/store_model.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_image.dart';
import 'package:scan_sa_user/common/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/widgets/discount_tag.dart';
import 'package:scan_sa_user/common/widgets/new_tag.dart';
import 'package:scan_sa_user/features/store/screens/store_screen.dart';

class StoreCardWithDistance extends StatelessWidget {
  const StoreCardWithDistance({
    super.key,
    required this.store,
    this.fromAllStore = false,
    this.isNewStore = false,
    this.fromTopOffers = false,
    this.fromNearBy = false,
  });
  final Store store;
  final bool fromAllStore;
  final bool isNewStore;
  final bool fromTopOffers;
  final bool fromNearBy;

  @override
  Widget build(BuildContext context) {
    num distance = store.distance! / 1000;
    num discount = store.discount?.discount ?? 0;
    String discountType = store.discount?.discountType ?? '';
    bool isRightSide =
        Get.find<SplashController>().configModel!.currencySymbolDirection ==
            'right';
    String currencySymbol =
        Get.find<SplashController>().configModel!.currencySymbol!;

    return Stack(
      children: [
        SizedBox(
          width: fromAllStore ? double.infinity : 260,
          // decoration: BoxDecoration(
          //   color: Theme.of(context).cardColor,
          //   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          //   boxShadow: const [
          //     BoxShadow(
          //       color: Colors.black12,
          //       blurRadius: 5,
          //       spreadRadius: 1,
          //     ),
          //   ],
          // ),
          child: CustomInkWell(
            onTap: () {
              if (Get.find<SplashController>().moduleList != null) {
                for (ModuleModel module
                    in Get.find<SplashController>().moduleList!) {
                  if (module.id == store.moduleId) {
                    Get.find<SplashController>().setModule(module);
                    break;
                  }
                }
              }
              Get.toNamed(
                RouteHelper.getStoreRoute(id: store.id, page: 'store'),
                arguments: StoreScreen(store: store, fromModule: false),
              );
            },
            radius: Dimensions.radiusDefault,
            child: TextHover(
              builder: (hovered) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusDefault),
                          child: CustomImage(
                            isHovered: hovered,
                            image: '${store.coverPhotoFullUrl}',
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                        if (isNewStore)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: context.color.primary,
                            ),
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Images.distanceLine,
                                  height: 15,
                                  width: 15,
                                  color: Colors.black,
                                ),
                                Text(
                                  '${distance > 100 ? '100+' : distance.toStringAsFixed(2)} ${'km'.tr} ${'from_you'.tr}',
                                  style: robotoRegular.copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraSmall,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      store.name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          robotoMedium.copyWith(fontSize: 17),
                                    ),
                                  ),
                                  GetBuilder<FavouriteController>(
                                    builder: (favouriteController) {
                                      bool isWished = favouriteController
                                          .wishStoreIdList
                                          .contains(store.id);
                                      return InkWell(
                                        onTap: () {
                                          if (AuthHelper.isLoggedIn()) {
                                            isWished
                                                ? favouriteController
                                                    .removeFromFavouriteList(
                                                    store.id,
                                                    true,
                                                  )
                                                : favouriteController
                                                    .addToFavouriteList(
                                                    null,
                                                    store.id,
                                                    true,
                                                  );
                                          } else {
                                            showCustomSnackBar(
                                              'you_are_not_logged_in'.tr,
                                            );
                                          }
                                        },
                                        child: Icon(
                                          isWished
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 22,
                                          color: context.color.secondary,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              if (!fromTopOffers)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    top: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  child: Row(
                                    spacing: Dimensions.paddingSizeExtraSmall,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: context.color.secondary,
                                        size: 18,
                                      ),
                                      Expanded(
                                        child: Text(
                                          store.address ?? '',
                                          style: robotoMedium.copyWith(
                                            fontSize: 14,
                                            color: context.color.darkTextGrey,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (!fromTopOffers)
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: context.color.primary,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 2,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            size: 12,
                                          ),
                                          Text(
                                            ' ${store.avgRating} ',
                                            style: robotoRegular.copyWith(
                                              fontSize: 12 * 0.9,
                                              color: context.color.secondary,
                                            ),
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '  • ${store.deliveryTime}${fromNearBy || isNewStore ? '' : '  •  '}',
                                      style: robotoRegular.copyWith(
                                        fontSize: 12,
                                        color: context.color.darkTextGrey,
                                      ),
                                      textDirection: TextDirection.ltr,
                                    ),
                                    if (!fromNearBy && !isNewStore)
                                      Image.asset(
                                        Images.distanceLine,
                                        height: 15,
                                        width: 15,
                                      ),
                                    if (!fromNearBy && !isNewStore)
                                      Text(
                                        '${distance > 100 ? '100+' : distance.toStringAsFixed(2)} ${'km'.tr} ${'from_you'.tr}',
                                        style: robotoRegular.copyWith(
                                          fontSize: 12,
                                          color: context.color.darkTextGrey,
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                          ),
                          if (fromTopOffers)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall,
                                ),
                                Text(
                                  store.address ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: robotoRegular.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (store.ratingCount! > 0)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: Dimensions.paddingSizeDefault,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 14,
                                            ),
                                            const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraSmall,
                                            ),
                                            Text(
                                              '${store.avgRating}',
                                              style: robotoRegular.copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeExtraSmall,
                                            ),
                                            Text(
                                              '(${store.ratingCount})',
                                              style: robotoRegular.copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                                color: Theme.of(
                                                  context,
                                                ).disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    Text(
                                      '${store.itemCount} ${'items'.tr}',
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        if (fromTopOffers)
          Positioned(
            right: 10,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    Dimensions.radiusDefault,
                  ),
                ),
                color:
                    Theme.of(context).colorScheme.error.withValues(alpha: 0.8),
              ),
              child: Text(
                discount > 0
                    ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}$discount${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} ${'off'.tr}'
                    : 'free_delivery'.tr,
                style: robotoMedium.copyWith(
                  color: Theme.of(context).cardColor,
                  fontSize: Dimensions.fontSizeSmall,
                ),
                textAlign: TextAlign.center,
              ),
              // child: Text('new'.tr, style: robotoMedium.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeSmall)),
            ),
          )
        else
          DiscountTag(
            discount: Get.find<StoreController>().getDiscount(store),
            discountType: Get.find<StoreController>().getDiscountType(store),
            freeDelivery: store.freeDelivery,
          ),
        if (!Get.find<StoreController>().isOpenNow(store))
          Positioned(
            right: 10,
            top: 10,
            child: SvgAssets(
              Images.closedIc,
              width: 40,
            ),
          ),
        if (isNewStore)
          const NewTag(
            right: 10,
            left: null,
            top: 10,
          ),
      ],
    );
  }
}
