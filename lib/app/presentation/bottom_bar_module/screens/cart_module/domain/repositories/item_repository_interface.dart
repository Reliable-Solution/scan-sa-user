import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/basic_medicine_model.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class ItemRepositoryInterface implements RepositoryInterface<dynamic> {
  // Future<dynamic> getPopularItemList(String type);
  @override
  Future<dynamic> getList({
    int? offset,
    String? type,
    bool isPopularItem = false,
    bool isReviewedItem = false,
    bool isFeaturedCategoryItems = false,
    bool isRecommendedItems = false,
    bool isCommonConditions = false,
    bool isDiscountedItems = false,
    DataSourceEnum? source,
  });
  // Future<dynamic> getReviewedItemList(String type);
  // Future<dynamic> getFeaturedCategoriesItemList();
  // Future<dynamic> getRecommendedItemList(String type);
  // Future<dynamic> getDiscountedItemList();
  // Future<dynamic> getItemDetails(int? itemID);
  Future<BasicMedicineModel?> getBasicMedicine(DataSourceEnum source);
  @override
  Future<dynamic> get(String? id, {bool isConditionWiseItem = false});
  // Future<dynamic> getCommonConditions();
  // Future<dynamic> getConditionsWiseItem(int id);
}
