import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/domain/services/favorite_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class FavoriteController extends GetxController implements GetxService {
  FavoriteController({required this.favoriteServiceInterface}) {
    getFavoriteList(isLoad: true);
  }
  final FavoriteServiceInterface favoriteServiceInterface;

  List<Item?> _wishItemList = [];
  List<Item?> get wishItemList => _wishItemList;

  List<Store?> _wishStoreList = [];
  List<Store?> get wishStoreList => _wishStoreList;

  List<int?> _wishItemIdList = [];
  List<int?> get wishItemIdList => _wishItemIdList;

  List<int?> _wishStoreIdList = [];
  List<int?> get wishStoreIdList => _wishStoreIdList;

  bool _isRemoving = false;
  bool get isRemoving => _isRemoving;

  bool isFav(int id) => _wishStoreIdList.contains(id);

  Future<void> addToFavoriteList(
    Item? product,
    int? storeID,
    bool isStore, {
    bool getXSnackBar = false,
  }) async {
    _isRemoving = true;
    update();
    if (isStore) {
      _wishStoreList = [];
      _wishStoreIdList.add(storeID);
      _wishStoreList.add(Store());
    } else {
      _wishItemList = [];
      _wishItemList.add(product);
      _wishItemIdList.add(product!.id);
    }
    final responseModel = await favoriteServiceInterface.addFavoriteList(
      isStore ? storeID : product!.id,
      isStore,
    );
    if (responseModel.isSuccess) {
      showCustomSnackBar(
        responseModel.message,
        isError: false,
        getXSnackBar: getXSnackBar,
      );
    } else {
      if (isStore) {
        for (final storeId in _wishStoreIdList) {
          if (storeId == storeID) {
            _wishStoreIdList.removeAt(_wishStoreIdList.indexOf(storeId));
          }
        }
      } else {
        for (final productId in _wishItemIdList) {
          if (productId == product!.id) {
            _wishItemIdList.removeAt(_wishItemIdList.indexOf(productId));
          }
        }
      }
      showCustomSnackBar(responseModel.message, getXSnackBar: getXSnackBar);
    }
    _isRemoving = false;
    update();
  }

  Future<void> removeFromFavoriteList(
    int? id,
    bool isStore, {
    bool getXSnackBar = false,
  }) async {
    _isRemoving = true;
    update();

    var idIndex = -1;
    int? storeId;
    int? itemId;
    Store? store;
    Item? item;
    if (isStore) {
      idIndex = _wishStoreIdList.indexOf(id);
      if (idIndex != -1) {
        storeId = id;
        _wishStoreIdList.removeAt(idIndex);
        if (idIndex < _wishStoreList.length) {
          store = _wishStoreList[idIndex];
          _wishStoreList.removeAt(idIndex);
        }
      }
    } else {
      idIndex = _wishItemIdList.indexOf(id);
      if (idIndex != -1) {
        itemId = id;
        _wishItemIdList.removeAt(idIndex);
        item = _wishItemList[idIndex];
        _wishItemList.removeAt(idIndex);
      }
    }
    final responseModel = await favoriteServiceInterface.removeFavoriteList(
      id,
      isStore,
    );
    if (responseModel.isSuccess) {
      showCustomSnackBar(
        responseModel.message,
        isError: false,
        getXSnackBar: getXSnackBar,
      );
    } else {
      showCustomSnackBar(responseModel.message, getXSnackBar: getXSnackBar);
      if (isStore) {
        _wishStoreIdList.add(storeId);
        _wishStoreList.add(store);
      } else {
        _wishItemIdList.add(itemId);
        _wishItemList.add(item);
      }
    }
    _isRemoving = false;
    update();
  }

  bool isFavoriteLoad = false;

  Future<void> getFavoriteList({bool isLoad = false}) async {
    if (isLoad) {
      isFavoriteLoad = true;
      update();
    }
    try {
      final response = await favoriteServiceInterface.getFavoriteList();
      if (response.statusCode == 200) {
        update();
        _wishItemList = [];
        _wishStoreList = [];
        _wishStoreIdList = [];
        _wishItemIdList = [];

        if (response.body['item'] != null) {
          response.body['item'].forEach((item) async {
            if (item['module_type'] == null ||
                !(Get.find<GlobalController>()
                        .getModuleConfig(item['module_type'] as String?)
                        ?.newVariation ??
                    false) ||
                ((item['variations'] as List?)?.isEmpty ?? true) ||
                ((item['food_variations'] as List?)?.isNotEmpty ?? false)) {
              final i = Item.fromJson(item as Map<String, dynamic>);
              _wishItemList.addAll(favoriteServiceInterface.wishItemList(i));
              _wishItemIdList.addAll(
                favoriteServiceInterface.wishItemIdList(i),
              );
            }
          });
        }

        response.body['store'].forEach((store) async {
          // if (Get.find<GlobalController>().module == null) {
          _wishStoreList.addAll(favoriteServiceInterface.wishStoreList(store));
          _wishStoreIdList.addAll(_wishStoreList.map((e) => e?.id));
          '===>>> response.body ${_wishStoreList.length}'.print;
          // } else {
          //   Store? s;
          //   try {
          //     s = Store.fromJson(store as Map<String, dynamic>);
          //   } catch (e) {
          //     debugPrint('exception create in store list create : $e');
          //   }
          //   if (s != null) {
          //     _wishStoreList!.add(s);
          //     _wishStoreIdList.add(s.id);
          //   }
          // }
        });
      }
    } finally {
      isFavoriteLoad = false;
      update();
    }
  }

  void removeFavorite() {
    _wishItemIdList = [];
    _wishStoreIdList = [];
  }
}
