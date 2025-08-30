import 'package:scan_sa_user/features/banner/controllers/banner_controller.dart';
import 'package:scan_sa_user/features/home/widgets/all_store_filter_widget.dart';
import 'package:scan_sa_user/features/item/controllers/campaign_controller.dart';
import 'package:scan_sa_user/features/category/controllers/category_controller.dart';
import 'package:scan_sa_user/features/location/controllers/location_controller.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/home/widgets/web/module_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_best_review_item_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_best_store_nearby_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_category_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_item_that_you_love_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_just_for_you_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_most_popular_item_banner_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_most_popular_item_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_new_banner_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_new_on_mart_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_new_on_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_promotional_banner_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_special_offer_view_widget.dart';
import 'package:scan_sa_user/features/home/widgets/web/web_visit_again_view_widget.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/util/app_constants.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/common/widgets/footer_view.dart';
import 'package:scan_sa_user/common/widgets/item_view.dart';
import 'package:scan_sa_user/common/widgets/paginated_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebNewHomeScreen extends StatefulWidget {
  const WebNewHomeScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<WebNewHomeScreen> createState() => _WebNewHomeScreenState();
}

class _WebNewHomeScreenState extends State<WebNewHomeScreen> {
  late bool _isLogin;
  bool active = false;

  @override
  void initState() {
    super.initState();
    _isLogin = AuthHelper.isLoggedIn();
    Get.find<SplashController>().getWebSuggestedLocationStatus();

    if (_isLogin) {
      suggestAddressBottomSheet();
    }
  }

  Future<void> suggestAddressBottomSheet() async {
    active = await Get.find<LocationController>().checkLocationActive();
    if (!Get.find<SplashController>().webSuggestedLocation && active) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.dialog(
          const Center(
            child: SizedBox(
              height: 470,
              width: 550,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFood = Get.find<SplashController>().module != null &&
        Get.find<SplashController>().module!.moduleType.toString() ==
            AppConstants.food;
    Get.find<BannerController>().setCurrentIndex(0, false);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(height: context.height),
        CustomScrollView(
          controller: widget.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: GetBuilder<BannerController>(
                              builder: (bannerController) {
                                return bannerController.bannerImageList == null
                                    ? const WebNewBannerViewWidget(
                                        isFeatured: false,
                                      )
                                    : bannerController.bannerImageList!.isEmpty
                                        ? const SizedBox()
                                        : const WebNewBannerViewWidget(
                                            isFeatured: false,
                                          );
                              },
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeDefault),
                        ],
                      ),

                      // const BadWeatherWidget(),
                      GetBuilder<CategoryController>(
                        builder: (categoryController) {
                          return categoryController.categoryList == null
                              ? WebCategoryViewWidget(
                                  categoryController: categoryController,
                                )
                              : categoryController.categoryList!.isEmpty
                                  ? const SizedBox()
                                  : WebCategoryViewWidget(
                                      categoryController: categoryController,
                                    );
                        },
                      ),

                      _isLogin
                          ? WebVisitAgainView(fromFood: isFood)
                          : const SizedBox(),

                      const WebSpecialOfferView(
                        isFood: false,
                        isShop: false,
                      ),

                      // const WebHighlightWidget(),

                      isFood
                          ? const WebBestReviewItemViewWidget()
                          : const WebBestStoreNearbyViewWidget(),

                      isFood
                          ? const WebNewOnViewWidget(isFood: true)
                          : const WebMostPopularItemViewWidget(
                              isFood: false,
                              isShop: false,
                            ),

                      isFood
                          ? const WebItemThatYouLoveViewWidget()
                          : GetBuilder<CampaignController>(
                              builder: (campaignController) {
                                return campaignController.basicCampaignList ==
                                        null
                                    ? WebMostPopularItemBannerViewWidget(
                                        campaignController: campaignController,
                                      )
                                    : campaignController
                                            .basicCampaignList!.isEmpty
                                        ? const SizedBox()
                                        : WebMostPopularItemBannerViewWidget(
                                            campaignController:
                                                campaignController,
                                          );
                              },
                            ),

                      isFood
                          ? const WebMostPopularItemViewWidget(
                              isFood: true,
                              isShop: false,
                            )
                          : const WebBestReviewItemViewWidget(),

                      isFood
                          ? const WebJustForYouViewWidget()
                          : const SizedBox(),

                      // WebTopOffersNearMe(
                      //   isFood: isFood,
                      // ),

                      isFood
                          ? const WebNewOnMartViewWidget()
                          : const WebJustForYouViewWidget(),

                      isFood
                          ? const SizedBox()
                          : const WebPromotionalBannerView(),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverDelegate(
                height: 85,
                child: const AllStoreFilterWidget(),
              ),
            ),
            SliverToBoxAdapter(
              child: GetBuilder<StoreController>(
                builder: (storeController) {
                  return FooterView(
                    child: SizedBox(
                      width: Dimensions.webMaxWidth,
                      child: PaginatedListView(
                        scrollController: widget.scrollController,
                        totalSize: storeController.storeModel?.totalSize,
                        offset: storeController.storeModel?.offset,
                        onPaginate: (int? offset) async =>
                            storeController.getStoreList(offset!, false),
                        itemView: ItemsView(
                          isStore: true,
                          items: null,
                          stores: storeController.storeModel?.stores,
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.isDesktop(context)
                                ? Dimensions.paddingSizeExtraSmall
                                : Dimensions.paddingSizeSmall,
                            vertical: ResponsiveHelper.isDesktop(context)
                                ? Dimensions.paddingSizeExtraSmall
                                : 0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Center(child: ModuleWidget()),
        ),
      ],
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  SliverDelegate({required this.child, this.height = 50});
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
