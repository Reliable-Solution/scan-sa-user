import 'dart:convert';

import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/repositories/store_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/header_helper.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreRepository implements StoreRepositoryInterface {
  StoreRepository({required this.apiClient, required this.sharedPreferences});
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  @override
  Future<dynamic> getList({
    int? offset,
    bool isStoreList = false,
    String? filterBy,
    bool isPopularStoreList = false,
    String? type,
    bool isLatestStoreList = false,
    bool isFeaturedStoreList = false,
    bool isVisitAgainStoreList = false,
    bool isStoreRecommendedItemList = false,
    int? storeId,
    bool isStoreBannerList = false,
    bool isRecommendedStoreList = false,
    bool isTopOfferStoreList = false,
    DataSourceEnum? source,
  }) async {
    if (isStoreList) {
      return _getStoreList(
        offset!,
        filterBy!,
        type!,
        source: source ?? DataSourceEnum.client,
      );
    } else if (isPopularStoreList) {
      return _getPopularStoreList(
        type!,
        source: source ?? DataSourceEnum.client,
      );
    } else if (isLatestStoreList) {
      return _getLatestStoreList(
        type!,
        source: source ?? DataSourceEnum.client,
      );
    } else if (isFeaturedStoreList) {
      return _getFeaturedStoreList(source: source ?? DataSourceEnum.client);
    } else if (isVisitAgainStoreList) {
      return _getVisitAgainStoreList(source: source ?? DataSourceEnum.client);
    }
    //  else if (isStoreRecommendedItemList) {
    //   return _getStoreRecommendedItemList(storeId);
    // } else if (isStoreBannerList) {
    //   return _getStoreBannerList(storeId);
    // }
    else if (isRecommendedStoreList) {
      return _getRecommendedStoreList(source: source ?? DataSourceEnum.client);
    } else if (isTopOfferStoreList) {
      return _getTopOfferStoreList(
        source: source ?? DataSourceEnum.client,
        filterBy: filterBy,
        sortBy: type,
      );
    }
  }

  Future<StoreModel?> _getStoreList(
    int offset,
    String filterBy,
    String storeType, {
    required DataSourceEnum source,
  }) async {
    StoreModel? storeModel;
    final cacheId =
        '${AppConstants.storeUri}/$filterBy?store_type=$storeType&offset=$offset&limit=12';

    ///-${Get.find<GlobalController>().module!.id!}

    final response = await apiClient.getData(
      '${AppConstants.storeUri}/$filterBy?store_type=$storeType&offset=$offset&limit=12',
    );
    if (response.statusCode == 200) {
      storeModel = StoreModel.fromJson(response.body as Map<String, dynamic>);
      await LocalClient.organize(
        DataSourceEnum.client,
        cacheId,
        jsonEncode(response.body as Map<String, dynamic>),
        apiClient.getHeader(),
      );
    }
    // switch (source) {
    //   case DataSourceEnum.client:

    //   case DataSourceEnum.local:
    //     final cacheResponseData = await LocalClient.organize(
    //       DataSourceEnum.local,
    //       cacheId,
    //       null,
    //       null,
    //     );
    //     storeModel = StoreModel.fromJson(
    //       jsonDecode(cacheResponseData ?? '') as Map<String, dynamic>,
    //     );
    // }
    return storeModel;
  }

  Future<List<Store>?> _getPopularStoreList(
    String type, {
    required DataSourceEnum source,
  }) async {
    List<Store>? popularStoreList;
    final cacheId = '${AppConstants.popularStoreUri}?type=$type}';

    ///

    final response = await apiClient.getData(
      '${AppConstants.popularStoreUri}?type=$type',
    );
    if (response.statusCode == 200) {
      popularStoreList = [];
      final data = response.body as Map<String, dynamic>;
      for (final store in data['stores'] as List) {
        popularStoreList.add(Store.fromJson(store as Map<String, dynamic>));
      }
      await LocalClient.organize(
        DataSourceEnum.client,
        cacheId,
        jsonEncode(response.body['stores']),
        apiClient.getHeader(),
      );
    }
    // switch (source) {
    //   case DataSourceEnum.client:

    //   case DataSourceEnum.local:
    //     final cacheResponseData = await LocalClient.organize(
    //       DataSourceEnum.local,
    //       cacheId,
    //       null,
    //       null,
    //     );
    //     popularStoreList = [];
    //     jsonDecode(cacheResponseData ?? '').forEach(
    //       (store) => popularStoreList!.add(
    //         Store.fromJson(store as Map<String, dynamic>),
    //       ),
    //     );
    // }
    return popularStoreList;
  }

  Future<List<Store>?> _getLatestStoreList(
    String type, {
    required DataSourceEnum source,
  }) async {
    List<Store>? latestStoreList;
    final cacheId = '${AppConstants.popularStoreUri}?type=$type';

    /// module id is here

    final response = await apiClient.getData(
      '${AppConstants.latestStoreUri}?type=$type',
    );
    if (response.statusCode == 200) {
      latestStoreList = [];
      response.body as Map<String, dynamic>;
      for (final store in response.body['stores'] as List) {
        latestStoreList.add(Store.fromJson(store as Map<String, dynamic>));
      }
      await LocalClient.organize(
        DataSourceEnum.client,
        cacheId,
        jsonEncode(response.body['stores']),
        apiClient.getHeader(),
      );
    }
    // switch (source) {
    //   case DataSourceEnum.client:

    //   case DataSourceEnum.local:
    //     final cacheResponseData = await LocalClient.organize(
    //       DataSourceEnum.local,
    //       cacheId,
    //       null,
    //       null,
    //     );
    //     latestStoreList = [];
    //     jsonDecode(cacheResponseData ?? '').forEach(
    //       (store) => latestStoreList!.add(
    //         Store.fromJson(store as Map<String, dynamic>),
    //       ),
    //     );
    // }

    return latestStoreList;
  }

  Future<List<Store>?> _getTopOfferStoreList({
    required DataSourceEnum source,
    String? filterBy,
    String? sortBy,
  }) async {
    List<Store>? topOfferStoreList;
    const cacheId = AppConstants.topOfferStoreUri;
    //// module id is here

    final response = await apiClient.getData(
      '${AppConstants.topOfferStoreUri}?sort_by=$sortBy&${filterBy == '1'
          ? 'halal=1'
          : filterBy == 'veg'
          ? 'type=veg'
          : filterBy == 'non_veg'
          ? 'type=non_veg'
          : 'type='}',
    );
    if (response.statusCode == 200) {
      topOfferStoreList = [];
      response.body as Map<String, dynamic>;
      for (final store in response.body['stores'] as List) {
        topOfferStoreList.add(Store.fromJson(store as Map<String, dynamic>));
      }
      await LocalClient.organize(
        DataSourceEnum.client,
        cacheId,
        jsonEncode(response.body['stores']),
        apiClient.getHeader(),
      );
    }
    // switch (source) {
    //   case DataSourceEnum.client:

    //   case DataSourceEnum.local:
    //     final cacheResponseData = await LocalClient.organize(
    //       DataSourceEnum.local,
    //       cacheId,
    //       null,
    //       null,
    //     );
    //     topOfferStoreList = [];
    //     jsonDecode(cacheResponseData ?? '').forEach(
    //       (store) => topOfferStoreList!.add(
    //         Store.fromJson(store as Map<String, dynamic>),
    //       ),
    //     );
    // }
    return topOfferStoreList;
  }

  Future<List<Store>?> _getFeaturedStoreList({
    required DataSourceEnum source,
  }) async {
    List<Store>? featuredStoreList;
    const cacheId = '${AppConstants.storeUri}/all?featured=1&offset=1&limit=50';
    //// -${Get.find<GlobalController>().module?.id ?? ''}
    final header = (Get.find<GlobalController>().configModel!.module == null)
        ? HeaderHelper.featuredHeader()
        : apiClient.getHeader();

    final response = await apiClient.getData(
      '${AppConstants.storeUri}/all?featured=1&offset=1&limit=50',
      headers: Get.find<GlobalController>().configModel!.module == null
          ? HeaderHelper.featuredHeader()
          : null,
    );
    if (response.statusCode == 200) {
      featuredStoreList = [];
      response.body;
      for (final store in response.body['stores'] as List) {
        featuredStoreList.add(Store.fromJson(store as Map<String, dynamic>));
      }
      await LocalClient.organize(
        DataSourceEnum.client,
        cacheId,
        jsonEncode(response.body['stores']),
        header,
      );
    }
    // switch (source) {
    //   case DataSourceEnum.client:

    //   case DataSourceEnum.local:
    //     final cacheResponseData = await LocalClient.organize(
    //       DataSourceEnum.local,
    //       cacheId,
    //       null,
    //       null,
    //     );
    //     featuredStoreList = [];
    //     jsonDecode(cacheResponseData ?? '').forEach(
    //       (store) => featuredStoreList!.add(
    //         Store.fromJson(store as Map<String, dynamic>),
    //       ),
    //     );
    // }
    return featuredStoreList;
  }

  Future<List<Store>?> _getVisitAgainStoreList({
    required DataSourceEnum source,
  }) async {
    List<Store>? visitAgainStoreList;
    const cacheId = AppConstants.visitAgainStoreUri;

    final response = await apiClient.getData(AppConstants.visitAgainStoreUri);
    if (response.statusCode == 200) {
      visitAgainStoreList = [];
      response.body.forEach(
        (store) => visitAgainStoreList!.add(
          Store.fromJson(store as Map<String, dynamic>),
        ),
      );
      await LocalClient.organize(
        DataSourceEnum.client,
        cacheId,
        jsonEncode(response.body as Map<String, dynamic>),
        apiClient.getHeader(),
      );
    }
    // switch (source) {
    //   case DataSourceEnum.client:

    //   case DataSourceEnum.local:
    //     final cacheResponseData = await LocalClient.organize(
    //       DataSourceEnum.local,
    //       cacheId,
    //       null,
    //       null,
    //     );
    //     visitAgainStoreList = [];
    //     jsonDecode(cacheResponseData ?? '').forEach(
    //       (store) => visitAgainStoreList!.add(
    //         Store.fromJson(store as Map<String, dynamic>),
    //       ),
    //     );
    // }
    return visitAgainStoreList;
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
    Store? store;
    Map<String, String>? header;
    if (fromCart) {
      final addressModel = AddressHelper.getUserAddressFromSharedPref();
      header = apiClient.updateHeader(
        token: sharedPreferences.getString(AppConstants.token),
        zoneIDs: addressModel?.zoneIds ?? [],
        operationIds: addressModel?.areaIds,
        languageCode: languageCode,
        moduleID: module == null ? cacheModuleId : moduleId,
        latitude: addressModel?.latitude,
        longitude: addressModel?.longitude,
        setHeader: false,
      );
    }
    if (slug.isNotEmpty) {
      header = apiClient.updateHeader(
        token: sharedPreferences.getString(AppConstants.token),
        operationIds: [],
        zoneIDs: [],
        languageCode: languageCode,
        moduleID: 0,
        latitude: '',
        longitude: '',
        setHeader: false,
      );
    }
    final response = await apiClient.getData(
      '${AppConstants.storeDetailsUri}${slug.isNotEmpty ? slug : storeID}',
      headers: header,
    );
    if (response.statusCode == 200) {
      store = Store.fromJson(response.body as Map<String, dynamic>);
    }
    return store;
  }

  @override
  Future<ItemModel?> getStoreItemList(
    int? storeID,
    int offset,
    int? categoryID,
    String type,
  ) async {
    ItemModel? storeItemModel;
    final response = await apiClient.getData(
      '${AppConstants.storeItemUri}?store_id=$storeID&category_id=$categoryID&offset=$offset&limit=13&type=$type',
    );
    if (response.statusCode == 200) {
      storeItemModel = ItemModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return storeItemModel;
  }

  @override
  Future<ItemModel?> getStoreSearchItemList(
    String searchText,
    String? storeID,
    int offset,
    String type,
    int? categoryID,
  ) async {
    ItemModel? storeSearchItemModel;
    final response = await apiClient.getData(
      '${AppConstants.searchUri}items/search?store_id=$storeID&name=$searchText&offset=$offset&limit=10&type=$type&category_id=${categoryID ?? ''}',
    );
    if (response.statusCode == 200) {
      storeSearchItemModel = ItemModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return storeSearchItemModel;
  }

  // Future<RecommendedItemModel?> _getStoreRecommendedItemList(
  //   int? storeId,
  // ) async {
  //   RecommendedItemModel? recommendedItemModel;
  //   final response = await apiClient.getData(
  //     '${AppConstants.storeRecommendedItemUri}?store_id=$storeId&offset=1&limit=50',
  //   );
  //   if (response.statusCode == 200) {
  //     recommendedItemModel = RecommendedItemModel.fromJson(response.body as Map<String, dynamic>);
  //   }
  //   return recommendedItemModel;
  // }

  // @override
  // Future<CartSuggestItemModel?> getCartStoreSuggestedItemList(
  //   int? storeId,
  //   String languageCode,
  //   ModuleModel? module,
  //   int? cacheModuleId,
  //   int? moduleId,
  // ) async {
  //   CartSuggestItemModel? cartSuggestItemModel;
  //   final addressModel = AddressHelper.getUserAddressFromSharedPref();
  //   final header = apiClient.updateHeader(
  //     sharedPreferences.getString(AppConstants.token),
  //     addressModel?.zoneIds,
  //     addressModel?.areaIds,
  //     languageCode,
  //     module == null ? cacheModuleId : moduleId,
  //     addressModel?.latitude,
  //     addressModel?.longitude,
  //     setHeader: false,
  //   );
  //   final response = await apiClient.getData(
  //     '${AppConstants.cartStoreSuggestedItemsUri}?recommended=1&store_id=$storeId&offset=1&limit=50',
  //     headers: header,
  //   );
  //   if (response.statusCode == 200) {
  //     cartSuggestItemModel = CartSuggestItemModel.fromJson(response.body as Map<String, dynamic>);
  //   }
  //   return cartSuggestItemModel;
  // }

  // Future<List<StoreBannerModel>?> _getStoreBannerList(int? storeId) async {
  //   List<StoreBannerModel>? storeBanners;
  //   final response = await apiClient.getData(
  //     '${AppConstants.storeBannersUri}$storeId',
  //   );
  //   if (response.statusCode == 200) {
  //     storeBanners = [];
  //     response.body as Map<String, dynamic>.forEach(
  //       (banner) => storeBanners!.add(StoreBannerModel.fromJson(banner)),
  //     );
  //   }
  //   return storeBanners;
  // }

  Future<List<Store>?> _getRecommendedStoreList({
    required DataSourceEnum source,
  }) async {
    List<Store>? recommendedStoreList;
    const cacheId = '${AppConstants.storeUri}/all?featured=1&offset=1&limit=50';

    ///-${Get.find<GlobalController>().module?.id ?? ''}

    final response = await apiClient.getData(AppConstants.recommendedStoreUri);
    if (response.statusCode == 200) {
      recommendedStoreList = [];
      final body = response.body as Map<String, dynamic>;
      for (final store in (body['stores'] as List)) {
        recommendedStoreList.add(Store.fromJson(store as Map<String, dynamic>));
      }
      await LocalClient.organize(
        DataSourceEnum.client,
        cacheId,
        jsonEncode(response.body['stores']),
        apiClient.getHeader(),
      );
    }

    return recommendedStoreList;
  }

  @override
  Future<dynamic> add(dynamic value) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future<void> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
