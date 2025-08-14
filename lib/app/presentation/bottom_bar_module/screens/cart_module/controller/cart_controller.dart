import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/item_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/online_cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/services/cart_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/module_helper.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/confirmation_dialog.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/date_converter.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CartController extends GetxController implements GetxService {
  CartController({required this.cartServiceInterface});
  final CartServiceInterface cartServiceInterface;

  RxList<RxInt> cartDummyList = List.generate(2, (index) => 1.obs).obs;

  void changeCartList(int index, bool isMinus) {
    if (isMinus) {
      cartDummyList[index].value--;
      if (cartDummyList[index].value == 0) {
        cartDummyList.removeAt(index);
        if (cartDummyList.isEmpty) Get.back();
      }
    } else {
      cartDummyList[index].value++;
    }
    update();
  }

  int get totalCartValue {
    var value = 0;
    for (final val in cartDummyList) {
      value += val.value;
    }
    return value;
  }

  List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;

  num _subTotal = 0;
  num get subTotal => _subTotal;

  num _itemPrice = 0;
  num get itemPrice => _itemPrice;

  num _itemDiscountPrice = 0;
  num get itemDiscountPrice => _itemDiscountPrice;

  num _addOns = 0;
  num get addOns => _addOns;

  num _variationPrice = 0;
  num get variationPrice => _variationPrice;

  List<List<AddOns>> _addOnsList = [];
  List<List<AddOns>> get addOnsList => _addOnsList;

  List<bool> _availableList = [];
  List<bool> get availableList => _availableList;

  List<String> notAvailableList = [
    'Remove it from my cart',
    'I’ll wait until it’s restocked',
    'Please cancel the order',
    'Call me ASAP',
    'Notify me when it’s back',
  ];
  bool _addCutlery = false;
  bool get addCutlery => _addCutlery;

  int _notAvailableIndex = -1;
  int get notAvailableIndex => _notAvailableIndex;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _needExtraPackage = true;
  bool get needExtraPackage => _needExtraPackage;

  bool _isExpanded = true;
  bool get isExpanded => _isExpanded;

  final int _directAddCartItemIndex = -1;
  int? get directAddCartItemIndex => _directAddCartItemIndex;

  void toggleExtraPackage({bool willUpdate = true}) {
    _needExtraPackage = !_needExtraPackage;
    if (willUpdate) {
      update();
    }
  }

  void setAvailableIndex(int index, {bool willUpdate = true}) {
    _notAvailableIndex = cartServiceInterface.availableSelectedIndex(
      _notAvailableIndex,
      index,
    );
    if (willUpdate) {
      update();
    }
  }

  void updateCutlery({bool willUpdate = true}) {
    _addCutlery = !_addCutlery;
    if (willUpdate) {
      update();
    }
  }

  num calculationCart() {
    _addOnsList = [];
    _availableList = [];
    _itemPrice = 0;
    _itemDiscountPrice = 0;
    _addOns = 0;
    _variationPrice = 0;
    var isFoodVariation = false;
    num variationWithoutDiscountPrice = 0;
    var haveVariation = false;
    for (final cartModel in cartList) {
      isFoodVariation =
          ModuleHelper.getModuleConfig(
            cartModel.item!.moduleType,
          )?.newVariation ??
          false;
      final num? discount = cartModel.item!.storeDiscount == 0
          ? cartModel.item!.discount
          : cartModel.item!.storeDiscount;
      final discountType = cartModel.item!.storeDiscount == 0
          ? cartModel.item!.discountType
          : 'percent';

      final addOnList = cartServiceInterface.prepareAddonList(cartModel);

      _addOnsList.add(addOnList);
      _availableList.add(
        DateConverter.isAvailable(
          cartModel.item!.availableTimeStarts,
          cartModel.item!.availableTimeEnds,
        ),
      );

      _addOns = cartServiceInterface.calculateAddonPrice(
        _addOns,
        addOnList,
        cartModel,
      );

      _variationPrice = cartServiceInterface.calculateVariationPrice(
        isFoodVariation,
        cartModel,
        discount,
        discountType,
        _variationPrice,
      );

      variationWithoutDiscountPrice = cartServiceInterface
          .calculateVariationWithoutDiscountPrice(
            isFoodVariation,
            cartModel,
            variationWithoutDiscountPrice,
          );
      haveVariation = cartServiceInterface.checkVariation(
        isFoodVariation,
        cartModel,
      );

      final price = haveVariation
          ? variationWithoutDiscountPrice
          : (cartModel.item!.price! * cartModel.quantity!);
      final discountPrice = haveVariation
          ? (variationWithoutDiscountPrice - _variationPrice)
          : (price -
                (PriceConverter.convertWithDiscount(
                      cartModel.item!.price,
                      discount,
                      discountType,
                    )! *
                    cartModel.quantity!));

      _itemPrice = _itemPrice + price;
      _itemDiscountPrice = _itemDiscountPrice + discountPrice;

      haveVariation = false;
    }
    if (isFoodVariation) {
      _itemDiscountPrice =
          _itemDiscountPrice +
          (variationWithoutDiscountPrice - _variationPrice);
      _variationPrice = variationWithoutDiscountPrice;
      _subTotal = (_itemPrice - _itemDiscountPrice) + _addOns + _variationPrice;
    } else {
      _subTotal = _itemPrice - _itemDiscountPrice;
    }

    return _subTotal;
  }

  Future<void> addToCart(CartModel cartModel, int? index) async {
    if (index != null && index != -1) {
      _cartList.replaceRange(index, index + 1, [cartModel]);
    } else {
      _cartList.add(cartModel);
    }
    await Get.find<ItemController>().setExistInCart(
      cartModel.item,
      null,
      notify: true,
    );
    await cartServiceInterface.addSharedPrefCartList(_cartList);

    calculationCart();
    update();
  }

  int? getCartId(int cartIndex) {
    return cartServiceInterface.getCartId(cartIndex, _cartList);
  }

  Future<void> setQuantity(
    bool isIncrement,
    int cartIndex,
    int? stock,
    int? quantityLimit,
  ) async {
    EasyLoading.load();

    _cartList[cartIndex]
        .quantity = await cartServiceInterface.decideItemQuantity(
      isIncrement,
      _cartList,
      cartIndex,
      stock,
      quantityLimit,
      Get.find<GlobalController>().configModel!.moduleConfig!.module!.stock!,
    );

    final discountedPrice = await cartServiceInterface.calculateDiscountedPrice(
      _cartList[cartIndex],
      _cartList[cartIndex].quantity!,
      ModuleHelper.getModuleConfig(
            _cartList[cartIndex].item!.moduleType,
          )?.newVariation ??
          false,
    );
    if (ModuleHelper.getModuleConfig(
          _cartList[cartIndex].item!.moduleType,
        )?.newVariation ??
        false) {
      await Get.find<ItemController>().setExistInCart(
        _cartList[cartIndex].item,
        null,
        notify: true,
      );
    }
    '===>>> _cartList[cartIndex].quantity ${_cartList[cartIndex].quantity}'
        .print;

    await updateCartQuantityOnline(
      _cartList[cartIndex].id!,
      discountedPrice,
      _cartList[cartIndex].quantity!,
    );
  }

  Future<void> removeFromCart(int index, {Item? item}) async {
    EasyLoading.load();
    final cartId = _cartList[index].id!;
    _cartList.removeAt(index);
    update();
    Get.find<ItemController>().cartIndexSet();
    await removeCartItemOnline(cartId, item: item);
    if (Get.find<ItemController>().item != null) {
      Get.find<ItemController>().cartIndexSet();
    }
    EasyLoading.dismiss();
  }

  Future<void> clearCartList({bool canRemoveOnline = true}) async {
    _cartList = [];
    if ((GlobalHelper.isLoggedIn() || GlobalHelper.isGuestLoggedIn()) &&
        (ModuleHelper.getModule() != null ||
            ModuleHelper.getCacheModule() != null) &&
        canRemoveOnline) {
      await clearCartOnline();
    }
  }

  int isExistInCart(
    int? itemID,
    String variationType,
    bool isUpdate,
    int? cartIndex,
  ) {
    '==>> $variationType ==. '.print;
    return cartServiceInterface.isExistInCart(
      _cartList,
      itemID,
      variationType,
      isUpdate,
      cartIndex,
    );
  }

  bool existAnotherStoreItem(int? storeID, int? moduleId) {
    return cartServiceInterface.existAnotherStoreItem(
      storeID,
      moduleId,
      _cartList,
    );
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }

  Future<bool> addToCartOnline(OnlineCart cart) async {
    _isLoading = true;
    var success = false;
    update();
    final onlineCartList = await cartServiceInterface.addToCartOnline(cart);
    if (onlineCartList != null) {
      _cartList = [];
      _cartList.addAll(
        cartServiceInterface.formatOnlineCartToLocalCart(
          onlineCartModel: onlineCartList,
        ),
      );
      calculationCart();
      success = true;
    }
    _isLoading = false;
    update();

    return success;
  }

  Future<bool> updateCartOnline(OnlineCart cart) async {
    _isLoading = true;
    var success = false;
    update();
    final onlineCartList = await cartServiceInterface.updateCartOnline(cart);
    if (onlineCartList != null) {
      _cartList = [];
      _cartList.addAll(
        cartServiceInterface.formatOnlineCartToLocalCart(
          onlineCartModel: onlineCartList,
        ),
      );
      calculationCart();
      success = true;
    }
    _isLoading = false;
    update();

    return success;
  }

  Future<void> updateCartQuantityOnline(
    int cartId,
    num price,
    int quantity,
  ) async {
    _isLoading = true;
    update();
    final success = await cartServiceInterface.updateCartQuantityOnline(
      cartId,
      price,
      quantity,
    );
    if (success) {
      await getCartDataOnline();
      calculationCart();
      await Future.delayed(const Duration(milliseconds: 200));
    }
    _isLoading = false;
    update();
  }

  Future<void> getCartDataOnline() async {
    // if (ModuleHelper.getModule() != null ||
    //     ModuleHelper.getCacheModule() != null) {
    _isLoading = true;
    final onlineCartList = await cartServiceInterface.getCartDataOnline();
    if (onlineCartList != null) {
      _cartList = [];
      _cartList.addAll(
        cartServiceInterface.formatOnlineCartToLocalCart(
          onlineCartModel: onlineCartList,
        ),
      );
      calculationCart();
    }
    _isLoading = false;
    update();
    // }
    EasyLoading.dismiss();
  }

  Future<bool> removeCartItemOnline(int cartId, {Item? item}) async {
    _isLoading = true;
    update();
    final success = await cartServiceInterface.removeCartItemOnline(cartId);
    if (success) {
      await getCartDataOnline();
      if (item != null) {
        await Get.find<ItemController>().setExistInCart(
          item,
          null,
          notify: true,
        );
      }
    }
    _isLoading = false;
    update();
    return success;
  }

  Future<bool> clearCartOnline() async {
    EasyLoading.load();
    final success = await cartServiceInterface.clearCartOnline();
    if (success) {
      await getCartDataOnline();
    }
    EasyLoading.dismiss();
    return success;
  }

  int cartQuantity(int itemId) {
    return cartServiceInterface.cartQuantity(itemId, _cartList);
  }

  String cartVariant(int itemId) {
    return cartServiceInterface.cartVariant(itemId, _cartList);
  }

  void setExpanded(bool setExpand) {
    _isExpanded = setExpand;
    update();
  }

  Future<void> itemDirectlyAddToCart(
    Item? item,
    BuildContext context, {
    bool inStore = false,
    List<Variation>? variation,
    bool isCampaign = false,
  }) async {
    EasyLoading.load();
    if (item != null) {
      final num price = item.price!;
      final num discount = item.discount!;
      final discountPrice = PriceConverter.convertWithDiscount(
        price,
        discount,
        item.discountType,
      )!;

      final cartModel = CartModel(
        null,
        price,
        discount,
        variation ?? [],
        [],
        price - discountPrice,
        1,
        [],
        [],
        isCampaign,
        item.stock,
        item,
        item.quantityLimit,
      );

      final onlineCart = OnlineCart(
        null,
        isCampaign ? null : item.id,
        isCampaign ? item.id : null,
        price.toString(),
        '',
        variation ?? [],
        ModuleHelper.getModuleConfig(item.moduleType)?.newVariation ?? false
            ? []
            : null,
        1,
        [],
        [],
        [],
        'Item',
      );
      Get.find<GlobalController>()
          .configModel!
          .moduleConfig!
          .module!
          .stock!
          .print;
      if (Get.find<GlobalController>()
              .configModel!
              .moduleConfig!
              .module!
              .stock! &&
          item.stock! <= 0) {
        EasyLoading.dismiss();
        showCustomSnackBar('out_of_stock'.tr);
      } else if (Get.find<CartController>().existAnotherStoreItem(
        cartModel.item!.storeId,
        ModuleHelper.getModule() != null
            ? ModuleHelper.getModule()?.id
            : ModuleHelper.getCacheModule()?.id,
      )) {
        EasyLoading.dismiss();
        await Get.dialog(
          ConfirmationDialog(
            icon: AppIcons.warning,
            title: 'are_you_sure_to_reset'.tr,
            description:
                Get.find<GlobalController>()
                    .configModel!
                    .moduleConfig!
                    .module!
                    .showRestaurantText!
                ? 'if_you_continue'.tr
                : 'if_you_continue_without_another_store'.tr,
            onYesPressed: () {
              Get.find<CartController>().clearCartOnline().then((
                success,
              ) async {
                if (success) {
                  await Get.find<CartController>().addToCartOnline(onlineCart);
                  Get.back();
                  showCartSnackBar();
                }
              });
            },
          ),
          barrierDismissible: false,
        );
      } else {
        await Get.find<CartController>().addToCartOnline(onlineCart);
      }
    }
    EasyLoading.dismiss();
  }

  String? setupVariationText({required CartModel cart}) {
    String? variationText = '';

    if (Get.find<GlobalController>()
            .getModuleConfig(cart.item!.moduleType)
            ?.newVariation ??
        false) {
      if (cart.foodVariations!.isNotEmpty) {
        for (var index = 0; index < cart.foodVariations!.length; index++) {
          if (cart.foodVariations![index].contains(true)) {
            variationText =
                '${variationText!}${variationText.isNotEmpty ? ', ' : ''}${cart.item!.foodVariations![index].name} (';
            for (var i = 0; i < cart.foodVariations![index].length; i++) {
              if (cart.foodVariations![index][i]!) {
                variationText =
                    '${variationText!}${variationText.endsWith('(') ? '' : ', '}${cart.item!.foodVariations![index].variationValues![i].level}';
              }
            }
            variationText = '${variationText!})';
          }
        }
      }
    } else {
      if (cart.variation!.isNotEmpty) {
        final variationTypes = cart.variation![0].type!.split('-');
        if (variationTypes.length == cart.item!.choiceOptions!.length) {
          var index0 = 0;
          for (final choice in cart.item!.choiceOptions!) {
            variationText =
                '${variationText!}${(index0 == 0) ? '' : ',  '}${choice.title} - ${variationTypes[index0]}';
            index0 = index0 + 1;
          }
        } else {
          variationText = cart.item!.variations![0].type;
        }
      }
    }
    return variationText;
  }

  num? calculatePriceWithVariation({
    required Item? item,
    String? selectedVariant,
  }) {
    '===>>> calculatePriceWithVariation ${item?.variations?.where((e) => e.type == selectedVariant).firstOrNull?.price}'
        .print;
    final variantPrice =
        item?.variations
            ?.where((e) => e.type == selectedVariant)
            .firstOrNull
            ?.price ??
        item?.price ??
        0;
    return variantPrice;
  }

  num cartTotalPrice() {
    num total = 0;
    for (final cartData in cartList) {
      total +=
          (calculatePriceWithVariation(
                item: cartData.item,
                selectedVariant: cartData.variation?.firstOrNull?.type,
              ) ??
              0) *
          (cartData.quantity ?? 0);
    }
    return total;
  }
}

void showCartSnackBar() {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.only(
        right: Dimensions.paddingSizeSmall,
        top: Dimensions.paddingSizeSmall,
        bottom: Dimensions.paddingSizeSmall,
        left: Dimensions.paddingSizeSmall,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      ),
      content: const Text(
        'Item added to cart successfully',
        // style: robotoMedium.copyWith(color: Colors.white),
      ),
      action: SnackBarAction(
        label: 'View cart'.tr,
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}
