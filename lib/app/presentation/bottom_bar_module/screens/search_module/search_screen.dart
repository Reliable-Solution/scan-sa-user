import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/controller/search_controller.dart'
    as search;
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/items_list.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/restaurant_list.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/common_tab_bar.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  search.SearchController get searchController => Get.put(
    search.SearchController(context, searchServiceInterface: Get.find()),
  );
  final TextEditingController _searchController = TextEditingController();

  List<String> _itemsAndStores = <String>[];
  bool _showSuggestion = false;

  @override
  void initState() {
    super.initState();
    searchController.setSearchMode(true, canUpdate: false);
    // searchController.getPopularCategories();
    searchController.getSuggestedItems();
    searchController.getHistoryList();
  }

  Future<void> _searchSuggestions(String query) async {
    _itemsAndStores = [];
    if (query == '') {
      _showSuggestion = false;
      _itemsAndStores = [];
    } else {
      _showSuggestion = true;
      _itemsAndStores = await searchController.getSearchSuggestions(query);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            MediaQuery.paddingOf(context) +
            EdgeInsets.symmetric(horizontal: AppSizes.appPadding, vertical: 10),
        child: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.color.darkTextGrey,
                      width: 2,
                    ),
                    color: context.color.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      SvgAssets(
                        AppIcons.searchBarIc,
                        color: context.color.darkTextGrey,
                      ),
                      Flexible(
                        child: TextFormField(
                          style: context.style.s16w700.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: context.color.primary,
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                (Get.find<GlobalController>()
                                        .configModel
                                        ?.moduleConfig
                                        ?.module
                                        ?.showRestaurantText ??
                                    false)
                                ? 'search_food_or_restaurant'.tr
                                : 'search_item_or_store'.tr,
                            hintStyle: context.style.s16w700.copyWith(
                              color: context.color.ff9c9c9c,
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                          ),
                          onChanged: (text) {
                            searchController.setSearchText(text);
                            _searchSuggestions(text);
                          },
                          onFieldSubmitted: (text) => _actionSearch(
                            true,
                            _searchController.text.trim(),
                            false,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showSuggestion = false;
                          searchController.setSearchMode(true);
                          searchController.setStore(false);
                          _searchController.text = '';
                          searchController.changeSearchStatus(false);
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: context.color.darkTextGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<search.SearchController>(
                  builder: (searchController) => (searchController.isSearchMode)
                      ? _showSuggestion
                            ? Expanded(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  children: _itemsAndStores
                                      .map(
                                        (e) => GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            _searchController.text = e;
                                            _actionSearch(
                                              true,
                                              _searchController.text.trim(),
                                              false,
                                            );
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Row(
                                              spacing: 8,
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: context
                                                      .color
                                                      .darkTextGrey,
                                                  size: 20,
                                                ),
                                                Text(
                                                  e,
                                                  style: context.style.s18w700
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: context
                                                            .color
                                                            .primary,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount:
                                      searchController.historyList.length > 10
                                      ? 10
                                      : searchController.historyList.length,
                                  itemBuilder: (context, index) {
                                    final history =
                                        searchController.historyList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        _searchController.text = history;
                                        _actionSearch(
                                          true,
                                          _searchController.text.trim(),
                                          false,
                                        );
                                      },
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            size: 18,
                                            color: Theme.of(
                                              context,
                                            ).disabledColor,
                                          ),
                                          Text(
                                            history,
                                            style: context.style.s18w700
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: context.color.primary,
                                                ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () => searchController
                                                .removeHistory(index),
                                            icon: Icon(
                                              Icons.close,
                                              size: 20,
                                              color: context.color.darkTextGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                      : Expanded(
                          child: Column(
                            children: [
                              CommonTabBar(
                                tabList: [
                                  context.l10n.restaurants,
                                  context.l10n.items,
                                ],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                selectedValue:
                                    searchController.searchType.value,
                                onTap: searchController.changeSearchType,
                              ),
                              if (searchController.searchType.value ==
                                  context.l10n.restaurants)
                                RestaurantList(
                                  list: searchController.searchStoreList ?? [],
                                  isLoad: searchController.isSearchLoad,
                                )
                              else
                                ItemList(
                                  list: searchController.searchItemList ?? [],
                                  isLoad: searchController.isSearchLoad,
                                ),
                            ],
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _actionSearch(bool isSubmit, String? queryText, bool fromHome) {
    if (searchController.isSearchMode || isSubmit) {
      if (queryText!.isNotEmpty) {
        ('object').print;
        searchController.searchData(queryText, fromHome);
      } else {
        showCustomSnackBar(
          (Get.find<GlobalController>()
                      .configModel
                      ?.moduleConfig
                      ?.module
                      ?.showRestaurantText ??
                  false)
              ? 'search_food_or_restaurant'.tr
              : 'search_item_or_store'.tr,
        );
      }
    }
  }
}
