import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:scan_sa_user/common/controllers/theme_controller.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/features/banner/controllers/banner_controller.dart';
import 'package:scan_sa_user/features/home/controllers/advertisement_controller.dart';
import 'package:scan_sa_user/features/home/controllers/home_controller.dart';
import 'package:scan_sa_user/features/home/widgets/address_widget.dart';
import 'package:scan_sa_user/features/home/widgets/all_store_filter_widget.dart';
import 'package:scan_sa_user/features/home/widgets/cashback_logo_widget.dart';
import 'package:scan_sa_user/features/home/widgets/cashback_dialog_widget.dart';
import 'package:scan_sa_user/features/home/widgets/refer_bottom_sheet_widget.dart';
import 'package:scan_sa_user/features/item/controllers/campaign_controller.dart';
import 'package:scan_sa_user/features/category/controllers/category_controller.dart';
import 'package:scan_sa_user/features/coupon/controllers/coupon_controller.dart';
import 'package:scan_sa_user/features/location/controllers/location_controller.dart';
import 'package:scan_sa_user/features/notification/controllers/notification_controller.dart';
import 'package:scan_sa_user/features/item/controllers/item_controller.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/profile/controllers/profile_controller.dart';
import 'package:scan_sa_user/features/address/controllers/address_controller.dart';
import 'package:scan_sa_user/features/home/screens/modules/food_home_screen.dart';
import 'package:scan_sa_user/features/store/widgets/customizable_space_bar_widget.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/app_constants.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/common/widgets/item_view.dart';
import 'package:scan_sa_user/common/widgets/menu_drawer.dart';
import 'package:scan_sa_user/common/widgets/paginated_list_view.dart';
import 'package:scan_sa_user/common/widgets/web_menu_bar.dart';
import 'package:scan_sa_user/features/home/screens/web_new_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/home/widgets/module_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.fromBookTable = false});
  final bool fromBookTable;

  static Future<void> loadData(
    bool reload, {
    bool fromModule = false,
  }) async {
    final fromBookTable = Get.find<HomeController>().isFromBookTable;
    Get.find<LocationController>().syncZoneData();
    Get.find<SplashController>().getModules();
    if (AuthHelper.isLoggedIn()) {
      Get.find<StoreController>()
          .getVisitAgainStoreList(fromModule: fromModule);
    }
    if (Get.find<SplashController>().module != null &&
        !Get.find<SplashController>()
            .configModel!
            .moduleConfig!
            .module!
            .isParcel! &&
        !Get.find<SplashController>()
            .configModel!
            .moduleConfig!
            .module!
            .isTaxi!) {
      if (!fromBookTable) {
        Get.find<BannerController>().getBannerList(reload);

        Get.find<BannerController>().getPromotionalBannerList(reload);
        Get.find<ItemController>().getDiscountedItemList(reload, false, 'all');
        Get.find<CampaignController>().getBasicCampaignList(reload);
        Get.find<CampaignController>().getItemCampaignList(reload);
        Get.find<ItemController>().getPopularItemList(reload, 'all', false);
        Get.find<ItemController>().getReviewedItemList(reload, 'all', false);
        Get.find<AdvertisementController>().getAdvertisementList();
        Get.find<ItemController>().getRecommendedItemList(reload, 'all', false);
      }
      Get.find<StoreController>().getStoreList(1, reload);
      Get.find<StoreController>().getRecommendedStoreList();
      Get.find<CategoryController>().getCategoryList(reload);
      // Get.find<StoreController>().getTopOfferStoreList(reload, false);
      Get.find<StoreController>().getPopularStoreList(reload, 'all', false);
      Get.find<StoreController>().getLatestStoreList(reload, 'all', false);
    }
    if (AuthHelper.isLoggedIn()) {
      // Get.find<StoreController>().getVisitAgainStoreList(fromModule: fromModule);
      await Get.find<ProfileController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
      Get.find<CouponController>().getCouponList();
    }
    if (Get.find<SplashController>().module == null &&
        Get.find<SplashController>().configModel!.module == null) {
      if (!fromBookTable) {
        Get.find<BannerController>().getFeaturedBanner();
      }
      Get.find<StoreController>().getFeaturedStoreList();
      if (AuthHelper.isLoggedIn()) {
        Get.find<AddressController>().getAddressList();
      }
    }

    if (Get.find<SplashController>().module != null &&
        Get.find<SplashController>().module!.moduleType.toString() ==
            AppConstants.pharmacy) {
      Get.find<StoreController>().getFeaturedStoreList();
      if (!fromBookTable) {
        await Get.find<ItemController>().getCommonConditions(false);
        if (Get.find<ItemController>().commonConditions!.isNotEmpty) {
          Get.find<ItemController>().getConditionsWiseItem(
            Get.find<ItemController>().commonConditions![0].id!,
            false,
          );
        }
      }
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool searchBgShow = false;
  final GlobalKey _headerKey = GlobalKey();

  final foodGradient = [const Color(0xFFF5BE01), const Color(0xFFF5A401)];
  // final slotGradient = [const Color(0xFF4744A1), const Color(0xFF151444)];
  final slotGradient = [const Color(0xFFCAFFDD), const Color(0xFF65C8A0)];

  final foodColor = const Color(0xFFF5A401);
  final slotColor = const Color(0xFF65C8A0);

  @override
  void initState() {
    super.initState();
    Get.find<StoreController>().isFromBookTable = widget.fromBookTable;
    Get.find<HomeController>().isFromBookTable = widget.fromBookTable;
    HomeScreen.loadData(
      false,
    ).then((value) {
      Get.find<SplashController>().getReferBottomSheetStatus();

      if ((Get.find<ProfileController>().userInfoModel?.isValidForDiscount ??
              false) &&
          Get.find<SplashController>().showReferBottomSheet) {
        _showReferBottomSheet();
      }
    });

    if (!ResponsiveHelper.isWeb()) {
      Get.find<LocationController>().getZone(
        AddressHelper.getUserAddressFromSharedPref()!.latitude,
        AddressHelper.getUserAddressFromSharedPref()!.longitude,
        false,
        updateInAddress: true,
      );
    }

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (Get.find<HomeController>().showFavButton) {
          Get.find<HomeController>().changeFavVisibility();
          Future.delayed(
            const Duration(milliseconds: 800),
            () => Get.find<HomeController>().changeFavVisibility(),
          );
        }
      } else {
        if (Get.find<HomeController>().showFavButton) {
          Get.find<HomeController>().changeFavVisibility();
          Future.delayed(
            const Duration(milliseconds: 800),
            () => Get.find<HomeController>().changeFavVisibility(),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _showReferBottomSheet() {
    ResponsiveHelper.isDesktop(context)
        ? Get.dialog(
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.radiusExtraLarge),
              ),
              insetPadding: const EdgeInsets.all(22),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: const ReferBottomSheetWidget(),
            ),
            useSafeArea: false,
          ).then(
            (value) =>
                Get.find<SplashController>().saveReferBottomSheetStatus(false),
          )
        : showModalBottomSheet(
            isScrollControlled: true,
            useRootNavigator: true,
            context: Get.context!,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusExtraLarge),
                topRight: Radius.circular(Dimensions.radiusExtraLarge),
              ),
            ),
            builder: (context) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: const ReferBottomSheetWidget(),
              );
            },
          ).then(
            (value) =>
                Get.find<SplashController>().saveReferBottomSheetStatus(false),
          );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splashController) {
        if (splashController.moduleList != null &&
            splashController.moduleList!.length == 1) {
          splashController.switchModule(0, true);
        }
        bool showMobileModule = !ResponsiveHelper.isDesktop(context) &&
            splashController.module == null &&
            splashController.configModel!.module == null;
        return GetBuilder<HomeController>(
          builder: (homeController) {
            return Scaffold(
              appBar: ResponsiveHelper.isDesktop(context)
                  ? const WebMenuBar()
                  : null,
              endDrawer: ResponsiveHelper.isDesktop(context)
                  ? const MenuDrawer()
                  : null,
              endDrawerEnableOpenDragGesture: false,
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: RefreshIndicator(
                onRefresh: () async {
                  splashController.setRefreshing(true);
                  if (Get.find<SplashController>().module != null) {
                    await Get.find<LocationController>().syncZoneData();
                    await Get.find<CategoryController>().getCategoryList(true);
                    await Get.find<StoreController>()
                        .getPopularStoreList(true, 'all', false);
                    if (!widget.fromBookTable) {
                      await Get.find<BannerController>().getBannerList(true);
                      await Get.find<BannerController>()
                          .getPromotionalBannerList(true);
                      await Get.find<ItemController>()
                          .getDiscountedItemList(true, false, 'all');
                      await Get.find<CampaignController>()
                          .getItemCampaignList(true);
                      Get.find<CampaignController>().getBasicCampaignList(true);
                      await Get.find<ItemController>()
                          .getPopularItemList(true, 'all', false);
                    }
                    await Get.find<StoreController>()
                        .getLatestStoreList(true, 'all', false);
                    // await Get.find<StoreController>()
                    //     .getTopOfferStoreList(true, false);
                    await Get.find<StoreController>().getStoreList(1, true);
                    if (AuthHelper.isLoggedIn()) {
                      await Get.find<ProfileController>().getUserInfo();
                      await Get.find<NotificationController>()
                          .getNotificationList(true);
                      Get.find<CouponController>().getCouponList();
                    }
                    if (!widget.fromBookTable) {
                      await Get.find<ItemController>()
                          .getReviewedItemList(true, 'all', false);
                      Get.find<AdvertisementController>()
                          .getAdvertisementList();
                    }
                  } else {
                    if (!widget.fromBookTable) {
                      await Get.find<BannerController>().getFeaturedBanner();
                    }
                    await Get.find<SplashController>().getModules();
                    if (AuthHelper.isLoggedIn()) {
                      await Get.find<AddressController>().getAddressList();
                    }
                    await Get.find<StoreController>().getFeaturedStoreList();
                  }
                  splashController.setRefreshing(false);
                },
                child: ResponsiveHelper.isDesktop(context)
                    ? WebNewHomeScreen(
                        scrollController: _scrollController,
                      )
                    : CustomScrollView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            backgroundColor: showMobileModule
                                ? const Color.fromARGB(255, 253, 226, 137)
                                : context.color.white,
                            leading: const SizedBox.shrink(),
                            leadingWidth: 0,
                            expandedHeight: showMobileModule
                                ? 50
                                : widget.fromBookTable
                                    ? 340
                                    : 330,
                            pinned: !showMobileModule,
                            elevation: 0.5,
                            toolbarHeight: 70,
                            foregroundColor: context.color.primary,
                            surfaceTintColor: context.color.primary,
                            flexibleSpace: showMobileModule
                                ? null
                                : FlexibleSpaceBar(
                                    background: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: widget.fromBookTable
                                                    ? slotGradient
                                                    : foodGradient,
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            child: Container(
                                              width: 10,
                                              height: 310,
                                              decoration: BoxDecoration(
                                                // color: Color.fromARGB(255, 245, 1, 1),
                                                boxShadow: [
                                                  BoxShadow(
                                                    // blurStyle: BlurStyle.outer,
                                                    blurRadius: 40,
                                                    spreadRadius: 40,
                                                    color: widget.fromBookTable
                                                        ? slotColor
                                                        : foodColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                              width: 10,
                                              height: 350,
                                              decoration: BoxDecoration(
                                                // color: Color.fromARGB(255, 245, 1, 1),
                                                boxShadow: [
                                                  BoxShadow(
                                                    // blurStyle: BlurStyle.outer,
                                                    blurRadius: 40,
                                                    spreadRadius: 40,
                                                    color: widget.fromBookTable
                                                        ? slotColor
                                                        : foodColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (!showMobileModule)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: AppSizes.appPadding,
                                                vertical: AppSizes.appPadding,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                spacing: widget.fromBookTable
                                                    ? 15
                                                    : 20,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width:
                                                        Dimensions.webMaxWidth,
                                                    color: searchBgShow
                                                        ? Get.find<ThemeController>()
                                                                .darkTheme
                                                            ? Theme.of(
                                                                context,
                                                              )
                                                                .colorScheme
                                                                .surface
                                                            : Theme.of(
                                                                context,
                                                              ).cardColor
                                                        : null,
                                                    // padding:
                                                    //     const EdgeInsets.symmetric(
                                                    //   horizontal: Dimensions
                                                    //       .paddingSizeSmall,
                                                    // ),
                                                    child: InkWell(
                                                      onTap: () => Get.toNamed(
                                                        RouteHelper
                                                            .getSearchRoute(
                                                          fromBookTable: widget
                                                              .fromBookTable,
                                                        ),
                                                      ),
                                                      child: Container(
                                                        // margin:
                                                        //     const EdgeInsets.only(
                                                        //   bottom: 4,
                                                        // ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: context
                                                              .color.whiteLight,
                                                          border: Border.all(
                                                            color: context.color
                                                                .borderColor,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            10,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          spacing: 10,
                                                          children: [
                                                            SvgAssets(
                                                              Images
                                                                  .searchBarIc,
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Search in food',
                                                              style: context
                                                                  .style.s16w700
                                                                  .copyWith(
                                                                color: context
                                                                    .color
                                                                    .darkTextGrey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          widget.fromBookTable
                                                              ? 'EASILY ORDER & PICKUP YOUR TREAT'
                                                              : 'ORDER NOW ANYTHING YOU WANT!',
                                                          style: TextStyle(
                                                            fontSize: 26,
                                                            color: widget
                                                                    .fromBookTable
                                                                ? const Color(
                                                                    0xFF093624,
                                                                  )
                                                                : const Color(
                                                                    0xFF632204,
                                                                  ),
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Image.asset(
                                                          widget.fromBookTable
                                                              ? Images
                                                                  .homeBookTableIc
                                                              : Images
                                                                  .homeScreenIc,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                            title: CustomizableSpaceBarWidget(
                              builder: (context, scrollingRate) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: HomeAddressWidget(
                                    fromBookTable: widget.fromBookTable,
                                    splashController: splashController,
                                    isSearchButton: scrollingRate >= .99,
                                  ),
                                );
                              },
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              return SliverToBoxAdapter(
                                child: Center(
                                  child: SizedBox(
                                    width: Dimensions.webMaxWidth,
                                    child: !showMobileModule
                                        ? FoodHomeScreen(
                                            fromBookTable: widget.fromBookTable,
                                          )
                                        : Stack(
                                            children: [
                                              if (!ResponsiveHelper.isDesktop(
                                                context,
                                              ))
                                                Container(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          .4,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        const Color.fromARGB(
                                                          255,
                                                          253,
                                                          226,
                                                          137,
                                                        ),
                                                        Colors.white.withValues(
                                                          alpha: 0,
                                                        ),
                                                      ],
                                                      end: Alignment
                                                          .bottomCenter,
                                                      begin:
                                                          Alignment.topCenter,
                                                    ),
                                                  ),
                                                ),
                                              ModuleView(
                                                splashController:
                                                    splashController,
                                                fromBookTable:
                                                    widget.fromBookTable,
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                          if (!showMobileModule)
                            SliverPersistentHeader(
                              key: _headerKey,
                              pinned: true,
                              delegate: SliverDelegate(
                                height: 85,
                                callback: (val) {
                                  searchBgShow = val;
                                },
                                child: const AllStoreFilterWidget(),
                              ),
                            ),
                          if (!showMobileModule)
                            SliverToBoxAdapter(
                              child: Center(
                                child: GetBuilder<StoreController>(
                                  builder: (storeController) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom: ResponsiveHelper.isDesktop(
                                          context,
                                        )
                                            ? 0
                                            : 100,
                                      ),
                                      child: PaginatedListView(
                                        scrollController: _scrollController,
                                        totalSize: storeController
                                            .storeModel?.totalSize,
                                        offset:
                                            storeController.storeModel?.offset,
                                        onPaginate: (int? offset) async =>
                                            storeController.getStoreList(
                                          offset!,
                                          false,
                                        ),
                                        itemView: ItemsView(
                                          isStore: true,
                                          items: null,
                                          stores: storeController
                                              .storeModel?.stores,
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveHelper.isDesktop(
                                              context,
                                            )
                                                    ? Dimensions
                                                        .paddingSizeExtraSmall
                                                    : Dimensions
                                                        .paddingSizeSmall,
                                            vertical:
                                                ResponsiveHelper.isDesktop(
                                              context,
                                            )
                                                    ? Dimensions
                                                        .paddingSizeExtraSmall
                                                    : Dimensions
                                                        .paddingSizeDefault,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
              floatingActionButton: AuthHelper.isLoggedIn() &&
                      homeController.cashBackOfferList != null &&
                      homeController.cashBackOfferList!.isNotEmpty
                  ? homeController.showFavButton
                      ? Padding(
                          padding: EdgeInsets.only(
                            bottom: 50.0,
                            right: ResponsiveHelper.isDesktop(context) ? 50 : 0,
                          ),
                          child: InkWell(
                            onTap: () =>
                                Get.dialog(const CashBackDialogWidget()),
                            child: const CashBackLogoWidget(),
                          ),
                        )
                      : null
                  : null,
            );
          },
        );
      },
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  SliverDelegate({required this.child, this.height = 50, this.callback});
  Widget child;
  double height;
  Function(bool isPinned)? callback;
  bool isPinned = false;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    isPinned = shrinkOffset == maxExtent /*|| shrinkOffset < maxExtent*/;
    callback!(isPinned);
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
