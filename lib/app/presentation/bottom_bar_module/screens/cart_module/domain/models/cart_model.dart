import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/online_cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CartModel {
  CartModel(
    int? id,
    num? price,
    num discountedPrice,
    List<Variation> variation,
    List<List<bool?>> foodVariations,
    num discountAmount,
    int? quantity,
    List<AddOn> addOnIds,
    List<AddOns> addOns,
    bool isCampaign,
    int? stock,
    Item? item,
    int? quantityLimit, {
    bool isLoading = false,
  }) {
    _id = id;
    _price = price;
    _discountedPrice = discountedPrice;
    _variation = variation;
    _foodVariations = foodVariations;
    _discountAmount = discountAmount;
    _quantity = quantity;
    this.addOnIds;
    _addOns = addOns;
    _isCampaign = isCampaign;
    _stock = stock;
    _item = item;
    _quantityLimit = quantityLimit;
    _isLoading = isLoading;
  }

  CartModel.fromJson(Map<String, dynamic> json) {
    "data['variation'] ${json['variation']}".print;
    _id = json['cart_id'] as int?;
    _price = json['price'] as num?;
    _discountedPrice = json['discounted_price'] as num?;
    if (json['variation'] != null) {
      _variation = [];
      json['variation'].forEach((v) {
        _variation!.add(Variation.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['food_variations'] != null) {
      final list = json['food_variations'] as List;
      _foodVariations = [];
      for (var index = 0; index < list.length; index++) {
        _foodVariations!.add([]);
        for (var i = 0; i < (list[index] as List).length; i++) {
          _foodVariations![index].add((list[index] as List)[i] as bool);
        }
      }
    }
    _discountAmount = json['discount_amount'] as num;
    _quantity = json['quantity'] as int?;
    _stock = json['stock'] as int;
    if (json['add_on_ids'] != null) {
      _addOnIds = [];
      json['add_on_ids'].forEach((v) {
        _addOnIds!.add(AddOn.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['add_ons'] != null) {
      _addOns = [];
      json['add_ons'].forEach((v) {
        _addOns!.add(AddOns.fromJson(v as Map<String, dynamic>));
      });
    }
    _isCampaign = json['is_campaign'] as bool?;
    if (json['item'] != null) {
      _item = Item.fromJson(json['item'] as Map<String, dynamic>);
    }
    if (json['quantity_limit'] != null) {
      _quantityLimit = int.tryParse(json['quantity_limit'] as String);
    }
    _isLoading = (json['is_loading'] as bool?) ?? false;
  }
  int? _id;
  num? _price;
  num? _discountedPrice;
  List<Variation>? _variation;
  List<List<bool?>>? _foodVariations;
  num? _discountAmount;
  int? _quantity;
  List<AddOn>? _addOnIds;
  List<AddOns>? _addOns;
  bool? _isCampaign;
  int? _stock;
  Item? _item;
  int? _quantityLimit;
  bool? _isLoading;

  int? get id => _id;
  num? get price => _price;
  num? get discountedPrice => _discountedPrice;
  List<Variation>? get variation => _variation;
  List<List<bool?>>? get foodVariations => _foodVariations;
  num? get discountAmount => _discountAmount;
  // ignore: unnecessary_getters_setters
  int? get quantity => _quantity;
  // ignore: unnecessary_getters_setters
  set quantity(int? qty) => _quantity = qty;
  List<AddOn>? get addOnIds => _addOnIds;
  List<AddOns>? get addOns => _addOns;
  bool? get isCampaign => _isCampaign;
  int? get stock => _stock;
  Item? get item => _item;
  int? get quantityLimit => _quantityLimit;
  // ignore: unnecessary_getters_setters
  bool? get isLoading => _isLoading;
  set isLoading(bool? status) => _isLoading = status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cart_id'] = _id;
    data['price'] = _price;
    data['discounted_price'] = _discountedPrice;
    if (_variation != null) {
      data['variation'] = _variation!.map((v) => v.toJson()).toList();
    }
    data['food_variations'] = _foodVariations;
    data['discount_amount'] = _discountAmount;
    data['quantity'] = _quantity;
    if (_addOnIds != null) {
      // data['add_on_ids'] = addOnIds;
      data['add_on_ids'] = _addOnIds!.map((v) => v.toJson()).toList();
    }
    if (_addOns != null) {
      data['add_ons'] = _addOns!.map((v) => v.toJson()).toList();
    }
    data['is_campaign'] = _isCampaign;
    data['stock'] = _stock;
    data['item'] = _item!.toJson();
    data['quantity_limit'] = _quantityLimit?.toString();
    // data['is_loading'] = _isLoading?? false;
    return data;
  }
}

class AddOn {
  AddOn({this.id, this.quantity});

  AddOn.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    quantity = json['quantity'] as int?;
  }
  int? id;
  int? quantity;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    return data;
  }
}

class OnlineCart {
  OnlineCart(
    int? cartId,
    int? itemId,
    int? itemCampaignId,
    String price,
    String variant,
    List<Variation>? variation,
    List<OrderVariation>? variations,
    int? quantity,
    List<int?> addOnIds,
    List<AddOns>? addOns,
    List<int?> addOnQtys,
    String model, {
    String? itemType,
  }) {
    _cartId = cartId;
    _itemId = itemId;
    _itemCampaignId = itemCampaignId;
    _price = price;
    _variant = variant;
    _variation = variation;
    _variations = variations;
    _quantity = quantity;
    _addOnIds = addOnIds;
    _addOns = addOns;
    _addOnQtys = addOnQtys;
    _model = model;
    _itemType = itemType;
  }

  OnlineCart.fromJson(Map<String, dynamic> json) {
    _cartId = json['cart_id'] as int?;
    _itemId = json['item_id'] as int?;
    _itemCampaignId = json['item_campaign_id'] as int?;
    _price = json['price'] as String?;
    _variant = json['variant'] as String?;
    if (((json['variation'] as List?)?.isNotEmpty ?? false) &&
        json['variation'][0]['price'] != null) {
      _variation = [];
      json['variation'].forEach((v) {
        _variation!.add(Variation.fromJson(v as Map<String, dynamic>));
      });
    } else if (json['variation'] != null) {
      _variations = [];
      json['variation'].forEach((v) {
        _variations!.add(OrderVariation.fromJson(v as Map<String, dynamic>));
      });
    }
    _quantity = json['quantity'] as int?;
    _addOnIds = json['add_on_ids'].cast<int>() as List<int>;
    if (json['add_ons'] != null) {
      _addOns = [];
      json['add_ons'].forEach((v) {
        _addOns!.add(AddOns.fromJson(v as Map<String, dynamic>));
      });
    }
    _addOnQtys = json['add_on_qtys'].cast<int>() as List<int>;
    _model = json['model'] as String?;
    if (json['item_type'] != null && json['item_type'] != 'null') {
      _itemType = json['item_type'] as String?;
    }
  }
  int? _cartId;
  int? _itemId;
  int? _itemCampaignId;
  String? _price;
  String? _variant;
  List<Variation>? _variation;
  List<OrderVariation>? _variations;
  int? _quantity;
  List<int?>? _addOnIds;
  List<AddOns>? _addOns;
  List<int?>? _addOnQtys;
  String? _model;
  String? _itemType;

  int? get cartId => _cartId;
  int? get itemId => _itemId;
  int? get itemCampaignId => _itemCampaignId;
  String? get price => _price;
  String? get variant => _variant;
  List<Variation>? get variation => _variation;
  int? get quantity => _quantity;
  List<int?>? get addOnIds => _addOnIds;
  List<AddOns>? get addOns => _addOns;
  List<int?>? get addOnQtys => _addOnQtys;
  String? get model => _model;
  String? get itemType => _itemType;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_id'] = _itemId;
    data['cart_id'] = _cartId;
    data['item_campaign_id'] = _itemCampaignId;
    data['price'] = _price;
    data['variant'] = _variant;
    if (_variation != null) {
      data['variation'] = _variation!.map((v) => v.toJson()).toList();
    } else if (_variations != null) {
      data['variation'] = _variations!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = _quantity;
    data['add_on_ids'] = _addOnIds;
    if (_addOns != null) {
      data['add_ons'] = _addOns!.map((v) => v.toJson()).toList();
    }
    data['add_on_qtys'] = _addOnQtys;
    data['model'] = _model;
    if (_itemType != null) {
      data['item_type'] = _itemType;
    }
    return data;
  }
}

class OrderVariation {
  OrderVariation({this.name, this.values});

  OrderVariation.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    values = json['values'] != null
        ? OrderVariationValue.fromJson(json['values'] as Map<String, dynamic>)
        : null;
  }
  String? name;
  OrderVariationValue? values;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    if (values != null) {
      data['values'] = values!.toJson();
    }
    return data;
  }
}

class OrderVariationValue {
  OrderVariationValue({this.label});

  OrderVariationValue.fromJson(Map<String, dynamic> json) {
    label = json['label'].cast<String>() as List<String>;
  }
  List<String?>? label;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    return data;
  }
}
