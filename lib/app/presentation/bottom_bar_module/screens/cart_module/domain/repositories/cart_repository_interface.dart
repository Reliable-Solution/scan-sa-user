import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/cart_model.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class CartRepositoryInterface<OnlineCart>
    extends RepositoryInterface<OnlineCart> {
  Future<void> addSharedPrefCartList(List<CartModel> cartProductList);
  @override
  Future<dynamic> update(
    Map<String, dynamic> body,
    int? id, {
    num price,
    int quantity,
    bool isUpdateQty = false,
  });
  @override
  Future<bool> delete(int? id, {bool isRemoveAll = false});
}
