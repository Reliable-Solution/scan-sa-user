import 'package:scan_sa_user/common/widgets/custom_ink_well.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/favourite/controllers/favourite_controller.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/features/store/domain/models/store_model.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/app_constants.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_image.dart';
import 'package:scan_sa_user/common/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/widgets/discount_tag.dart';
import 'package:scan_sa_user/common/widgets/not_available_widget.dart';
import 'package:scan_sa_user/common/widgets/rating_bar.dart';
import 'package:scan_sa_user/common/widgets/title_widget.dart';
import 'package:scan_sa_user/features/store/screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class PopularStoreView extends StatelessWidget {
  const PopularStoreView({
    super.key,
    required this.isPopular,
    required this.isFeatured,
  });
  final bool isPopular;
  final bool isFeatured;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (storeController) {
        List<Store>? storeList = isFeatured
            ? storeController.featuredStoreList
            : isPopular
                ? storeController.popularStoreList
                : storeController.latestStoreList;

        return (storeList != null && storeList.isEmpty)
            ? const SizedBox()
            : Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(10, isPopular ? 2 : 15, 10, 10),
                    child: TitleWidget(
                      title: isFeatured
                          ? 'featured_stores'.tr
                          : isPopular
                              ? Get.find<SplashController>()
                                      .configModel!
                                      .moduleConfig!
                                      .module!
                                      .showRestaurantText!
                                  ? 'popular_restaurants'.tr
                                  : 'popular_stores'.tr
                              : '${'new_on'.tr} ${AppConstants.appName}',
                      onTap: () => Get.toNamed(
                        RouteHelper.getAllStoreRoute(
                          isFeatured
                              ? 'featured'
                              : isPopular
                                  ? 'popular'
                                  : 'latest',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: storeList != null
                        ? ListView.builder(
                            controller: ScrollController(),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(
                              left: Dimensions.paddingSizeSmall,
                            ),
                            itemCount:
                                storeList.length > 10 ? 10 : storeList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: Dimensions.paddingSizeDefault,
                                  bottom: 5,
                                ),
                                child: Container(
                                  width: 250,
                                  margin: const EdgeInsets.only(
                                    top: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radiusDefault,
                                    ),
                                  ),
                                  child: CustomInkWell(
                                    onTap: () {
                                      if (isFeatured &&
                                          Get.find<SplashController>()
                                                  .moduleList !=
                                              null) {
                                        for (ModuleModel module
                                            in Get.find<SplashController>()
                                                .moduleList!) {
                                          if (module.id ==
                                              storeList[index].moduleId) {
                                            Get.find<SplashController>()
                                                .setModule(module);
                                            break;
                                          }
                                        }
                                      }
                                      Get.toNamed(
                                        RouteHelper.getStoreRoute(
                                          id: storeList[index].id,
                                          page: isFeatured ? 'module' : 'store',
                                        ),
                                        arguments: StoreScreen(
                                          store: storeList[index],
                                          fromModule: isFeatured,
                                        ),
                                      );
                                    },
                                    radius: Dimensions.radiusDefault,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                Dimensions.radiusSmall,
                                              ),
                                              child: CustomImage(
                                                image:
                                                    '${storeList[index].coverPhotoFullUrl}',
                                                height: 130,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            DiscountTag(
                                              discount:
                                                  storeController.getDiscount(
                                                storeList[index],
                                              ),
                                              discountType: storeController
                                                  .getDiscountType(
                                                storeList[index],
                                              ),
                                              freeDelivery:
                                                  storeList[index].freeDelivery,
                                            ),
                                            storeController
                                                    .isOpenNow(storeList[index])
                                                ? const SizedBox()
                                                : const NotAvailableWidget(
                                                    isStore: true,
                                                  ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 5,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        storeList[index].name ??
                                                            '',
                                                        style: robotoMedium
                                                            .copyWith(
                                                          fontSize: 15,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    GetBuilder<
                                                        FavouriteController>(
                                                      builder:
                                                          (favouriteController) {
                                                        bool isWished =
                                                            favouriteController
                                                                .wishStoreIdList
                                                                .contains(
                                                          storeList[index].id,
                                                        );
                                                        return InkWell(
                                                          onTap: () {
                                                            if (AuthHelper
                                                                .isLoggedIn()) {
                                                              isWished
                                                                  ? favouriteController
                                                                      .removeFromFavouriteList(
                                                                      storeList[
                                                                              index]
                                                                          .id,
                                                                      true,
                                                                    )
                                                                  : favouriteController
                                                                      .addToFavouriteList(
                                                                      null,
                                                                      storeList[
                                                                              index]
                                                                          .id,
                                                                      true,
                                                                    );
                                                            } else {
                                                              showCustomSnackBar(
                                                                'you_are_not_logged_in'
                                                                    .tr,
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                context,
                                                              ).cardColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                Dimensions
                                                                    .radiusSmall,
                                                              ),
                                                            ),
                                                            child: Icon(
                                                              isWished
                                                                  ? Icons
                                                                      .favorite
                                                                  : Icons
                                                                      .favorite_border,
                                                              size: 18,
                                                              color: isWished
                                                                  ? Theme.of(
                                                                      context,
                                                                    ).primaryColor
                                                                  : Theme.of(
                                                                      context,
                                                                    ).disabledColor,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeExtraSmall,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: context
                                                            .color.primary,
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
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
                                                            ' ${storeList[index].ratingCount} ',
                                                            style: robotoRegular
                                                                .copyWith(
                                                              fontSize:
                                                                  12 * 0.9,
                                                              color: context
                                                                  .color
                                                                  .secondary,
                                                            ),
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      '  • ${storeList[index].deliveryTime} • ',
                                                      style: robotoRegular
                                                          .copyWith(
                                                        fontSize: 12,
                                                        color: context
                                                            .color.darkTextGrey,
                                                      ),
                                                      textDirection:
                                                          TextDirection.ltr,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        storeList[index]
                                                                .address ??
                                                            '',
                                                        style: robotoMedium
                                                            .copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeExtraSmall,
                                                          color: context.color
                                                              .darkTextGrey,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : PopularStoreShimmer(storeController: storeController),
                  ),
                ],
              );
      },
    );
  }
}

class PopularStoreShimmer extends StatelessWidget {
  const PopularStoreShimmer({super.key, required this.storeController});
  final StoreController storeController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 150,
          width: 200,
          margin: const EdgeInsets.only(
            right: Dimensions.paddingSizeSmall,
            bottom: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(Dimensions.radiusSmall),
                    ),
                    color: Colors.grey[300],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 10,
                          width: 130,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 5),
                        const RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
