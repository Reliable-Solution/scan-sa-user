import 'dart:convert';

import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/basic_medicine_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/common_condition_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/repositories/item_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class ItemRepository implements ItemRepositoryInterface {
  ItemRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<BasicMedicineModel?> getBasicMedicine(DataSourceEnum source) async {
    BasicMedicineModel? basicMedicineModel;
    final cacheId =
        '${AppConstants.basicMedicineUri}?offset=1&limit=50-${Get.find<GlobalController>().module!.id!}';

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(
          '${AppConstants.basicMedicineUri}?offset=1&limit=50',
        );
        if (response.statusCode == 200) {
          basicMedicineModel = BasicMedicineModel.fromJson(
            response.body as Map<String, dynamic>,
          );
          await LocalClient.organize(
            DataSourceEnum.client,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          DataSourceEnum.local,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          basicMedicineModel = BasicMedicineModel.fromJson(
            jsonDecode(cacheResponseData) as Map<String, dynamic>,
          );
        }
    }
    return basicMedicineModel;
  }

  @override
  Future<void> add(dynamic value) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> get(String? id, {bool isConditionWiseItem = false}) async {
    if (isConditionWiseItem) {
      return _getConditionsWiseItems(int.parse(id!));
    } else {
      return _getItemDetails(int.parse(id!));
    }
  }

  Future<Item?> _getItemDetails(int? itemID) async {
    Item? item;
    final response = await apiClient.getData(
      '${AppConstants.itemDetailsUri}$itemID',
    );
    if (response.statusCode == 200) {
      item = Item.fromJson(response.body as Map<String, dynamic>);
    }
    return item;
  }

  Future<List<Item>?> _getConditionsWiseItems(int id) async {
    List<Item>? conditionWiseProduct;
    final response = await apiClient.getData(
      '${AppConstants.conditionWiseItemUri}$id?limit=15&offset=1',
    );
    if (response.statusCode == 200) {
      conditionWiseProduct = [];
      conditionWiseProduct.addAll(
        ItemModel.fromJson(response.body as Map<String, dynamic>).items!,
      );
    }
    return conditionWiseProduct;
  }

  @override
  Future<dynamic> getList({
    int? offset,
    String? storeType,
    bool isPopularItem = false,
    bool isReviewedItem = false,
    bool isFeaturedCategoryItems = false,
    bool isRecommendedItems = false,
    bool isCommonConditions = false,
    bool isDiscountedItems = false,
    DataSourceEnum? source,
  }) async {
    if (isPopularItem) {
      return _getPopularItemList(
        storeType!,
        source: source ?? DataSourceEnum.client,
      );
    } else if (isReviewedItem) {
      return _getReviewedItemList(
        storeType!,
        source: source ?? DataSourceEnum.client,
      );
    } else if (isFeaturedCategoryItems) {
      return _getFeaturedCategoriesItemList(
        source: source ?? DataSourceEnum.client,
      );
    } else if (isRecommendedItems) {
      return _getRecommendedItemList(
        storeType!,
        source: source ?? DataSourceEnum.client,
      );
    } else if (isCommonConditions) {
      return _getCommonConditions();
    } else if (isDiscountedItems) {
      return _getDiscountedItemList(
        storeType!,
        source: source ?? DataSourceEnum.client,
      );
    }
  }

  Future<List<Item>?> _getPopularItemList(
    String type, {
    required DataSourceEnum source,
  }) async {
    List<Item>? popularItemList;
    final cacheId =
        '${AppConstants.popularItemUri}?type=$type-${Get.find<GlobalController>().module!.id!}';

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(
          '${AppConstants.popularItemUri}?type=$type',
        );
        if (response.statusCode == 200) {
          popularItemList = [];
          popularItemList.addAll(
            ItemModel.fromJson(response.body as Map<String, dynamic>).items!,
          );
          await LocalClient.organize(
            DataSourceEnum.client,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          DataSourceEnum.local,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          popularItemList = [];
          popularItemList.addAll(
            ItemModel.fromJson(
              jsonDecode(cacheResponseData) as Map<String, dynamic>,
            ).items!,
          );
        }
    }

    return popularItemList;
  }

  Future<ItemModel?> _getReviewedItemList(
    String type, {
    required DataSourceEnum source,
  }) async {
    ItemModel? itemModel;
    final cacheId =
        '${AppConstants.reviewedItemUri}?type=$type${Get.find<GlobalController>().module!.id!}';

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(
          '${AppConstants.reviewedItemUri}?type=$type',
        );
        if (response.statusCode == 200) {
          itemModel = ItemModel.fromJson(response.body as Map<String, dynamic>);
          await LocalClient.organize(
            DataSourceEnum.client,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          DataSourceEnum.local,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          itemModel = ItemModel.fromJson(
            jsonDecode(cacheResponseData) as Map<String, dynamic>,
          );
        }
    }

    return itemModel;
  }

  Future<ItemModel?> _getFeaturedCategoriesItemList({
    required DataSourceEnum source,
  }) async {
    ItemModel? featuredCategoriesItem;
    final cacheId =
        '${AppConstants.featuredCategoriesItemsUri}?limit=30&offset=1${Get.find<GlobalController>().module!.id!}';

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(
          '${AppConstants.featuredCategoriesItemsUri}?limit=30&offset=1',
        );
        if (response.statusCode == 200) {
          featuredCategoriesItem = ItemModel.fromJson(
            response.body as Map<String, dynamic>,
          );
          await LocalClient.organize(
            DataSourceEnum.client,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          DataSourceEnum.local,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          featuredCategoriesItem = ItemModel.fromJson(
            jsonDecode(cacheResponseData) as Map<String, dynamic>,
          );
        }
    }

    return featuredCategoriesItem;
  }

  Future<List<Item>?> _getRecommendedItemList(
    String type, {
    required DataSourceEnum source,
  }) async {
    List<Item>? recommendedItemList;
    final cacheId =
        '${AppConstants.recommendedItemsUri}$type&limit=30${Get.find<GlobalController>().module!.id!}';

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(
          '${AppConstants.recommendedItemsUri}$type&limit=30',
        );
        if (response.statusCode == 200) {
          recommendedItemList = [];
          recommendedItemList.addAll(
            ItemModel.fromJson(response.body as Map<String, dynamic>).items!,
          );
          await LocalClient.organize(
            DataSourceEnum.client,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          DataSourceEnum.local,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          recommendedItemList = [];
          recommendedItemList.addAll(
            ItemModel.fromJson(
              jsonDecode(cacheResponseData) as Map<String, dynamic>,
            ).items!,
          );
        }
    }

    return recommendedItemList;
  }

  Future<List<CommonConditionModel>?> _getCommonConditions() async {
    List<CommonConditionModel>? commonConditions;
    final response = await apiClient.getData(AppConstants.commonConditionUri);
    if (response.statusCode == 200) {
      commonConditions = [];
      response.body.forEach(
        (condition) => commonConditions!.add(
          CommonConditionModel.fromJson(condition as Map<String, dynamic>),
        ),
      );
    }
    return commonConditions;
  }

  Future<List<Item>?> _getDiscountedItemList(
    String type, {
    required DataSourceEnum source,
  }) async {
    List<Item>? discountedItemList;
    final cacheId =
        '${AppConstants.discountedItemsUri}?type=$type&offset=1&limit=50${Get.find<GlobalController>().module!.id!}';

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(
          '${AppConstants.discountedItemsUri}?type=$type&offset=1&limit=50',
        );
        if (response.statusCode == 200) {
          discountedItemList = [];
          discountedItemList.addAll(
            ItemModel.fromJson(response.body as Map<String, dynamic>).items!,
          );
          await LocalClient.organize(
            DataSourceEnum.client,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }

      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          DataSourceEnum.local,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          discountedItemList = [];
          discountedItemList.addAll(
            ItemModel.fromJson(
              jsonDecode(cacheResponseData) as Map<String, dynamic>,
            ).items!,
          );
        }
    }

    return discountedItemList;
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
