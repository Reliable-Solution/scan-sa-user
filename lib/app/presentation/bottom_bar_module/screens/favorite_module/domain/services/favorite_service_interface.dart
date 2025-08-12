import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';

abstract class FavoriteServiceInterface {
  Future<Response<dynamic>> getFavoriteList();
  Future<ResponseModel> addFavoriteList(int? id, bool isStore);
  Future<ResponseModel> removeFavoriteList(int? id, bool isStore);
  List<Item?> wishItemList(Item item);
  List<int?> wishItemIdList(Item item);
  List<Store?> wishStoreList(dynamic store);
  List<int?> wishStoreIdList(dynamic store);
}
