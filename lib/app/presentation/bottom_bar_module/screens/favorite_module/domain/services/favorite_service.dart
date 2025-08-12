import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/domain/repositories/favorite_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/domain/services/favorite_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';

class FavoriteService implements FavoriteServiceInterface {
  FavoriteService({required this.favoriteRepositoryInterface});
  final FavoriteRepositoryInterface<dynamic> favoriteRepositoryInterface;

  @override
  Future<Response<dynamic>> getFavoriteList() async {
    return (await favoriteRepositoryInterface.getList()) as Response;
  }

  @override
  Future<ResponseModel> addFavoriteList(int? id, bool isStore) async {
    return (await favoriteRepositoryInterface.add(
          null,
          isStore: isStore,
          id: id,
        ))
        as ResponseModel;
  }

  @override
  Future<ResponseModel> removeFavoriteList(int? id, bool isStore) async {
    return (await favoriteRepositoryInterface.delete(id, isStore: isStore))
        as ResponseModel;
  }

  @override
  List<Item?> wishItemList(Item item) {
    final wishItemList = <Item?>[];
    wishItemList.add(item);
    for (final zone
        in AddressHelper.getUserAddressFromSharedPref()?.zoneData ??
            <ZoneData>[]) {
      for (final module in zone.modules!) {
        if (module.id == item.moduleId) {
          if (module.pivot!.zoneId == item.zoneId) {
            wishItemList.add(item);
          }
        }
      }
    }
    return wishItemList;
  }

  @override
  List<int?> wishItemIdList(Item item) {
    final wishItemIdList = <int?>[];
    wishItemIdList.add(item.id);
    for (final zone
        in AddressHelper.getUserAddressFromSharedPref()?.zoneData ??
            <ZoneData>[]) {
      for (final module in zone.modules!) {
        if (module.id == item.moduleId) {
          if (module.pivot!.zoneId == item.zoneId) {
            wishItemIdList.add(item.id);
          }
        }
      }
    }
    return wishItemIdList;
  }

  @override
  List<Store?> wishStoreList(dynamic store) {
    final wishStoreList = <Store?>[];
    wishStoreList.add(Store.fromJson(store as Map<String, dynamic>));
    for (final zone
        in AddressHelper.getUserAddressFromSharedPref()?.zoneData ??
            <ZoneData>[]) {
      for (final module in zone.modules!) {
        if (module.id == Store.fromJson(store).moduleId) {
          if (module.pivot!.zoneId == Store.fromJson(store).zoneId) {
            wishStoreList.add(Store.fromJson(store));
          }
        }
      }
    }
    return wishStoreList;
  }

  @override
  List<int?> wishStoreIdList(dynamic store) {
    final wishStoreIdList = <int?>[];
    for (final zone
        in AddressHelper.getUserAddressFromSharedPref()?.zoneData ??
            <ZoneData>[]) {
      for (final module in zone.modules!) {
        if (module.id ==
            Store.fromJson(store as Map<String, dynamic>).moduleId) {
          if (module.pivot!.zoneId == Store.fromJson(store).zoneId) {
            wishStoreIdList.add(Store.fromJson(store).id);
          }
        }
      }
    }
    return wishStoreIdList;
  }
}
