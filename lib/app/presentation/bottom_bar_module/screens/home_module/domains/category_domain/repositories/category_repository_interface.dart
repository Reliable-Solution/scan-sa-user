import 'package:get/get.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class CategoryRepositoryInterface
    implements RepositoryInterface<dynamic> {
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
  });
  Future<Response<dynamic>> getSearchData(
    String? query,
    String? categoryID,
    bool isStore,
    String type,
  );
  Future<bool> saveUserInterests(List<int?> interests);
}
