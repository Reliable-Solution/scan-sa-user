import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class StoreRepositoryInterface extends RepositoryInterface<dynamic> {
  @override
  Future<dynamic> getList({
    int? offset,
    bool isStoreList = false,
    String? filterBy,
    bool isPopularStoreList = false,
    String? storeType,
    bool isLatestStoreList = false,
    bool isFeaturedStoreList = false,
    bool isVisitAgainStoreList = false,
    bool isStoreRecommendedItemList = false,
    int? storeId,
    bool isStoreBannerList = false,
    bool isRecommendedStoreList = false,
    bool isTopOfferStoreList = false,
    DataSourceEnum? source,
  });
  Future<Store?> getStoreDetails(
    String storeID,
    bool fromCart,
    String slug,
    String languageCode,
    ModuleModel? module,
    int? cacheModuleId,
    int? moduleId,
  );
  Future<dynamic> getStoreItemList(
    int? storeID,
    int offset,
    int? categoryID,
    String type,
  );
  Future<dynamic> getStoreSearchItemList(
    String searchText,
    String? storeID,
    int offset,
    String type,
    int? categoryID,
  );
  // Future<dynamic> getCartStoreSuggestedItemList(
  //   int? storeId,
  //   String languageCode,
  //   ModuleModel? module,
  //   int? cacheModuleId,
  //   int? moduleId,
  // );
}
