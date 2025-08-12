import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/models/popular_categories_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/models/search_suggestion_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';

abstract class SearchServiceInterface {
  Future<dynamic> getSearchData(String? query, bool isStore);
  Future<dynamic> getSuggestedItems();
  Future<bool> saveSearchHistory(List<String> searchHistories);
  List<String> getSearchAddress();
  Future<bool> clearSearchHistory();
  List<Item>? sortItemSearchList(
    List<Item>? allItemList,
    double upperValue,
    double lowerValue,
    int rating,
    bool veg,
    bool nonVeg,
    bool isAvailableItems,
    bool isDiscountedItems,
    int sortIndex,
  );
  List<Store>? sortStoreSearchList(
    List<Store>? allStoreList,
    int storeRating,
    bool storeVeg,
    bool storeNonVeg,
    bool isAvailableStore,
    bool isDiscountedStore,
    int storeSortIndex,
  );
  Future<SearchSuggestionModel?> getSearchSuggestions(String searchText);
  Future<List<PopularCategoryModel?>?> getPopularCategories();
}
