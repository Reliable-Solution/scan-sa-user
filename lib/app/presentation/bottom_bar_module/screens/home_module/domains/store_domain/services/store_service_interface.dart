import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';

abstract class StoreServiceInterface {
  Future<StoreModel?> getStoreList(
    int offset,
    String filterBy,
    String storeType, {
    required DataSourceEnum source,
  });
  Future<List<Store>?> getPopularStoreList(
    String type, {
    required DataSourceEnum source,
  });
  Future<List<Store>?> getLatestStoreList(
    String type, {
    required DataSourceEnum source,
  });
  Future<List<Store>?> getTopOfferStoreList({
    required DataSourceEnum source,
    String? filterBy,
    String? sortBy,
  });
  Future<List<Store>?> getFeaturedStoreList({required DataSourceEnum source});
  Future<List<Store>?> getVisitAgainStoreList({required DataSourceEnum source});
  Future<Store?> getStoreDetails(
    String storeID,
    bool fromCart,
    String slug,
    String languageCode,
    ModuleModel? module,
    int? cacheModuleId,
    int? moduleId,
  );
  Future<ItemModel?> getStoreItemList(
    int? storeID,
    int offset,
    int? categoryID,
    String type,
  );
  Future<ItemModel?> getStoreSearchItemList(
    String searchText,
    String? storeID,
    int offset,
    String type,
    int? categoryID,
  );
  // Future<RecommendedItemModel?> getStoreRecommendedItemList(int? storeId);
  // Future<CartSuggestItemModel?> getCartStoreSuggestedItemList(
  //   int? storeId,
  //   String languageCode,
  //   ModuleModel? module,
  //   int? cacheModuleId,
  //   int? moduleId,
  // );
  // Future<List<StoreBannerModel>?> getStoreBannerList(int? storeId);
  Future<List<Store>?> getRecommendedStoreList({
    required DataSourceEnum source,
  });
  List<Modules> moduleList();
  String filterRestaurantLinkUrl(String slug, Store store);
}
