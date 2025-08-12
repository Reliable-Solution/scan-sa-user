import 'package:get/get.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/basic_medicine_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/common_condition_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/online_cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/repositories/item_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/services/item_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/module_helper.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';

class ItemService implements ItemServiceInterface {
  ItemService({required this.itemRepositoryInterface});
  final ItemRepositoryInterface itemRepositoryInterface;

  @override
  Future<List<Item>?> getPopularItemList(
    String type,
    DataSourceEnum? source,
  ) async {
    return (await itemRepositoryInterface.getList(
          type: type,
          isPopularItem: true,
          source: source,
        ))
        as List<Item>?;
  }

  @override
  Future<ItemModel?> getReviewedItemList(
    String type,
    DataSourceEnum? source,
  ) async {
    return (await itemRepositoryInterface.getList(
          type: type,
          isReviewedItem: true,
          source: source,
        ))
        as ItemModel?;
  }

  @override
  Future<ItemModel?> getFeaturedCategoriesItemList(
    DataSourceEnum? source,
  ) async {
    return (await itemRepositoryInterface.getList(
          isFeaturedCategoryItems: true,
          source: source,
        ))
        as ItemModel?;
  }

  @override
  Future<List<Item>?> getRecommendedItemList(
    String type,
    DataSourceEnum? source,
  ) async {
    return (await itemRepositoryInterface.getList(
          type: type,
          isRecommendedItems: true,
          source: source,
        ))
        as List<Item>?;
  }

  @override
  Future<List<Item>?> getDiscountedItemList(
    String type,
    DataSourceEnum? source,
  ) async {
    return (await itemRepositoryInterface.getList(
          isDiscountedItems: true,
          type: type,
          source: source,
        ))
        as List<Item>?;
  }

  @override
  Future<Item?> getItemDetails(int? itemID) async {
    return (await itemRepositoryInterface.get(itemID.toString())) as Item?;
  }

  @override
  Future<BasicMedicineModel?> getBasicMedicine(DataSourceEnum source) async {
    return itemRepositoryInterface.getBasicMedicine(source);
  }

  @override
  Future<List<CommonConditionModel>?> getCommonConditions() async {
    return (await itemRepositoryInterface.getList(isCommonConditions: true))
        as List<CommonConditionModel>?;
  }

  @override
  Future<List<Item>?> getConditionsWiseItems(int id) async {
    return (await itemRepositoryInterface.get(
          id.toString(),
          isConditionWiseItem: true,
        ))
        as List<Item>?;
  }

  @override
  List<bool> initializeCartAddonActiveList(
    List<AddOn>? addOnIds,
    List<AddOns>? addOns,
  ) {
    final addOnIdList = <int?>[];
    final addOnActiveList = <bool>[];
    for (final addOnId in addOnIds ?? <AddOn>[]) {
      addOnIdList.add(addOnId.id);
    }
    for (final addOn in addOns!) {
      if (addOnIdList.contains(addOn.id)) {
        addOnActiveList.add(true);
      } else {
        addOnActiveList.add(false);
      }
    }
    return addOnActiveList;
  }

  @override
  List<int?> initializeCartAddonsQtyList(
    List<AddOn>? addOnIds,
    List<AddOns>? addOns,
  ) {
    final addOnIdList = <int?>[];
    final addOnQtyList = <int?>[];
    for (final addOnId in addOnIds ?? <AddOn>[]) {
      addOnIdList.add(addOnId.id);
    }
    for (final addOn in addOns!) {
      if (addOnIdList.contains(addOn.id)) {
        addOnQtyList.add(addOnIds?[addOnIdList.indexOf(addOn.id)].quantity);
      } else {
        addOnQtyList.add(1);
      }
    }
    return addOnQtyList;
  }

  @override
  List<bool> collapseVariation(List<FoodVariation>? foodVariations) {
    final collapseVariation = <bool>[];
    for (var index = 0; index < foodVariations!.length; index++) {
      collapseVariation.add(true);
    }
    return collapseVariation;
  }

  @override
  List<int> initializeCartVariationIndexes(
    List<Variation>? variation,
    List<ChoiceOptions>? choiceOptions,
  ) {
    final variationIndex = <int>[];
    final variationTypes = <String>[];
    if (variation!.isNotEmpty && variation[0].type != null) {
      variationTypes.addAll(variation[0].type!.split('-'));
    }
    var varIndex = 0;
    for (final choiceOption in choiceOptions!) {
      for (var index = 0; index < choiceOption.options!.length; index++) {
        if (choiceOption.options![index].trim().replaceAll(' ', '') ==
            variationTypes[varIndex].trim()) {
          variationIndex.add(index);
          break;
        }
      }
      varIndex++;
    }
    return variationIndex;
  }

  @override
  List<List<bool?>> initializeSelectedVariation(
    List<FoodVariation>? foodVariations,
  ) {
    final selectedVariations = <List<bool?>>[];
    for (var index = 0; index < foodVariations!.length; index++) {
      selectedVariations.add([]);
      for (var i = 0; i < foodVariations[index].variationValues!.length; i++) {
        selectedVariations[index].add(false);
      }
    }
    return selectedVariations;
  }

  @override
  List<bool> initializeCollapseVariation(List<FoodVariation>? foodVariations) {
    final collapseVariation = <bool>[];
    for (var index = 0; index < foodVariations!.length; index++) {
      collapseVariation.add(true);
    }
    return collapseVariation;
  }

