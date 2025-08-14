import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/provider/home_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/restaurant_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/widget/category_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/widget/sort_by_screen.dart';
import 'package:scan_sa_user/app/widgets/address_widget.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/cache_image_network.dart';
import 'package:scan_sa_user/app/widgets/restaurants_widget.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';
import 'package:scan_sa_user/helper/get_it_hook.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class HomeScreen extends GetItHook<HomeController> {
  HomeScreen({
    super.key,
    required super.controller,
    this.isPickupScreen = false,
    this.isSlotScreen = false,
  });

  final pageController = PageController();
  final bannerPageIndex = ValueNotifier(0);
  final foodGradient = [const Color(0xFFF5BE01), const Color(0xFFF5A401)];
  final pickupGradient = [const Color(0xFFCAFFDD), const Color(0xFF65C8A0)];
  final slotGradient = [const Color(0xFF4744A1), const Color(0xFF151444)];
  final foodColor = const Color(0xFFF5A401);
  final pickupColor = const Color(0xFF65C8A0);
  final slotColor = const Color(0xFF151444);
  final bool isPickupScreen;
  final bool isSlotScreen;
  final refreshController = RefreshController();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    '===>> isSlotScreen $isSlotScreen'.print;
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        header: const MaterialClassicHeader(),
        onRefresh: () {
          controller
              .getData(isHomeLoad: true)
              .then((value) => refreshController.refreshCompleted());
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: context.color.white,
              leading: const SizedBox.shrink(),
              leadingWidth: 0,
              expandedHeight: isSlotScreen ? 310.h : 350.h,
              pinned: true,
              elevation: 0.5,
              toolbarHeight: 70,
              foregroundColor: context.color.secondary,
              surfaceTintColor: context.color.secondary,
              flexibleSpace: FlexibleSpaceBar(
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
                            colors: isPickupScreen
                                ? pickupGradient
                                : isSlotScreen
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
                                color: isPickupScreen
                                    ? pickupColor
                                    : isSlotScreen
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
                                color: isPickupScreen
                                    ? pickupColor
                                    : isSlotScreen
                                    ? slotColor
                                    : foodColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.appPadding,
                          vertical: AppSizes.appPadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            searchWidget(context),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    isPickupScreen
                                        ? context.l10n.easilyOrder
                                        : isSlotScreen
                                        ? context.l10n.reserveYour
                                        : context.l10n.orderNowAnything,
                                    style: TextStyle(
                                      fontSize: 26.sp,
                                      color: isPickupScreen
                                          ? context.color.ff093624
                                          : isSlotScreen
                                          ? Colors.white
                                          : context.color.ff6A2100,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    isPickupScreen
                                        ? AppIcons.pickupImg
                                        : isSlotScreen
                                        ? AppIcons.slotImg
                                        : AppIcons.foodImg,
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
                    child: AddressWidget(
                      color: isSlotScreen && scrollingRate < .99
                          ? Colors.white
                          : null,
                      isSearchButton: scrollingRate >= .99,
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  final bannerList = controller.bannerImageList.value ?? [];
                  // final bannerDataList = controller.bannerDataList.value ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      if (controller.isBannerLoad ||
                          (controller.bannerDataList.value?.isNotEmpty ??
                              false))
                        Container(
                          height: 170,
                          margin: const EdgeInsets.only(top: 16),
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: controller.isBannerLoad
                                ? 1
                                : bannerList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.appPadding,
                                ),
                                child: GestureDetector(
                                  child:
                                      CacheImageNetwork(
                                        controller.isBannerLoad
                                            ? ''
                                            : bannerList[index] ?? '',
                                        radius: 20,
                                      ).shimmer(
                                        context,
                                        isLoad: controller.isBannerLoad,
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (controller.isBannerLoad ||
                          (controller.bannerDataList.value?.isNotEmpty ??
                              false))
                        ValueListenableBuilder(
                          valueListenable: bannerPageIndex,
                          builder: (context, bannerPageIndex, child) {
                            return SizedBox(
                              height: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 4,
                                children: List.generate(bannerList.length, (
                                  index,
                                ) {
                                  final isSelected = bannerPageIndex == index;
                                  return CircleAvatar(
                                    radius: isSelected ? 4 : 2,
                                    backgroundColor: isSelected
                                        ? context.color.primary
                                        : context.color.ff9c9c9c,
                                  );
                                }),
                              ),
                            );
                          },
                        ),

                      /// category widget
                      const CategoryWidget(),
                      GestureDetector(
                        onTap: () => showSortBySheet(context),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: AppSizes.appPadding,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFF5F5F5),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 7,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 7,
                            children: [
                              Text(
                                context.l10n.sortBy,
                                style: context.style.s16w700.copyWith(
                                  color: context.color.ff455A64,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: SvgAssets(AppIcons.arrowBottomIc),
                              ),
                            ],
                          ),
                        ),
                      ),

                      GetBuilder<HomeController>(
                        builder: (controller) {
                          return controller.storeList.isEmpty &&
                                  !controller.isStoreLoad
                              ? const SizedBox(
                                  height: 160,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text('No restaurant found'),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppSizes.appPadding,
                                      ),
                                      child: Text(
                                        context.l10n.restaurant,
                                        style: context.style.s24w900,
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount: controller.isStoreLoad
                                          ? 5
                                          : controller.storeList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppSizes.appPadding,
                                        vertical: 12,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final store = controller.isStoreLoad
                                            ? null
                                            : controller.storeList[index];
                                        return RestaurantsWidget(
                                          index: index,
                                          store: store,
                                          isReservation: isSlotScreen,
                                        );
                                      },
                                    ),
                                  ],
                                );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => AppPages.searchScreen.push(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: context.color.whiteLight,
          border: Border.all(color: context.color.borderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          spacing: 10,
          children: [
            SvgAssets(AppIcons.searchBarIc, width: 20),
            Text(
              'Search in food',
              style: context.style.s16w700.copyWith(
                color: context.color.ff9c9c9c,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get canDisposeController => true;

  @override
  void onDispose() {}

  @override
  void onInit() {
    controller.getData(
      isLoad: true,
      isPickupScreen: isPickupScreen,
      isSlotScreen: isSlotScreen,
    );

    pageController.addListener(
      () => bannerPageIndex.value = pageController.page?.toInt() ?? 0,
    );
  }
}
