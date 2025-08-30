import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/favourite/controllers/favourite_controller.dart';
import 'package:scan_sa_user/features/address/domain/models/address_model.dart';
import 'package:scan_sa_user/features/store/domain/models/store_model.dart';
import 'package:scan_sa_user/features/store/widgets/widget_padding.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_image.dart';
import 'package:scan_sa_user/common/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreDescriptionViewWidget extends StatelessWidget {
  const StoreDescriptionViewWidget({super.key, required this.store});
  final Store? store;

  @override
  Widget build(BuildContext context) {
    bool isAvailable = Get.find<StoreController>()
        .isStoreOpenNow(store!.active!, store!.schedules);
    Color? textColor =
        ResponsiveHelper.isDesktop(context) ? Colors.white : null;
    // Module? moduleData;
    // for(ZoneData zData in AddressHelper.getUserAddressFromSharedPref()!.zoneData!) {
    //   for(Modules m in zData.modules!) {
    //     if(m.id == Get.find<SplashController>().module!.id) {
    //       moduleData = m as Module?;
    //       break;
    //     }
    //   }
    // }
    return Column(
      children: [
        ResponsiveHelper.isDesktop(context)
            ? Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusDefault),
                    child: Stack(
                      children: [
                        CustomImage(
                          image: '${store!.logoFullUrl}',
                          height:
                              ResponsiveHelper.isDesktop(context) ? 140 : 60,
                          width: ResponsiveHelper.isDesktop(context) ? 140 : 70,
                          fit: BoxFit.cover,
                        ),
                        isAvailable
                            ? const SizedBox()
                            : Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(
                                        Dimensions.radiusSmall,
                                      ),
                                    ),
                                    color: Colors.black.withValues(alpha: 0.6),
                                  ),
                                  child: Text(
                                    'closed_now'.tr,
                                    textAlign: TextAlign.center,
                                    style: robotoRegular.copyWith(
                                      color: Colors.white,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                store!.name!,
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: textColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            GetBuilder<FavouriteController>(
                              builder: (favouriteController) {
                                bool isWished = favouriteController
                                    .wishStoreIdList
                                    .contains(store!.id);
                                return InkWell(
                                  onTap: () {
                                    if (AuthHelper.isLoggedIn()) {
                                      isWished
                                          ? favouriteController
                                              .removeFromFavouriteList(
                                              store!.id,
                                              true,
                                            )
                                          : favouriteController
                                              .addToFavouriteList(
                                              null,
                                              store?.id,
                                              true,
                                            );
                                    } else {
                                      showCustomSnackBar(
                                        'you_are_not_logged_in'.tr,
                                      );
                                    }
                                  },
                                  child: ResponsiveHelper.isDesktop(context)
                                      ? Container(
                                          padding: const EdgeInsets.all(
                                            Dimensions.paddingSizeExtraSmall,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSmall,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  isWished
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 14,
                                                ),
                                                const SizedBox(
                                                  width: Dimensions
                                                      .paddingSizeExtraSmall,
                                                ),
                                                Text(
                                                  'wish_list'.tr,
                                                  style: robotoRegular.copyWith(
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Icon(
                                          isWished
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isWished
                                              ? context.color.secondary
                                              : Theme.of(context).disabledColor,
                                        ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                store!.address ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ResponsiveHelper.isDesktop(context)
                              ? Dimensions.paddingSizeSmall
                              : 0,
                        ),
                        Row(
                          children: [
                            Text(
                              'minimum_order_amount'.tr,
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            const SizedBox(
                              width: Dimensions.paddingSizeExtraSmall,
                            ),
                            Expanded(
                              child: Text(
                                PriceConverter.convertPrice(
                                  store!.minimumOrder,
                                ),
                                textDirection: TextDirection.ltr,
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: context.color.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        SizedBox(
          height: ResponsiveHelper.isDesktop(context)
              ? 30
              : Dimensions.paddingSizeSmall,
        ),
        ResponsiveHelper.isDesktop(context)
            ? IntrinsicHeight(
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => Get.toNamed(
                        RouteHelper.getStoreReviewRoute(
                          store!.id,
                          store!.name,
                          store!,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: context.color.secondary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeExtraSmall,
                              ),
                              Text(
                                store!.avgRating!.toStringAsFixed(1),
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
                          ),
                          Text(
                            '${store!.ratingCount} + ${'ratings'.tr}',
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const VerticalDivider(color: Colors.white, thickness: 1),
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => Get.toNamed(
                        RouteHelper.getMapRoute(
                          AddressModel(
                            id: store!.id,
                            address: store!.address,
                            latitude: store!.latitude,
                            longitude: store!.longitude,
                            contactPersonNumber: '',
                            contactPersonName: '',
                            addressType: '',
                          ),
                          'store',
                          Get.find<SplashController>()
                              .getModuleConfig(
                                Get.find<SplashController>().module!.moduleType,
                              )
                              .newVariation!,
                          storeName: store!.name,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Icon(Icons.location_on, color: context.color.secondary, size: 20),
                          Image.asset(
                            Images.storeLocationIcon,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
                          ),
                          Text(
                            'location'.tr,
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    const VerticalDivider(color: Colors.white, thickness: 1),
                    const Expanded(child: SizedBox()),
                    Column(
                      children: [
                        Image.asset(
                          Images.storeDeliveryTimeIcon,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeExtraSmall,
                        ),
                        Text(
                          store!.deliveryTime!,
                          style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    (store!.delivery! && store!.freeDelivery!)
                        ? const Expanded(child: SizedBox())
                        : const SizedBox(),
                    (store!.delivery! && store!.freeDelivery!)
                        ? const VerticalDivider(
                            color: Colors.white,
                            thickness: 1,
                          )
                        : const SizedBox(),
                    (store!.delivery! && store!.freeDelivery!)
                        ? const Expanded(child: SizedBox())
                        : const SizedBox(),
                    (store!.delivery! && store!.freeDelivery!)
                        ? Column(
                            children: [
                              Icon(
                                Icons.money_off,
                                color: context.color.secondary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeExtraSmall,
                              ),
                              Text(
                                'free_delivery'.tr,
                                style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: textColor,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  detailWidget(
                    context,
                    icon: Images.thumbIc,
                    desc: '${store?.avgRating} (${store?.ratingCount})',
                  ),
                  WidgetPadding.symmetric(
                    horizontal: SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        color: context.color.borderColor,
                        width: 34,
                      ),
                    ),
                    child: detailWidget(
                      context,
                      icon: Images.locationFillIc,
                      desc: 'location'.tr,
                    ),
                  ),
                  detailWidget(
                    context,
                    icon: Images.clockIc,
                    desc: store?.deliveryTime ?? '',
                  ),
                  // const Expanded(child: SizedBox()),
                  // InkWell(
                  //   onTap: () => Get.toNamed(
                  //     RouteHelper.getStoreReviewRoute(
                  //       store!.id,
                  //       store!.name,
                  //       store!,
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Icon(
                  //             Icons.star,
                  //             color: context.color.secondary,
                  //             size: 20,
                  //           ),
                  //           const SizedBox(
                  //             width: Dimensions.paddingSizeExtraSmall,
                  //           ),
                  //           Text(
                  //             store!.avgRating!.toStringAsFixed(1),
                  //             style: robotoMedium.copyWith(
                  //               fontSize: Dimensions.fontSizeSmall,
                  //               color: textColor,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  //       Text(
                  //         '${store!.ratingCount} + ${'ratings'.tr}',
                  //         style: robotoRegular.copyWith(
                  //           fontSize: Dimensions.fontSizeSmall,
                  //           color: textColor,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const Expanded(child: SizedBox()),
                  // InkWell(
                  //   onTap: () => Get.toNamed(
                  //     RouteHelper.getMapRoute(
                  //       AddressModel(
                  //         id: store!.id,
                  //         address: store!.address,
                  //         latitude: store!.latitude,
                  //         longitude: store!.longitude,
                  //         contactPersonNumber: '',
                  //         contactPersonName: '',
                  //         addressType: '',
                  //       ),
                  //       'store',
                  //       Get.find<SplashController>()
                  //           .getModuleConfig(
                  //             Get.find<SplashController>().module!.moduleType,
                  //           )
                  //           .newVariation!,
                  //       storeName: store!.name,
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Icon(
                  //         Icons.location_on,
                  //         color: context.color.secondary,
                  //         size: 20,
                  //       ),
                  //       const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  //       Text(
                  //         'location'.tr,
                  //         style: robotoRegular.copyWith(
                  //           fontSize: Dimensions.fontSizeSmall,
                  //           color: textColor,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const Expanded(child: SizedBox()),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Icon(
                  //           Icons.timer,
                  //           color: context.color.secondary,
                  //           size: 20,
                  //         ),
                  //         const SizedBox(
                  //           width: Dimensions.paddingSizeExtraSmall,
                  //         ),
                  //         Text(
                  //           store!.deliveryTime!,
                  //           style: robotoMedium.copyWith(
                  //             fontSize: Dimensions.fontSizeSmall,
                  //             color: textColor,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  //     Text(
                  //       'delivery_time'.tr,
                  //       style: robotoRegular.copyWith(
                  //         fontSize: Dimensions.fontSizeSmall,
                  //         color: textColor,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // (store!.delivery! && store!.freeDelivery!)
                  //     ? const Expanded(child: SizedBox())
                  //     : const SizedBox(),
                  // (store!.delivery! && store!.freeDelivery!)
                  //     ? Column(
                  //         children: [
                  //           Icon(
                  //             Icons.money_off,
                  //             color: context.color.secondary,
                  //             size: 20,
                  //           ),
                  //           const SizedBox(
                  //             width: Dimensions.paddingSizeExtraSmall,
                  //           ),
                  //           Text(
                  //             'free_delivery'.tr,
                  //             style: robotoRegular.copyWith(
                  //               fontSize: Dimensions.fontSizeSmall,
                  //               color: textColor,
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //     : const SizedBox(),
                  // const Expanded(child: SizedBox()),
                ],
              ),
      ],
    );
  }

  Widget detailWidget(
    BuildContext context, {
    required String icon,
    required String desc,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * .25,
      ),
      child: Column(
        spacing: 5,
        children: [
          CircleAvatar(
            radius: 22.5,
            backgroundColor: context.color.primary,
            child: SvgAssets(icon, height: 25, color: context.color.white),
          ),
          Text(
            desc,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.style.s12w700,
          ),
        ],
      ),
    );
  }
}
