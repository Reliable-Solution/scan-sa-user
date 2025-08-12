import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/models/popular_categories_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/domain/models/search_suggestion_model.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class SearchRepositoryInterface extends RepositoryInterface<dynamic> {
  Future<bool> saveSearchHistory(List<String> searchHistories);
  List<String> getSearchAddress();
  Future<bool> clearSearchHistory();
  @override
  Future<dynamic> getList({
    int? offset,
    String? query,
    bool? isStore,
    bool isSuggestedItems = false,
  });
  Future<SearchSuggestionModel?> getSearchSuggestions(String searchText);
  Future<List<PopularCategoryModel?>?> getPopularCategories();
}
