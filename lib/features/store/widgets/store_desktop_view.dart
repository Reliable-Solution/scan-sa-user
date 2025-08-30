import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scan_sa_user/features/item/controllers/item_controller.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:scan_sa_user/common/widgets/footer_view.dart';
import 'package:scan_sa_user/common/widgets/paginated_list_view.dart';
import 'package:scan_sa_user/common/widgets/web_item_view.dart';
import 'package:scan_sa_user/features/search/widgets/custom_check_box_widget.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:get/get.dart';

class StoreDesktopView extends StatefulWidget {
  const StoreDesktopView({
    super.key,
    required this.storeId,
    required this.scrollController,
  });
  final int? storeId;
  final ScrollController scrollController;

  @override
  State<StoreDesktopView> createState() => _StoreDesktopViewState();
}

class _StoreDesktopViewState extends State<StoreDesktopView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (storeController) {
        return SliverToBoxAdapter(
          child: FooterView(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: Dimensions.paddingSizeSmall,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 175,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: storeController.categoryList!.length,
                              padding: const EdgeInsets.only(
                                left: Dimensions.paddingSizeSmall,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    storeController.setCategoryIndex(
                                      index,
                                      itemSearching:
                                          storeController.isSearching,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: Dimensions.paddingSizeSmall,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeSmall,
                                        vertical:
                                            Dimensions.paddingSizeExtraSmall,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft,
                                          colors: <Color>[
                                            index ==
                                                    storeController
                                                        .categoryIndex
                                                ? Theme.of(
                                                    context,
                                                  ).primaryColor.withValues(
                                                      alpha: 0.50,
                                                    )
                                                : Colors.transparent,
                                            index ==
                                                    storeController
                                                        .categoryIndex
                                                ? Theme.of(
                                                    context,
                                                  ).cardColor
                                                : Colors.transparent,
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            storeController
                                                .categoryList![index].name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: index ==
                                                    storeController
                                                        .categoryIndex
                                                ? robotoMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    color:
                                                        context.color.secondary,
                                                  )
                                                : robotoRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: storeController.categoryList!.length * 50,
                            width: 1,
                            color: Theme.of(context).disabledColor.withValues(
                                  alpha: 0.5,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeLarge,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeExtraSmall,
                                ),
                                height: 45,
                                width: 430,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusDefault,
                                  ),
                                  color: Theme.of(
                                    context,
                                  ).cardColor,
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).primaryColor.withValues(
                                          alpha: 0.40,
                                        ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _searchController,
                                        textInputAction: TextInputAction.search,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 0,
                                            vertical: 0,
                                          ),
                                          hintText: 'search_for_items'.tr,
                                          hintStyle: robotoRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: Theme.of(
                                              context,
                                            ).disabledColor,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSmall,
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Theme.of(
                                            context,
                                          ).cardColor,
                                          isDense: true,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Theme.of(
                                              context,
                                            ).primaryColor.withValues(
                                                  alpha: 0.50,
                                                ),
                                          ),
                                        ),
                                        onSubmitted: (
                                          String? value,
                                        ) {
                                          if (value!.isNotEmpty) {
                                            Get.find<StoreController>()
                                                .getStoreSearchItemList(
                                              _searchController.text.trim(),
                                              widget.storeId.toString(),
                                              1,
                                              storeController.type,
                                            );
                                          }
                                        },
                                        onChanged: (
                                          String? value,
                                        ) {},
                                      ),
                                    ),
                                    const SizedBox(
                                      width: Dimensions.paddingSizeSmall,
                                    ),
                                    !storeController.isSearching
                                        ? AppButton(
                                            radius: Dimensions.radiusSmall,
                                            height: 40,
                                            width: 74,
                                            buttonText: 'search'.tr,
                                            isBold: false,
                                            fontSize: Dimensions.fontSizeSmall,
                                            onPressed: () {
                                              storeController
                                                  .getStoreSearchItemList(
                                                _searchController.text.trim(),
                                                widget.storeId.toString(),
                                                1,
                                                storeController.type,
                                              );
                                            },
                                          )
                                        : InkWell(
                                            onTap: () {
                                              _searchController.text = '';
                                              storeController.initSearchData();
                                              storeController
                                                  .changeSearchStatus();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(
                                                  context,
                                                ).primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  Dimensions.radiusSmall,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 3,
                                                horizontal:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: Dimensions.paddingSizeSmall,
                              ),
                              (Get.find<SplashController>()
                                          .configModel!
                                          .moduleConfig!
                                          .module!
                                          .vegNonVeg! &&
                                      Get.find<SplashController>()
                                          .configModel!
                                          .toggleVegNonVeg!)
                                  ? SizedBox(
                                      width: 300,
                                      height: 30,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: Get.find<ItemController>()
                                            .itemTypeList
                                            .length,
                                        padding: const EdgeInsets.only(
                                          left: Dimensions.paddingSizeSmall,
                                        ),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (
                                          context,
                                          index,
                                        ) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              right:
                                                  Dimensions.paddingSizeSmall,
                                            ),
                                            child: CustomCheckBoxWidget(
                                              title: Get.find<ItemController>()
                                                  .itemTypeList[index]
                                                  .tr,
                                              value: storeController.type ==
                                                  Get.find<ItemController>()
                                                      .itemTypeList[index],
                                              onClick: () {
                                                if (storeController
                                                    .isSearching) {
                                                  storeController
                                                      .getStoreSearchItemList(
                                                    storeController.searchText,
                                                    widget.storeId.toString(),
                                                    1,
                                                    Get.find<ItemController>()
                                                        .itemTypeList[index],
                                                  );
                                                } else {
                                                  storeController
                                                      .getStoreItemList(
                                                    storeController.store!.id,
                                                    1,
                                                    Get.find<ItemController>()
                                                        .itemTypeList[index],
                                                    true,
                                                  );
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeSmall,
                          ),
                          PaginatedListView(
                            scrollController: widget.scrollController,
                            onPaginate: (int? offset) {
                              if (storeController.isSearching) {
                                storeController.getStoreSearchItemList(
                                  storeController.searchText,
                                  widget.storeId.toString(),
                                  offset!,
                                  storeController.type,
                                );
                              } else {
                                storeController.getStoreItemList(
                                  widget.storeId ?? storeController.store!.id,
                                  offset!,
                                  storeController.type,
                                  false,
                                );
                              }
                            },
                            totalSize: storeController.isSearching
                                ? storeController
                                    .storeSearchItemModel?.totalSize
                                : storeController.storeItemModel?.totalSize,
                            offset: storeController.isSearching
                                ? storeController.storeSearchItemModel?.offset
                                : storeController.storeItemModel?.offset,
                            itemView: WebItemsView(
                              isStore: false,
                              stores: null,
                              fromStore: true,
                              items: storeController.isSearching
                                  ? storeController.storeSearchItemModel?.items
                                  : (storeController.categoryList!.isNotEmpty &&
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
