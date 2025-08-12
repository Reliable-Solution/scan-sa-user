import 'package:get/get.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/models/category_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/repositories/category_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/services/category_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';

class CategoryService implements CategoryServiceInterface {
  CategoryService({required this.categoryRepositoryInterface});
  final CategoryRepositoryInterface categoryRepositoryInterface;

  @override
  Future<dynamic> getCategoryList(
    bool allCategory, {
    DataSourceEnum? source,
  }) async {
    return categoryRepositoryInterface.getList(
      allCategory: allCategory,
      categoryList: true,
      source: source,
    );
  }

  @override
  Future<List<CategoryModel>?> getSubCategoryList(String? parentID) async {
    return (await categoryRepositoryInterface.getList(
          id: parentID,
          subCategoryList: true,
        ))
        as List<CategoryModel>?;
  }

  @override
  Future<ItemModel?> getCategoryItemList(
    String? categoryID,
    int offset,
    String type,
  ) async {
    return (await categoryRepositoryInterface.getList(
          id: categoryID,
          offset: offset,
          type: type,
          categoryItemList: true,
        ))
        as ItemModel?;
  }

  @override
  Future<StoreModel?> getCategoryStoreList(
    String? categoryID,
    int offset,
    String type,
  ) async {
    return (await categoryRepositoryInterface.getList(
          id: categoryID,
          offset: offset,
          type: type,
          categoryStoreList: true,
        ))
        as StoreModel?;
  }

  @override
  Future<Response<dynamic>> getSearchData(
    String? query,
    String? categoryID,
    bool isStore,
    String type,
  ) async {
    return categoryRepositoryInterface.getSearchData(
      query,
      categoryID,
      isStore,
      type,
    );
  }

  @override
  Future<bool> saveUserInterests(List<int?> interests) async {
    return categoryRepositoryInterface.saveUserInterests(interests);
  }
}
