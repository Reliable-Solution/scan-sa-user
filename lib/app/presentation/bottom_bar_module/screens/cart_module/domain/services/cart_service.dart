import 'package:get/get_utils/get_utils.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/online_cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/repositories/cart_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/services/cart_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/module_helper.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CartService implements CartServiceInterface {
  CartService({required this.cartRepositoryInterface});
  final CartRepositoryInterface<dynamic> cartRepositoryInterface;

  @override
  Future<List<OnlineCartModel>?> addToCartOnline(OnlineCart cart) async {
    return (await cartRepositoryInterface.add(cart)) as List<OnlineCartModel>?;
  }

  @override
  Future<List<OnlineCartModel>?> updateCartOnline(OnlineCart cart) async {
    return (await cartRepositoryInterface.update(cart.toJson(), null))
        as List<OnlineCartModel>?;
  }

  @override
  Future<bool> updateCartQuantityOnline(
    int cartId,
    num price,
    int quantity,
  ) async {
    return (await cartRepositoryInterface.update(
          {},
          cartId,
          price: price,
          quantity: quantity,
          isUpdateQty: true,
        ))
        as bool;
  }

  @override
  Future<List<OnlineCartModel>?> getCartDataOnline() async {
    return (await cartRepositoryInterface.getList()) as List<OnlineCartModel>?;
  }

  @override
  Future<bool> removeCartItemOnline(int cartId) async {
    return cartRepositoryInterface.delete(cartId);
  }

  @override
  Future<bool> clearCartOnline() async {
    return cartRepositoryInterface.delete(null, isRemoveAll: true);
  }

  @override
  int availableSelectedIndex(int selectedIndex, int index) {
    var notAvailableIndex = selectedIndex;
    if (notAvailableIndex == index) {
      notAvailableIndex = -1;
    } else {
      notAvailableIndex = index;
    }
    return notAvailableIndex;
  }

  @override
  ModuleModel? forcefullySetModule(
    ModuleModel? selectedModule,
    List<ModuleModel>? moduleList,
    int moduleId,
  ) {
    ModuleModel? module;
    if (selectedModule == null && moduleList != null) {
      for (final m in moduleList) {
        if (m.id == moduleId) {
          module = m;
          break;
        }
      }
    }
    return module;
  }

  @override
  List<AddOns> prepareAddonList(CartModel cartModel) {
    final addOnList = <AddOns>[];
    for (final addOnId in cartModel.addOnIds ?? []) {
      for (final addOns in cartModel.item?.addOns ?? <AddOns>[]) {
        if (addOns.id == addOnId.id) {
          addOnList.add(addOns);
          break;
        }
      }
    }
    return addOnList;
  }

  @override
  num calculateAddonPrice(
    num addOns,
    List<AddOns> addOnList,
    CartModel cartModel,
  ) {
    var addonPrice = addOns;
    for (var index = 0; index < addOnList.length; index++) {
      addonPrice =
          addonPrice +
          (addOnList[index].price! * cartModel.addOnIds![index].quantity!);
    }
    return addonPrice;
  }

  @override
  num calculateVariationPrice(
    bool isFoodVariation,
    CartModel cartModel,
    num? discount,
    String? discountType,
    num variationPrice,
  ) {
    var price = variationPrice;
    if (isFoodVariation) {
      for (
        var index = 0;
        index < cartModel.item!.foodVariations!.length;
        index++
      ) {
        for (
          var i = 0;
          i < cartModel.item!.foodVariations![index].variationValues!.length;
          i++
        ) {
          if (cartModel.foodVariations![index][i]!) {
            price +=
                PriceConverter.convertWithDiscount(
                  cartModel
                      .item!
                      .foodVariations![index]
                      .variationValues![i]
                      .optionPrice,
                  discount,
                  discountType,
                  isFoodVariation: true,
                )! *
                cartModel.quantity!;
          }
        }
      }
    } else {
      var variationType = '';
      for (var i = 0; i < cartModel.variation!.length; i++) {
        variationType = cartModel.variation![i].type!;
      }

      for (final variation in cartModel.item!.variations!) {
        if (variation.type == variationType) {
          price =
              PriceConverter.convertWithDiscount(
                variation.price,
                discount,
                discountType,
              )! *
              cartModel.quantity!;
          break;
        }
      }
    }
    return price;
  }

  @override
  num calculateVariationWithoutDiscountPrice(
    bool isFoodVariation,
    CartModel cartModel,
    num variationWithoutDiscount,
  ) {
    var variationWithoutDiscountPrice = variationWithoutDiscount;
    if (!isFoodVariation) {
      var variationType = '';
      for (var i = 0; i < cartModel.variation!.length; i++) {
        variationType = cartModel.variation![i].type!;
      }
      for (final variation in cartModel.item!.variations!) {
        if (variation.type == variationType) {
          variationWithoutDiscountPrice =
              variation.price! * cartModel.quantity!;
          break;
        }
      }
    } else {
      for (
        var index = 0;
        index < cartModel.item!.foodVariations!.length;
        index++
      ) {
        for (
          var i = 0;
          i < cartModel.item!.foodVariations![index].variationValues!.length;
          i++
        ) {
          if (cartModel.foodVariations![index][i]!) {
            variationWithoutDiscountPrice +=
                cartModel
                    .item!
                    .foodVariations![index]
                    .variationValues![i]
                    .optionPrice! *
                cartModel.quantity!;
          }
        }
      }
    }
    return variationWithoutDiscountPrice;
  }

  @override
  bool checkVariation(bool isFoodVariation, CartModel cartModel) {
    var haveVariation = false;
    if (!isFoodVariation) {
      var variationType = '';
      for (var i = 0; i < cartModel.variation!.length; i++) {
        variationType = cartModel.variation![i].type!;
      }
      for (final variation in cartModel.item!.variations!) {
        if (variation.type == variationType) {
          haveVariation = true;
          break;
        }
      }
    }
    return haveVariation;
  }

  @override
  Future<void> addSharedPrefCartList(List<CartModel> cartProductList) async {
    await cartRepositoryInterface.addSharedPrefCartList(cartProductList);
  }

  @override
  int? getCartId(int cartIndex, List<CartModel> cartList) {
    if (cartIndex != -1) {
      return cartList.isNotEmpty ? cartList[cartIndex].id : null;
    } else {
      return null;
    }
  }

  @override
  Future<int> decideItemQuantity(
    bool isIncrement,
    List<CartModel> cartList,
    int cartIndex,
    int? stock,
    int? quantityLimit,
    bool moduleStock,
  ) async {
    var quantity = cartList[cartIndex].quantity!;
    '===>>>> quantity ===>> $quantity'.print;
    if (isIncrement) {
      if (moduleStock && cartList[cartIndex].quantity! >= stock!) {
        showCustomSnackBar('out_of_stock'.tr);
      } else if (quantityLimit != null) {
        if (quantity >= quantityLimit && quantityLimit != 0) {
          showCustomSnackBar('${'maximum_quantity_limit'.tr} $quantityLimit');
        } else {
          quantity = quantity + 1;
        }
      } else {
        quantity = quantity + 1;
      }
    } else {
      quantity = quantity - 1;
    }
    '===>>>> quantity $quantity'.print;
    return quantity;
  }

  @override
  Future<num> calculateDiscountedPrice(
    CartModel cartModel,
    int quantity,
    bool isFoodVariation,
  ) async {
    final num? discount = cartModel.item!.storeDiscount == 0
        ? cartModel.item!.discount
        : cartModel.item!.storeDiscount;
    final discountType = cartModel.item!.storeDiscount == 0
        ? cartModel.item!.discountType
        : 'percent';
    num variationPrice = 0;
    num addonPrice = 0;

    if (isFoodVariation) {
      for (
        var index = 0;
        index < cartModel.item!.foodVariations!.length;
        index++
      ) {
        for (
          var i = 0;
          i < cartModel.item!.foodVariations![index].variationValues!.length;
          i++
        ) {
          if (cartModel.foodVariations![index][i]!) {
            variationPrice +=
                PriceConverter.convertWithDiscount(
                  cartModel
                      .item!
                      .foodVariations![index]
                      .variationValues![i]
                      .optionPrice,
                  discount,
                  discountType,
                  isFoodVariation: true,
                )! *
                cartModel.quantity!;
          }
        }
      }

      final addOnList = <AddOns>[];
      for (final addOnId in cartModel.addOnIds!) {
        for (final addOns in cartModel.item!.addOns!) {
          if (addOns.id == addOnId.id) {
            addOnList.add(addOns);
            break;
          }
        }
      }
      for (var index = 0; index < addOnList.length; index++) {
        addonPrice =
            addonPrice +
            (addOnList[index].price! * cartModel.addOnIds![index].quantity!);
      }
    }
    final num discountedPrice =
        addonPrice +
        variationPrice +
        (cartModel.item!.price! * quantity) -
        PriceConverter.calculation(
          cartModel.item!.price!,
          discount,
          discountType!,
          quantity,
        );
    return discountedPrice;
  }

  @override
  List<CartModel> formatOnlineCartToLocalCart({
    required List<OnlineCartModel> onlineCartModel,
  }) {
    final cartList = <CartModel>[];
    for (final cart in onlineCartModel) {
      final num price = cart.item!.price!;
      final num discount = cart.item!.storeDiscount == 0
          ? cart.item!.discount!
          : cart.item!.storeDiscount!;
      final discountType = (cart.item!.storeDiscount == 0)
          ? cart.item!.discountType
          : 'percent';
      var discountedPrice = PriceConverter.convertWithDiscount(
        price,
        discount,
        discountType,
      )!;

      final discountAmount = price - discountedPrice;
      final quantity = cart.quantity;
      final stock = cart.item!.stock ?? 0;

      final selectedFoodVariations = <List<bool?>>[];
      final collapsVariation = <bool>[];

      if (cart.item!.moduleType == 'food') {
        for (
          var index = 0;
          index < cart.item!.foodVariations!.length;
          index++
        ) {
          selectedFoodVariations.add([]);
          collapsVariation.add(true);
          for (
            var i = 0;
            i < cart.item!.foodVariations![index].variationValues!.length;
            i++
          ) {
            if (cart
                    .item!
                    .foodVariations![index]
                    .variationValues![i]
                    .isSelected ??
                false) {
              selectedFoodVariations[index].add(true);
            } else {
              selectedFoodVariations[index].add(false);
            }
          }
        }
      } else {
        final variationType =
            cart.productVariation != null && cart.productVariation!.isNotEmpty
            ? cart.productVariation![0].type!
            : '';
        for (final variation in cart.item!.variations!) {
          if (variation.type == variationType) {
            discountedPrice =
                PriceConverter.convertWithDiscount(
                  variation.price,
                  discount,
                  discountType,
                )! *
                cart.quantity!;
            break;
          }
        }
      }

      final addOnIdList = <AddOn>[];
      final addOnsList = <AddOns>[];
      for (var index = 0; index < cart.addOnIds!.length; index++) {
        addOnIdList.add(
          AddOn(id: cart.addOnIds![index], quantity: cart.addOnQtys![index]),
        );
        for (var i = 0; i < cart.item!.addOns!.length; i++) {
          if (cart.addOnIds![index] == cart.item!.addOns![i].id) {
            addOnsList.add(
              AddOns(
                id: cart.item!.addOns![i].id,
                name: cart.item!.addOns![i].name,
                price: cart.item!.addOns![i].price,
              ),
            );
          }
        }
      }

      final quantityLimit = cart.item!.quantityLimit;

      cartList.add(
        CartModel(
          cart.id,
          price,
          discountedPrice,
          cart.productVariation ?? cart.foodVariation ?? [],
          selectedFoodVariations,
          discountAmount,
          quantity,
          addOnIdList,
          addOnsList,
          false,
          stock,
          cart.item,
          quantityLimit,
        ),
      );
    }

    return cartList;
  }

  @override
  int isExistInCart(
    List<CartModel> cartList,
    int? itemID,
    String variationType,
    bool isUpdate,
    int? cartIndex,
  ) {
    for (var index = 0; index < cartList.length; index++) {
      if (cartList[index].item!.id == itemID &&
          ((variationType.isEmpty) ||
              (cartList[index].variation?.firstOrNull?.type ==
                  variationType))) {
        if (isUpdate && index == cartIndex) {
          return -1;
        } else {
          return index;
        }
      }
    }
    return -1;
  }

  @override
  bool existAnotherStoreItem(
    int? storeID,
    int? moduleId,
    List<CartModel> cartList,
  ) {
    for (final cartModel in cartList) {
      if (cartModel.item!.storeId != storeID) {
        return true;
      }
    }
    return false;
  }

  @override
  int cartQuantity(int itemId, List<CartModel> cartList) {
    var quantity = 0;
    for (final cart in cartList) {
      if (cart.item!.id == itemId) {
        quantity += cart.quantity!;
      }
    }

    return quantity;
  }

  @override
  String cartVariant(int itemId, List<CartModel> cartList) {
    var variant = '';
    for (final cart in cartList) {
      if (cart.item!.id == itemId) {
        if (!(ModuleHelper.getModuleConfig(
              cart.item!.moduleType,
            )?.newVariation ??
            false)) {
          variant = (cart.variation != null && cart.variation!.isNotEmpty)
              ? cart.variation![0].type!
              : '';
        }
      }
    }
    return variant;
  }
}
