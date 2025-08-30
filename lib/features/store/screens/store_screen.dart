import 'package:flutter/rendering.dart';
import 'package:scan_sa_user/common/widgets/not_available_widget.dart';
import 'package:scan_sa_user/features/cart/controllers/cart_controller.dart';
import 'package:scan_sa_user/features/category/controllers/category_controller.dart';
import 'package:scan_sa_user/features/store/book_slot_screen/screens/restaurant_reservation_screen.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/favourite/controllers/favourite_controller.dart';
import 'package:scan_sa_user/features/category/domain/models/category_model.dart';
import 'package:scan_sa_user/features/item/domain/models/item_model.dart';
import 'package:scan_sa_user/features/store/domain/models/store_model.dart';
import 'package:scan_sa_user/features/store/widgets/store_desktop_view.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/date_converter.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/app_constants.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:scan_sa_user/common/widgets/custom_image.dart';
import 'package:scan_sa_user/common/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/widgets/item_view.dart';
import 'package:scan_sa_user/common/widgets/item_widget.dart';
import 'package:scan_sa_user/common/widgets/menu_drawer.dart';
import 'package:scan_sa_user/common/widgets/paginated_list_view.dart';
import 'package:scan_sa_user/common/widgets/veg_filter_widget.dart';
import 'package:scan_sa_user/common/widgets/web_item_widget.dart';
import 'package:scan_sa_user/common/widgets/web_menu_bar.dart';
import 'package:scan_sa_user/features/checkout/screens/checkout_screen.dart';
import 'package:scan_sa_user/features/store/widgets/customizable_space_bar_widget.dart';
import 'package:scan_sa_user/features/store/widgets/store_banner_widget.dart';
import 'package:scan_sa_user/features/store/widgets/store_description_view_widget.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/store/widgets/store_details_screen_shimmer_widget.dart';

