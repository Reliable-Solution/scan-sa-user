import 'package:get/get.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/models/category_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';

abstract class CategoryServiceInterface {
  Future<dynamic> getCategoryList(bool allCategory, {DataSourceEnum? source});
  Future<List<CategoryModel>?> getSubCategoryList(String? parentID);
  // Future<ItemModel?> getCategoryItemList(
  //   String? categoryID,
  //   int offset,
  //   String type,
  // );
  Future<ItemModel?> getCategoryItemList(
    String? categoryID,
    int offset,
    String type,
  );

  Future<StoreModel?> getCategoryStoreList(
    String? categoryID,
    int offset,
    String type,
  );
  Future<Response<dynamic>> getSearchData(
    String? query,
    String? categoryID,
    bool isStore,
    String type,
  );
  Future<bool> saveUserInterests(List<int?> interests);
}