  @override
  List<int> initializeVariationIndexes(List<ChoiceOptions>? choiceOptions) {
    final variationIndex = <int>[];
    for (var i = 0; i < choiceOptions!.length; i++) {
      variationIndex.add(0);
    }
    return variationIndex;
  }

  @override
  List<bool> initializeAddonActiveList(List<AddOns>? addOns) {
    final addOnActiveList = <bool>[];
    for (var i = 0; i < addOns!.length; i++) {
      addOnActiveList.add(false);
    }
    return addOnActiveList;
  }

  @override
  List<int> initializeAddonQtyList(List<AddOns>? addOns) {
    final addOnQtyList = <int>[];
    for (var i = 0; i < addOns!.length; i++) {
      addOnQtyList.add(1);
    }
    return addOnQtyList;
  }

  @override
  Future<String> prepareVariationType(
    List<ChoiceOptions>? choiceOptions,
    List<int>? variationIndex,
  ) async {
    var variationType = '';
    if (!(ModuleHelper.getModuleConfig(
          ModuleHelper.getModule() != null
              ? ModuleHelper.getModule()?.moduleType
              : ModuleHelper.getCacheModule()?.moduleType,
        )?.newVariation ??
        false)) {
      final variationList = <String>[];
      for (var index = 0; index < (choiceOptions?.length ?? 0); index++) {
        variationList.add(
          choiceOptions?[index].options?[variationIndex![index]].replaceAll(
                ' ',
                '',
              ) ??
              '',
        );
      }
      var isFirst = true;
      for (final variation in variationList) {
        if (isFirst) {
          variationType = '$variationType$variation';
          isFirst = false;
        } else {
          variationType = '$variationType-$variation';
        }
      }
    }
    return variationType;
  }

  @override
  int setAddOnQuantity(bool isIncrement, int addOnQty) {
    var qty = addOnQty;
    if (isIncrement) {
      qty = qty + 1;
    } else {
      qty = qty - 1;
    }
    return qty;
  }

  @override
  Future<int> setQuantity(
    bool isIncrement,
    bool moduleStock,
    int? stock,
    int qty,
    int? quantityLimit, {
    bool getxSnackBar = false,
  }) async {
    var quantity = qty;
    if (isIncrement) {
      if (moduleStock && quantity >= stock!) {
        showCustomSnackBar('out_of_stock'.tr);
      } else {
        if (quantityLimit != null) {
          if (quantity >= quantityLimit && quantityLimit != 0) {
            showCustomSnackBar(
              '${'maximum_quantity_limit'.tr} $quantityLimit',
              getXSnackBar: getxSnackBar,
            );
          } else {
            quantity = quantity + 1;
          }
        } else {
          quantity = quantity + 1;
        }
      }
    } else {
      quantity = quantity - 1;
    }
    return quantity;
  }

  @override
  List<List<bool?>> setNewCartVariationIndex(
    int index,
    int i,
    List<FoodVariation>? foodVariations,
    List<List<bool?>> selectedVariations,
  ) {
    final resultVariations = selectedVariations;
    if (!foodVariations![index].multiSelect!) {
      for (var j = 0; j < resultVariations[index].length; j++) {
        if (foodVariations[index].required!) {
          resultVariations[index][j] = j == i;
        } else {
          if (resultVariations[index][j]!) {
            resultVariations[index][j] = false;
          } else {
            resultVariations[index][j] = j == i;
          }
        }
      }
    } else {
      if (!resultVariations[index][i]! &&
          selectedVariationLength(resultVariations, index) >=
              foodVariations[index].max!) {
        showCustomSnackBar(
          '${'maximum_variation_for'.tr} ${foodVariations[index].name} ${'is'.tr} ${foodVariations[index].max}',
          getXSnackBar: true,
        );
      } else {
        resultVariations[index][i] = !resultVariations[index][i]!;
      }
    }
    return resultVariations;
  }

  @override
  int selectedVariationLength(List<List<bool?>> selectedVariations, int index) {
    var length = 0;
    for (final isSelected in selectedVariations[index]) {
      if (isSelected!) {
        length++;
      }
    }
    return length;
  }

  @override
  num? getStartingPrice(Item item) {
    num? startingPrice = 0;
    if (item.choiceOptions != null && item.choiceOptions!.isNotEmpty) {
      final priceList = <num?>[];
      for (final variation in item.variations!) {
        priceList.add(variation.price);
      }
      priceList.sort((a, b) => a!.compareTo(b!));
      startingPrice = priceList[0];
    } else {
      startingPrice = item.price;
    }
    return startingPrice;
  }

  @override
  Future<int> isExistInCartForBottomSheet(
    List<CartModel> cartList,
    int? itemId,
    int? cartIndex,
    List<List<bool?>>? variations,
  ) async {
    for (var index = 0; index < cartList.length; index++) {
      if (cartList[index].item!.id == itemId) {
        if (index == cartIndex) {
          return -1;
        } else {
          if (variations != null && variations.isNotEmpty) {
            var same = false;
            for (var i = 0; i < variations.length; i++) {
              for (var j = 0; j < variations[i].length; j++) {
                if (variations[i][j] == cartList[index].foodVariations![i][j]) {
                  same = true;
                } else {
                  same = false;
                  break;
                }
              }
              if (!same) {
                break;
              }
            }
            if (!same) {
              continue;
            }
            if (same) {
              return index;
            } else {
              return -1;
            }
          } else {
            return index;
          }
        }
      }
    }
    return -1;
  }
}
