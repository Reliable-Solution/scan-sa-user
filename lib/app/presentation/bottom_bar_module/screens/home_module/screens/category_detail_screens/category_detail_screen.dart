import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/category_detail_screens/controller/category_detail_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/items_list.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/restaurant_list.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/app/widgets/common_tab_bar.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/circular_shimmer.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/rectangular_shimmer.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });
  final String categoryId;
  final String categoryName;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  CategoryDetailController get categoryController => Get.put(
    CategoryDetailController(context, categoryServiceInterface: Get.find()),
  );

  @override
  void initState() {
    super.initState();
    categoryController
      ..getSubCategoryList(widget.categoryId)
      ..getCategoryStoreList(widget.categoryId, 1, 'All', true);
  }

  @override
  Widget build(BuildContext context) {
    return CommonSubScreen(
      appBarTitle: widget.categoryName,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GetBuilder<CategoryDetailController>(
          builder: (searchController) {
            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  height: 105,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.appPadding,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: searchController.isCategoryLoading
                        ? 10
                        : searchController.subCategoryList.length,
                    itemBuilder: (context, index) {
                      final e = searchController.isCategoryLoading
                          ? null
                          : searchController.subCategoryList[index];
                      final isSelected =
                          searchController.subCategoryIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          spacing: 4,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                if (!searchController.isCategoryLoading)
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundColor: context.color.grey,
                                  ),
                                if (!searchController.isCategoryLoading)
                                  GestureDetector(
                                    onTap: () =>
                                        categoryController.setSubCategoryIndex(
                                          index,
                                          e?.id?.toString() ?? '0',
                                        ),
                                    child:
                                        (e?.imageFullUrl?.isNotEmpty ?? false)
                                        ? Image.network(
                                            e?.imageFullUrl ?? '',
                                            width: 60,
                                            height: 60,
                                          )
                                        : Image.asset(
                                            AppIcons.logo,
                                            width: 60,
                                            height: 60,
                                          ),
                                  )
                                else
                                  const CircularShimmer(size: 30),
                              ],
                            ),
                            if (searchController.isCategoryLoading)
                              const RectangularShimmer(height: 10, width: 60)
                            else
                              Text(
                                e?.name ?? '',
                                style: context.style.s12w700.copyWith(
                                  color: isSelected
                                      ? context.color.primary
                                      : context.color.darkTextGrey,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    CommonTabBar(
                      tabList: [context.l10n.restaurants, context.l10n.items],
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      selectedValue: searchController.tab ?? '',
                      onTap: (value) {
                        searchController.changeTab(value);
                      },
                    ),
                    if (searchController.tab == context.l10n.restaurants)
                      RestaurantList(
                        list: searchController.categoryStoreList,
                        isLoad: searchController.isStoreLoading,
                        isScroll: false,
                      )
                    else
                      ItemList(
                        list: searchController.categoryItemList,
                        isLoad: searchController.isItemLoading,
                        isScroll: false,
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
