import 'dart:convert';

import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/models/category_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/repositories/category_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class CategoryRepository implements CategoryRepositoryInterface {
  CategoryRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<dynamic> getList({
    int? offset,
    bool categoryList = false,
    bool subCategoryList = false,
    bool categoryItemList = false,
    bool categoryStoreList = false,
    bool? allCategory,
    String? id,
    String? type,
    DataSourceEnum? source,
  }) async {
    if (categoryList) {
      return _getCategoryList(allCategory!, source ?? DataSourceEnum.client);
    } else if (subCategoryList) {
      return _getSubCategoryList(id);
    } else if (categoryItemList) {
      return _getCategoryItemList(id, offset!, type!);
    } else if (categoryStoreList) {
      return _getCategoryStoreList(id, offset!, type!);
    }
    return null;
  }

  Future<List<CategoryModel>?> _getCategoryList(
    bool allCategory,
    DataSourceEnum source,
  ) async {
    List<CategoryModel>? categoryList;
    final header = allCategory
        ? {
            'Content-Type': 'application/json; charset=UTF-8',
            AppConstants.localizationKey:
                Get.find<GlobalController>().locale.value.languageCode,
          }
        : null;

    final cacheHeader = header ?? apiClient.getHeader();

    const cacheId = AppConstants.categoryUri;

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(
          AppConstants.categoryUri,
          headers: header,
        );
        if (response.statusCode == 200) {
          categoryList = [];
          response.body.forEach((category) {
            categoryList!.add(
              CategoryModel.fromJson(category as Map<String, dynamic>),
            );
          });
          await LocalClient.organize(
            DataSourceEnum.client,
            cacheId,
            jsonEncode(response.body),
            cacheHeader,
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
          categoryList = [];
          jsonDecode(cacheResponseData).forEach((category) {
            categoryList!.add(
              CategoryModel.fromJson(category as Map<String, dynamic>),
            );
          });
        }
    }

    return categoryList;
  }

  Future<List<CategoryModel>?> _getSubCategoryList(String? parentID) async {
    List<CategoryModel>? subCategoryList;
    final response = await apiClient.getData(
      '${AppConstants.subCategoryUri}$parentID',
    );
    if (response.statusCode == 200) {
      subCategoryList = [];
      response.body.forEach(
        (category) => subCategoryList!.add(
          CategoryModel.fromJson(category as Map<String, dynamic>),
        ),
      );
    }
    return subCategoryList;
  }

  Future<ItemModel?> _getCategoryItemList(
    String? categoryID,
    int offset,
    String type,
  ) async {
    ItemModel? categoryItem;
    final response = await apiClient.getData(
      '${AppConstants.categoryItemUri}$categoryID?limit=10&offset=$offset&type=$type',
    );
    if (response.statusCode == 200) {
      categoryItem = ItemModel.fromJson(response.body as Map<String, dynamic>);
    }
    return categoryItem;
  }

  Future<StoreModel?> _getCategoryStoreList(
    String? categoryID,
    int offset,
    String type,
  ) async {
    StoreModel? categoryStore;
    final response = await apiClient.getData(
      '${AppConstants.categoryStoreUri}$categoryID?limit=10&offset=$offset&type=$type',
    );
    if (response.statusCode == 200) {
      categoryStore = StoreModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return categoryStore;
  }

  @override
  Future<Response<dynamic>> getSearchData(
    String? query,
    String? categoryID,
    bool isStore,
    String type,
  ) async {
    return apiClient.getData(
      '${AppConstants.searchUri}${isStore ? 'stores' : 'items'}/search?name=$query&category_id=$categoryID&type=$type&offset=1&limit=50',
    );
  }

  @override
  Future<bool> saveUserInterests(List<int?> interests) async {
    final response = await apiClient.postData(AppConstants.interestUri, {
      'interest': interests,
    });
    return (response.statusCode == 200);
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
  Future<void> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
