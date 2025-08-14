import 'package:get/get.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/repositories/store_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/services/store_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class StoreService implements StoreServiceInterface {
  StoreService({required this.storeRepositoryInterface});
  final StoreRepositoryInterface storeRepositoryInterface;

  @override
  Future<StoreModel?> getStoreList(
    int offset,
    String filterBy,
    String storeType, {
    required DataSourceEnum source,
  }) async {
    return (await storeRepositoryInterface.getList(
          offset: offset,
          isStoreList: true,
          filterBy: filterBy,
          storeType: storeType,
          source: source,
        ))
        as StoreModel?;
  }

  @override
  Future<List<Store>?> getPopularStoreList(
    String storeType, {
    required DataSourceEnum source,
  }) async {
    return (await storeRepositoryInterface.getList(
          isPopularStoreList: true,
          storeType: storeType,
          source: source,
        ))
        as List<Store>?;
  }

  @override
  Future<List<Store>?> getLatestStoreList(
    String storeType, {
    required DataSourceEnum source,
  }) async {
    return (await storeRepositoryInterface.getList(
          isLatestStoreList: true,
          storeType: storeType,
          source: source,
        ))
        as List<Store>?;
  }

  @override
  Future<List<Store>?> getTopOfferStoreList({
    required DataSourceEnum source,
    String? filterBy,
    String? sortBy,
  }) async {
    return (await storeRepositoryInterface.getList(
          isTopOfferStoreList: true,
          source: source,
          filterBy: filterBy,
          storeType: sortBy,
        ))
        as List<Store>?;
  }

  @override
  Future<List<Store>?> getFeaturedStoreList({
    required DataSourceEnum source,
  }) async {
    return (await storeRepositoryInterface.getList(
          isFeaturedStoreList: true,
          source: source,
        ))
        as List<Store>?;
  }

  @override
  Future<List<Store>?> getVisitAgainStoreList({
    required DataSourceEnum source,
  }) async {
    return (await storeRepositoryInterface.getList(
          isVisitAgainStoreList: true,
          source: source,
        ))
        as List<Store>?;
  }

  @override
  Future<Store?> getStoreDetails(
    String storeID,
    bool fromCart,
    String slug,
    String languageCode,
    ModuleModel? module,
    int? cacheModuleId,
    int? moduleId,
  ) async {
    return storeRepositoryInterface.getStoreDetails(
      storeID,
      fromCart,
      slug,
      languageCode,
      module,
      cacheModuleId,
      moduleId,
    );
  }

  @override
  Future<ItemModel?> getStoreItemList(
    int? storeID,
    int offset,
    int? categoryID,
    String type,
  ) async {
    return (await storeRepositoryInterface.getStoreItemList(
          storeID,
          offset,
          categoryID,
          type,
        ))
        as ItemModel?;
  }

  @override
  Future<ItemModel?> getStoreSearchItemList(
    String searchText,
    String? storeID,
    int offset,
    String type,
    int? categoryID,
  ) async {
    return (await storeRepositoryInterface.getStoreSearchItemList(
          searchText,
          storeID,
          offset,
          type,
          categoryID,
        ))
        as ItemModel?;
  }

  // @override
  // Future<RecommendedItemModel?> getStoreRecommendedItemList(
  //   int? storeId,
  // ) async {
  //   return storeRepositoryInterface.getList(
  //     isStoreRecommendedItemList: true,
  //     storeId: storeId,
  //   );
  // }

  // @override
  // Future<CartSuggestItemModel?> getCartStoreSuggestedItemList(
  //   int? storeId,
  //   String languageCode,
  //   ModuleModel? module,
  //   int? cacheModuleId,
  //   int? moduleId,
  // ) async {
  //   return await storeRepositoryInterface.getCartStoreSuggestedItemList(
  //     storeId,
  //     languageCode,
  //     module,
  //     cacheModuleId,
  //     moduleId,
  //   ) as ;
  // }

  // @override
  // Future<List<StoreBannerModel>?> getStoreBannerList(int? storeId) async {
  //   return await storeRepositoryInterface.getList(
  //     isStoreBannerList: true,
  //     storeId: storeId,
  //   ) as ;
  // }

  @override
  Future<List<Store>?> getRecommendedStoreList({
    required DataSourceEnum source,
  }) async {
    return (await storeRepositoryInterface.getList(
          isRecommendedStoreList: true,
          source: source,
        ))
        as List<Store>?;
  }

  @override
  List<Modules> moduleList() {
    final moduleList = <Modules>[];
    for (final zone
        in AddressHelper.getUserAddressFromSharedPref()!.zoneData ??
            <ZoneData>[]) {
      for (final module in zone.modules ?? <Modules>[]) {
        moduleList.add(module);
      }
    }
    return moduleList;
  }

  @override
  String filterRestaurantLinkUrl(String slug, Store store) {
    final routes = Get.currentRoute.split('?');
    var replace = '';

    if (AppConstants.useReactWebsite) {
      if (slug.isNotEmpty) {
        replace =
            '${routes[0]}/$slug?module_id=${store.moduleId}&store_zone_id=${store.zoneId}&distance=${store.distance}';
      } else {
        replace =
            '${routes[0]}/${store.id}?module_id=${store.moduleId}&store_zone_id=${store.zoneId}&distance=${store.distance}';
      }
    } else {
      if (slug.isNotEmpty) {
        replace = '${routes[0]}?slug=$slug';
      } else {
        replace = '${routes[0]}?slug=${store.id}';
      }
    }
    return replace;
  }
}
