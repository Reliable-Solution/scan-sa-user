import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/controller/restaurant_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/screens/restaurant_reservation_screen.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/cache_image_network.dart';
import 'package:scan_sa_user/app/widgets/circular_btn.dart';
import 'package:scan_sa_user/app/widgets/item_card_widgets/items_widget.dart';
import 'package:scan_sa_user/app/widgets/restaurants_widget.dart';
import 'package:scan_sa_user/app/widgets/widget_padding.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({
    super.key,
    required this.index,
    required this.store,
    this.isReservation = false,
  });
  final int index;
  final Store store;
  final bool isReservation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: IntrinsicHeight(
        child: isReservation
            ? AppButton(
                label: 'Reserve slot',
                isBottomPad: true,
                onPressed: () => AppPages.reservationScreen.push(),
              )
            : GetBuilder<CartController>(
                builder: (controller) => controller.cartList.isNotEmpty
                    ? GestureDetector(
                        onTap: () => AppPages.restaurantCartScreen.push(
                          arguments: Get.arguments is bool
                              ? Get.arguments
                              : null,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.color.greenColor,
                          ),
                          height: 55.h,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: AppPadding.bottomPad(
                            context,
                          ).add(const EdgeInsets.only(bottom: 10)),
                          child: Row(
                            spacing: 4,
                            children: [
                              Text(
                                '${controller.cartList.length} ${context.l10n.itemsAdded}',
                                style: context.style.s18w700.copyWith(
                                  color: context.color.white,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                context.l10n.viewCart,
                                style: context.style.s18w700.copyWith(
                                  color: context.color.white,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: context.color.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
      ),
      body: GetBuilder<RestaurantController>(
        builder: (controller) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 310,
                    pinned: true,
                    elevation: 0.5,
                    leadingWidth: AppSizes.appPadding + 40,
                    // backgroundColor: Colors.black26,
                    leading: Padding(
                      padding: EdgeInsets.only(left: AppSizes.appPadding),
                      child: Row(
                        children: [
                          BackBtn(
                            btnColor: context.color.white,
                            iconColor: context.color.primary,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      CircularBtn(icon: AppIcons.searchIc, onTap: Get.back),
                      Padding(
                        padding: EdgeInsets.only(
                          right: AppSizes.appPadding,
                          left: 10,
                        ),
                        child: CircleAvatar(
                          backgroundColor: context.color.white,
                          child: FavoriteIcon(
                            storeId: store.id ?? 0,
                            isLoad: false,
                          ),
                        ),
                      ),
                    ],
                    flexibleSpace: CustomizableSpaceBarWidget(
                      builder: (context, scrollingRate) {
                        return FlexibleSpaceBar(
                          // titlePadding: const EdgeInsets.only(top: 80),
                          centerTitle: scrollingRate != 1,
                          expandedTitleScale: 1.1,
                          background: Column(
                            children: [
                              Flexible(
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Column(
                                      children: [
                                        Flexible(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    35,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    35,
                                                  ),
                                                ),
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Hero(
                                                  tag:
                                                      '${store.logoFullUrl}$index',
                                                  child: CacheImageNetwork(
                                                    store.logoFullUrl ?? '',
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                  ),
                                                ),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                        gradient: LinearGradient(
                                                          colors: [
                                                            Colors.transparent,
                                                            Colors.black,
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                  height: 100,
                                                  width: double.infinity,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox.square(dimension: 50),
                                      ],
                                    ),
                                    Container(
                                      height: 100,
                                      width: 100,
                                      // margin: const EdgeInsets.only(bottom: 50),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: context.color.white,
                                        border: Border.all(
                                          color: context.color.grey,
                                          width: 2,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(14),
                                      child: ClipOval(
                                        child: CacheImageNetwork(
                                          store.logoFullUrl ?? '',
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
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
                          title: SizedBox(
                            width: scrollingRate == 1
                                ? MediaQuery.sizeOf(context).width / 2
                                : MediaQuery.sizeOf(context).width -
                                      (AppSizes.appPadding * 2),
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
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isReservation ? 0 : 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          detailWidget(
                            context,
                            icon: AppIcons.thumbIc,
                            desc: '${store.avgRating} (${store.ratingCount})',
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
                              icon: AppIcons.locationFillIc,
                              desc: store.address ?? '',
                            ),
                          ),
                          detailWidget(
                            context,
                            icon: AppIcons.clockIc,
                            desc: store.deliveryTime ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!isReservation)
                    if (controller.storeItemModel?.items?.isNotEmpty ?? false)
                      PinnedHeaderSliver(
                        child: Container(
                          color: context.color.white,
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categoryList.length,
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.appPadding,
                            ).copyWith(top: 15, bottom: 10),
                            itemBuilder: (context, index) {
                              final cat = controller.categoryList[index];
                              return Obx(() {
                                final isSelected =
                                    controller.selectedCat.value == index;
                                return GestureDetector(
                                  onTap: () => controller.selectCategory(index),
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isSelected
                                            ? context.color.primary
                                            : context.color.lightText,
                                      ),
                                      color: isSelected
                                          ? context.color.primary
                                          : null,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                    ),
                                    child: Text(
                                      cat.name ?? '',
                                      style: context.style.s16w700.copyWith(
                                        color: isSelected
                                            ? context.color.white
                                            : context.color.ff455A64,
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      )
                    else
                      const SliverToBoxAdapter()
                  else
                    const SliverToBoxAdapter(
                      child: RestaurantReservationScreen(),
                    ),
                  if ((!isReservation &&
                          (controller.storeItemModel?.items?.isNotEmpty ??
                              false)) ||
                      controller.isItemLoad)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.appPadding,
                          vertical: 4,
                        ).copyWith(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.items,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.style.s22w700,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller.isItemLoad
                                  ? 10
                                  : controller.storeItemModel?.items?.length ??
                                        0,
                              separatorBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Divider(
                                  height: 32,
                                  color: context.color.grey,
                                ),
                              ),
                              itemBuilder: (context, index) {
                                final cartValue = controller.isItemLoad
                                    ? 10
                                    : controller.cartDummyList[index].value;
                                final isAddBtn = cartValue == 0;
                                return ItemsWidget(
                                  cartValue: cartValue,
                                  item: controller.isItemLoad
                                      ? null
                                      : controller
                                            .storeItemModel
                                            ?.items?[index],
                                  isLoad: controller.isItemLoad,
                                  isAddBtn: isAddBtn,
                                  onCartTap: (isRemove) => controller
                                      .changeCartList(index, isRemove),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
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
            backgroundColor: context.color.secondary,
            child: SvgAssets(icon, height: 25, color: context.color.white),
          ),
          Text(
            desc,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: context.style.s12w700,
          ),
        ],
      ),
    );
  }
}

class CustomizableSpaceBarWidget extends StatelessWidget {
  const CustomizableSpaceBarWidget({super.key, required this.builder});
  final Widget Function(BuildContext context, double scrollingRate) builder;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;

        final deltaExtent = settings.maxExtent - settings.minExtent;

        // 0.0 -> Expanded
        // 1.0 -> Collapsed to toolbar
        final scrollingRate =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);
        return builder(context, scrollingRate);
      },
    );
  }
}