import '../widgets/bottom_cart_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    super.key,
    required this.store,
    required this.fromModule,
    this.slug = '',
    this.fromQr = false,
    this.fromBookTable = false,
  });
  final Store? store;
  final bool fromModule;
  final bool fromQr;
  final bool fromBookTable;
  final String slug;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final ScrollController scrollController = ScrollController();
  final storeController = Get.find<StoreController>();
  @override
  void initState() {
    super.initState();

    initDataCall();
  }

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  Future<void> initDataCall() async {
    if (storeController.isSearching) {
      storeController.changeSearchStatus(isUpdate: false);
    }
    storeController.hideAnimation();
    await storeController
        .getStoreDetails(
      Store(id: widget.store!.id),
      widget.fromModule,
      slug: widget.slug,
    )
        .then((value) {
      storeController.showButtonAnimation();
    });
    if (Get.find<CategoryController>().categoryList == null) {
      Get.find<CategoryController>().getCategoryList(true);
    }
    storeController.getStoreBannerList(
      widget.store!.id ?? storeController.store!.id,
    );
    storeController.getRestaurantRecommendedItemList(
      widget.store!.id ?? storeController.store!.id,
      false,
    );
    storeController.getStoreItemList(
      widget.store!.id ?? storeController.store!.id,
      1,
      'all',
      false,
    );

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (storeController.showFavButton) {
          storeController.changeFavVisibility();
          storeController.hideAnimation();
        }
      } else {
        if (!storeController.showFavButton) {
          storeController.changeFavVisibility();
          storeController.showButtonAnimation();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GetBuilder<StoreController>(
        builder: (storeController) {
          return GetBuilder<CategoryController>(
            builder: (categoryController) {
              Store? store;
              if (storeController.store != null &&
                  storeController.store!.name != null &&
                  categoryController.categoryList != null) {
                store = storeController.store;
                storeController.setCategoryList();
              }
              return (storeController.store != null &&
                      storeController.store!.name != null &&
                      categoryController.categoryList != null)
                  ? CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      slivers: [
                        ResponsiveHelper.isDesktop(context)
                            ? SliverToBoxAdapter(
                                child: Container(
                                  color: const Color(0xFF171A29),
                                  padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeLarge,
                                  ),
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: SizedBox(
                                      width: Dimensions.webMaxWidth,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeSmall,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimensions.radiusDefault,
                                                ),
                                                child: Stack(
                                                  children: [
                                                    CustomImage(
                                                      fit: BoxFit.cover,
                                                      height: 240,
                                                      width: 590,
                                                      image: store
                                                              ?.coverPhotoFullUrl ??
                                                          '',
                                                    ),
                                                    store?.discount != null
                                                        ? Positioned(
                                                            bottom: 0,
                                                            left: 0,
                                                            right: 0,
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                  context,
                                                                ).primaryColor,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                Dimensions
                                                                    .paddingSizeExtraSmall,
                                                              ),
                                                              child: Text(
                                                                '${store?.discount!.discountType == 'percent' ? '${store?.discount!.discount}% ${'off'.tr}' : '${PriceConverter.convertPrice(store?.discount!.discount)} ${'off'.tr}'} '
                                                                '${'on_all_products'.tr}, ${'after_minimum_purchase'.tr} ${PriceConverter.convertPrice(store?.discount!.minPurchase)},'
                                                                ' ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(store!.discount!.startTime!)} '
                                                                '- ${DateConverter.convertTimeToTime(store.discount!.endTime!)}',
                                                                style:
                                                                    robotoMedium
                                                                        .copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeLarge,
                                            ),
                                            Expanded(
                                              child: StoreDescriptionViewWidget(
                                                store: store,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SliverAppBar(
                                expandedHeight: 310,
                                pinned: true,
                                elevation: 0.5,
                                leadingWidth: AppSizes.appPadding + 40,
                                backgroundColor: Theme.of(context).cardColor,
                                leading: IconButton(
                                  icon: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.color.secondary,
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.chevron_left,
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                  onPressed: Get.back,
                                ),
                                flexibleSpace: CustomizableSpaceBarWidget(
                                  builder: (context, scrollingRate) {
                                    return FlexibleSpaceBar(
                                      // titlePadding: EdgeInsets.zero,
                                      centerTitle: scrollingRate != 1,
                                      expandedTitleScale: 1.1,
                                      title: SizedBox(
                                        width: scrollingRate == 1
                                            ? MediaQuery.sizeOf(context).width /
                                                2
                                            : MediaQuery.sizeOf(context).width -
                                                (AppSizes.appPadding * 2),
                                        child: Text(
                                          store?.name ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: scrollingRate == 1
                                              ? TextAlign.start
                                              : TextAlign.center,
                                          style: context.style.s22w700,
                                        ),
                                      ),
                                      // expandedTitleScale: 1.1,
                                      // title: CustomizableSpaceBarWidget(
                                      //   builder: (context, scrollingRate) {
                                      //     return Container(
                                      //       height:
                                      //           store!.discount != null ? 145 : 100,
                                      //       decoration: BoxDecoration(
                                      //         color: Theme.of(context).cardColor,
                                      //         borderRadius:
                                      //             const BorderRadius.vertical(
                                      //           top: Radius.circular(
                                      //             Dimensions.radiusLarge,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                      background: Column(
                                        children: [
                                          Flexible(
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Column(
                                                  children: [
                                                    Expanded(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                            35,
                                                          ),
                                                          bottomRight:
                                                              Radius.circular(
                                                            35,
                                                          ),
                                                        ),
                                                        child: CustomImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              '${store!.coverPhotoFullUrl}',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 50,
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  // margin:
                                                  //     const EdgeInsets.only(bottom: 15),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                    color: context.color.white,
                                                    border: Border.all(
                                                      color: context.color.grey,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  padding: const EdgeInsets.all(
                                                    14,
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      ClipOval(
                                                        child: CustomImage(
                                                          fit: BoxFit.cover,
                                                          image:
                                                              '${store.logoFullUrl}',
                                                        ),
                                                      ),
                                                      if (!Get.find<
                                                              StoreController>()
                                                          .isOpenNow(store))
                                                        const NotAvailableWidget(
                                                          isStore: true,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Opacity(
                                              opacity: 0,
                                              child: Text(
                                                store.name ?? '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: scrollingRate == 1
                                                    ? TextAlign.start
                                                    : TextAlign.center,
                                                style: context.style.s22w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                actions: [
                                  CustomizableSpaceBarWidget(
                                    builder: (context, scrollingRate) {
                                      return Row(
                                        spacing: Dimensions.paddingSizeSmall,
                                        children: [
                                          GetBuilder<FavouriteController>(
                                            builder: (favouriteController) {
                                              bool isWished =
                                                  favouriteController
                                                      .wishStoreIdList
                                                      .contains(
                                                store!.id,
                                              );
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
                                                      'you_are_not_logged_in'
                                                          .tr,
                                                    );
                                                  }
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      context.color.secondary,
                                                  radius:
                                                      20 - (scrollingRate * 2),
                                                  child: Icon(
                                                    isWished
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: context.color.white,
                                                    size: 24 -
                                                        (scrollingRate * 4),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          if (AppConstants
                                                  .webHostedUrl.isNotEmpty &&
                                              scrollingRate < .99)
                                            InkWell(
                                              onTap: () {
                                                storeController.shareStore();
                                              },
                                              child: CircleAvatar(
                                                radius:
                                                    20 - (scrollingRate * 2),
                                                backgroundColor:
                                                    context.color.secondary,
                                                child: Icon(
                                                  Icons.share,
                                                  size:
                                                      24 - (scrollingRate * 4),
                                                ),
                                              ),
                                            ),
                                          InkWell(
                                            onTap: () => Get.toNamed(
                                              RouteHelper
                                                  .getSearchStoreItemRoute(
                                                store!.id,
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  context.color.secondary,
                                              radius: 20 - (scrollingRate * 2),
                                              child: Icon(
                                                Icons.search,
                                                size: 24 - (scrollingRate * 4),
                                                color: context.color.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: Dimensions.paddingSizeSmall,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                        if (storeController.isFromBookTable)
                          const SliverToBoxAdapter(
                            child: RestaurantReservationScreen(),
                          )
                        else ...[
                          (ResponsiveHelper.isDesktop(context) &&
                                  storeController.recommendedItemModel !=
                                      null &&
                                  storeController
                                      .recommendedItemModel!.items!.isNotEmpty)
                              ? SliverToBoxAdapter(
                                  child: Container(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withValues(alpha: 0.10),
                                    child: Center(
                                      child: SizedBox(
                                        width: Dimensions.webMaxWidth,
                                        height: ResponsiveHelper.isDesktop(
                                          context,
                                        )
                                            ? 325
                                            : 125,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height:
                                                  Dimensions.paddingSizeSmall,
                                            ),
                                            Text(
                                              'recommended_for_you'.tr,
                                              style: robotoMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: Dimensions
                                                  .paddingSizeExtraSmall,
                                            ),
                                            Text(
                                              'here_is_what_you_might_like'.tr,
                                              style: robotoRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: Theme.of(context)
                                                    .disabledColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: Dimensions
                                                  .paddingSizeExtraSmall,
                                            ),
                                            SizedBox(
                                              height: 250,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: storeController
                                                    .recommendedItemModel!
                                                    .items!
                                                    .length,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: Dimensions
                                                      .paddingSizeExtraSmall,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    width: 225,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: Dimensions
                                                          .paddingSizeSmall,
                                                      left: Dimensions
                                                          .paddingSizeExtraSmall,
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    child: WebItemWidget(
                                                      isStore: false,
                                                      item: storeController
                                                          .recommendedItemModel!
                                                          .items![index],
                                                      store: null,
                                                      index: index,
                                                      length: null,
                                                      isCampaign: false,
                                                      inStore: true,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SliverToBoxAdapter(child: SizedBox()),
                          // const SliverToBoxAdapter(
                          //   child:
                          //       SizedBox(height: Dimensions.paddingSizeSmall),
                          // ),

                          ///web view..
                          if (ResponsiveHelper.isDesktop(context))
                            StoreDesktopView(
                              storeId: widget.store!.id,
                              scrollController: scrollController,
                            ),

                          ///mobile view..
                          if (!ResponsiveHelper.isDesktop(context))
                            SliverToBoxAdapter(
                              child: Center(
                                child: Container(
                                  width: Dimensions.webMaxWidth,
                                  // padding: const EdgeInsets.all(
                                  //   Dimensions.paddingSizeSmall,
                                  // ),
                                  color: Theme.of(context).cardColor,
                                  child: Column(
                                    children: [
                                      if (!ResponsiveHelper.isDesktop(context))
                                        StoreDescriptionViewWidget(
                                          store: store,
                                        ),
                                      const SizedBox(
                                        height: Dimensions.paddingSizeSmall,
                                      ),
                                      store?.announcementActive ?? false
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withValues(
                                                      alpha: 0.05,
                                                    ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimensions.radiusDefault,
                                                ),
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withValues(
                                                        alpha: 0.2,
                                                      ),
                                                ),
                                              ),
                                              padding: const EdgeInsets.all(
                                                Dimensions.paddingSizeSmall,
                                              ),
                                              margin: const EdgeInsets.only(
                                                top:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    Images.announcement,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: Dimensions
                                                        .paddingSizeSmall,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      store?.announcementMessage ??
                                                          '',
                                                      style: robotoRegular
                                                          .copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeSmall,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(),
                                      StoreBannerWidget(
                                        storeController: storeController,
                                      ),
                                      const SizedBox(
                                        height: Dimensions.paddingSizeLarge,
                                      ),
                                      (!ResponsiveHelper.isDesktop(
                                                context,
                                              ) &&
                                              storeController
                                                      .recommendedItemModel !=
                                                  null &&
                                              storeController
                                                  .recommendedItemModel!
                                                  .items!
                                                  .isNotEmpty)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'recommended_for_you'.tr,
                                                  style: robotoMedium,
                                                ),
                                                const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeExtraSmall,
                                                ),
                                                SizedBox(
                                                  height: ResponsiveHelper
                                                          .isDesktop(
                                                    context,
                                                  )
                                                      ? 150
                                                      : 130,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: storeController
                                                        .recommendedItemModel!
                                                        .items!
                                                        .length,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding: ResponsiveHelper
                                                                .isDesktop(
                                                          context,
                                                        )
                                                            ? const EdgeInsets
                                                                .symmetric(
                                                                vertical: 20,
                                                              )
                                                            : const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10,
                                                              ),
                                                        child: Container(
                                                          width: ResponsiveHelper
                                                                  .isDesktop(
                                                            context,
                                                          )
                                                              ? 500
                                                              : 300,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: Dimensions
                                                                .paddingSizeSmall,
                                                            left: Dimensions
                                                                .paddingSizeExtraSmall,
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: Dimensions
                                                                .paddingSizeSmall,
                                                          ),
                                                          child: ItemWidget(
                                                            isStore: false,
                                                            item: storeController
                                                                .recommendedItemModel!
                                                                .items![index],
                                                            store: null,
                                                            index: index,
                                                            length: null,
                                                            isCampaign: false,
                                                            inStore: true,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ResponsiveHelper.isDesktop(context)
                              ? const SliverToBoxAdapter(child: SizedBox())
                              : (storeController.categoryList!.isNotEmpty)
                                  ? SliverPersistentHeader(
                                      pinned: true,
                                      delegate: SliverDelegate(
                                        height: 90,
                                        child: Center(
                                          child: Container(
                                            width: Dimensions.webMaxWidth,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .paddingSizeExtraSmall,
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: Dimensions
                                                        .paddingSizeSmall,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'items'.tr,
                                                        style:
                                                            robotoBold.copyWith(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      const Expanded(
                                                        child: SizedBox(),
                                                      ),
                                                      if (storeController
                                                          .type.isNotEmpty)
                                                        VegFilterWidget(
                                                          type: storeController
                                                              .type,
                                                          onSelected: (
                                                            String type,
                                                          ) {
                                                            storeController
                                                                .getStoreItemList(
                                                              storeController
                                                                  .store!.id,
                                                              1,
                                                              type,
                                                              true,
                                                            );
                                                          },
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeSmall,
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: storeController
                                                        .categoryList!.length,
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: Dimensions
                                                          .paddingSizeSmall,
                                                    ),
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      final isSelected = index ==
                                                          storeController
                                                              .categoryIndex;
                                                      return InkWell(
                                                        onTap: () =>
                                                            storeController
                                                                .setCategoryIndex(
                                                          index,
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: 10,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: isSelected
                                                                  ? context
                                                                      .color
                                                                      .secondary
                                                                  : context
                                                                      .color
                                                                      .lightText,
                                                            ),
                                                            color: isSelected
                                                                ? context.color
                                                                    .secondary
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              20,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 22,
                                                          ),
                                                          child: Text(
                                                            storeController
                                                                .categoryList![
                                                                    index]
                                                                .name!,
                                                            style: context
                                                                .style.s14w700
                                                                .copyWith(
                                                              color: isSelected
                                                                  ? context
                                                                      .color
                                                                      .white
                                                                  : context
                                                                      .color
                                                                      .darkTextGrey,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SliverToBoxAdapter(
                                      child: SizedBox(),
                                    ),

                          if (!ResponsiveHelper.isDesktop(context))
                            SliverToBoxAdapter(
                              child: Container(
                                width: Dimensions.webMaxWidth,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                child: PaginatedListView(
                                  scrollController: scrollController,
                                  onPaginate: (int? offset) =>
                                      storeController.getStoreItemList(
                                    widget.store!.id ??
                                        storeController.store!.id,
                                    offset!,
                                    storeController.type,
                                    false,
                                  ),
                                  totalSize:
                                      storeController.storeItemModel?.totalSize,
                                  offset:
                                      storeController.storeItemModel?.offset,
                                  itemView: ItemsView(
                                    isStore: false,
                                    stores: null,
                                    items: (storeController
                                                .categoryList!.isNotEmpty &&
                                            storeController.storeItemModel !=
                                                null)
                                        ? storeController.storeItemModel!.items
                                        : null,
                                    inStorePage: true,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeSmall,
                                      vertical: Dimensions.paddingSizeSmall,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ],
                    )
                  : const StoreDetailsScreenShimmerWidget();
            },
          );
        },
      ),
      floatingActionButton: GetBuilder<StoreController>(
        builder: (storeController) {
          return Visibility(
            visible: storeController.showFavButton &&
                Get.find<SplashController>()
                    .configModel!
                    .moduleConfig!
                    .module!
                    .orderAttachment! &&
                (storeController.store != null &&
                    storeController.store!.prescriptionOrder!) &&
                Get.find<SplashController>().configModel!.prescriptionStatus! &&
                AuthHelper.isLoggedIn(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                boxShadow: [
                  BoxShadow(
                    color: context.color.secondary.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    width: storeController.currentState == true
                        ? 0
                        : ResponsiveHelper.isDesktop(context)
                            ? 180
                            : 150,
                    height: 30,
                    curve: Curves.linear,
                    child: Center(
                      child: Text(
                        'prescription_order'.tr,
                        textAlign: TextAlign.center,
                        style: robotoMedium.copyWith(
                          color: context.color.secondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 120,
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(
                      RouteHelper.getCheckoutRoute(
                        'prescription',
                        storeId: storeController.store!.id,
                      ),
                      arguments: CheckoutScreen(
                        fromCart: false,
                        cartList: null,
                        storeId: storeController.store!.id,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.color.secondary,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                      ),
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Image.asset(
                        Images.prescriptionIcon,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: storeController.isFromBookTable
          ? GetBuilder<StoreController>(
              builder: (storeController) {
                return storeController.store != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.appPadding,
                          vertical: 10,
                        ).copyWith(
                          bottom: MediaQuery.paddingOf(context).bottom / 1.5,
                        ),
                        child: AppButton(
                          buttonText: 'Book Slot',
                          onPressed: () {
                            Get.toNamed(RouteHelper.getReservationScreen());
                          },
                        ),
                      )
                    : const SizedBox();
              },
            )
          : GetBuilder<CartController>(
              builder: (cartController) {
                return cartController.cartList.isNotEmpty &&
                        !ResponsiveHelper.isDesktop(context) &&
                        !storeController.isFromBookTable
                    ? GetBuilder<StoreController>(
                        builder: (storeController) {
                          return BottomCartWidget(
                            fromQr: widget.fromQr,
                            storeId: storeController.store?.id,
                          );
                        },
                      )
                    : const SizedBox();
              },
            ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  SliverDelegate({required this.child, this.height = 100});
  Widget child;
  double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height ||
        oldDelegate.minExtent != height ||
        child != oldDelegate.child;
  }
}

class CategoryProduct {
  CategoryProduct(this.category, this.products);
  CategoryModel category;
  List<Item> products;
}
