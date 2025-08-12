import 'dart:convert';

import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/online_cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/repositories/cart_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/location_module/module_helper.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository implements CartRepositoryInterface<OnlineCart> {
  CartRepository({required this.apiClient, required this.sharedPreferences});
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  @override
  Future<void> addSharedPrefCartList(List<CartModel> cartProductList) async {
    var carts = <String>[];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList) ?? [];
    }
    final cartStringList = <String>[];
    for (final cartString in carts) {
      final cartModel = CartModel.fromJson(
        jsonDecode(cartString) as Map<String, dynamic>,
      );
      if (cartModel.item!.moduleId != _getModuleId()) {
        cartStringList.add(cartString);
      }
    }
    for (final cartModel in cartProductList) {
      cartStringList.add(jsonEncode(cartModel.toJson()));
    }
    await sharedPreferences.setStringList(
      AppConstants.cartList,
      cartStringList,
    );
  }

  int _getModuleId() {
    return ModuleHelper.getModule()?.id ??
        ModuleHelper.getCacheModule()?.id ??
        0;
  }

  @override
  Future<List<OnlineCartModel>?> add(OnlineCart cart) async {
    return _addToCartOnline(cart);
  }

  Future<List<OnlineCartModel>?> _addToCartOnline(OnlineCart cart) async {
    List<OnlineCartModel>? onlineCartList;
    final response = await apiClient.postData(
      '${AppConstants.addCartUri}${!GlobalHelper.isLoggedIn() ? '?guest_id=${GlobalHelper.getGuestId()}' : ''}',
      cart.toJson(),
    );
    if (response.statusCode == 200) {
      onlineCartList = [];
      response.body.forEach(
        (cart) => onlineCartList!.add(
          OnlineCartModel.fromJson(cart as Map<String, dynamic>),
        ),
      );
    }
    return onlineCartList;
  }

  @override
  Future<bool> delete(int? id, {bool isRemoveAll = false}) async {
    if (isRemoveAll) {
      return _clearCartOnline();
    } else {
      return _removeCartItemOnline(id!);
    }
  }

  Future<bool> _removeCartItemOnline(int cartId) async {
    final response = await apiClient.deleteData(
      '${AppConstants.removeItemCartUri}?cart_id=$cartId${!GlobalHelper.isLoggedIn() ? '&guest_id=${GlobalHelper.getGuestId()}' : ''}',
    );
    return (response.statusCode == 200);
  }

  Future<bool> _clearCartOnline() async {
    final response = await apiClient.deleteData(
      '${AppConstants.removeAllCartUri}${!GlobalHelper.isLoggedIn() ? '?guest_id=${GlobalHelper.getGuestId()}' : ''}',
    );
    return (response.statusCode == 200);
  }

  @override
  Future<void> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<List<OnlineCartModel>?> getList({int? offset}) async {
    return _getCartDataOnline();
  }

  Future<List<OnlineCartModel>?> _getCartDataOnline() async {
    List<OnlineCartModel>? onlineCartList;
    // final header = <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   AppConstants.localizationKey: AppConstants.languages[0].languageCode!,
    //   AppConstants.moduleId: '${ModuleHelper.getCacheModule()?.id}',
    //   'Authorization':
    //       'Bearer ${sharedPreferences.getString(AppConstants.token)}',
    // };

    final response = await apiClient.getData(
      '${AppConstants.getCartListUri}${!GlobalHelper.isLoggedIn() ? '?guest_id=${GlobalHelper.getGuestId()}' : ''}',
      // headers: ModuleHelper.getModule()?.id == null ? header : null,
    );
    if (response.statusCode == 200) {
      onlineCartList = [];
      response.body.forEach(
        (cart) => onlineCartList!.add(
          OnlineCartModel.fromJson(cart as Map<String, dynamic>),
        ),
      );
    }
    return onlineCartList;
  }

  @override
  Future<dynamic> update(
    Map<String, dynamic> body,
    int? id, {
    num? price,
    int? quantity,
    bool isUpdateQty = false,
  }) async {
    if (isUpdateQty) {
      return _updateCartQuantityOnline(id!, price!, quantity!);
    } else {
      return _updateCartOnline(body);
    }
  }

  Future<List<OnlineCartModel>?> _updateCartOnline(
    Map<String, dynamic> body,
  ) async {
    List<OnlineCartModel>? onlineCartList;
    final response = await apiClient.postData(
      '${AppConstants.updateCartUri}${!GlobalHelper.isLoggedIn() ? '?guest_id=${GlobalHelper.getGuestId()}' : ''}',
      body,
    );
    if (response.statusCode == 200) {
      onlineCartList = [];
      response.body.forEach(
        (cart) => onlineCartList!.add(
          OnlineCartModel.fromJson(cart as Map<String, dynamic>),
        ),
      );
    }
    return onlineCartList;
  }

  Future<bool> _updateCartQuantityOnline(
    int cartId,
    num price,
    int quantity,
  ) async {
    final data = <String, dynamic>{
      'cart_id': cartId,
      'price': price,
      'quantity': quantity,
    };
    final response = await apiClient.postData(
      '${AppConstants.updateCartUri}${!GlobalHelper.isLoggedIn() ? '?guest_id=${GlobalHelper.getGuestId()}' : ''}',
      data,
    );
    return (response.statusCode == 200);
  }
}
