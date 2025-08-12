import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class OnlineCartModel {
  OnlineCartModel({
    this.id,
    this.userId,
    this.moduleId,
    this.itemId,
    this.isGuest,
    this.addOnIds,
    this.addOnQtys,
    this.itemType,
    this.price,
    this.quantity,
    this.foodVariation,
    this.createdAt,
    this.updatedAt,
    this.item,
  });

  OnlineCartModel.fromJson(Map<String, dynamic> json) {
    "json['variation'] == ${json['variation']}".print;
    id = json['id'] as int?;
    userId = json['user_id'] as int?;
    moduleId = json['module_id'] as int?;
    itemId = json['item_id'] as int?;
    isGuest = json['is_guest'] as bool?;
    addOnIds = json['add_on_ids'].cast<int>() as List<int>;
    addOnQtys = json['add_on_qtys'].cast<int>() as List<int>;
    itemType = json['item_type'] as String?;
    price = json['price']?.toDouble() as num?;
    quantity = json['quantity'] as int?;
    if (json['variation'] != null) {
      foodVariation = [];
      productVariation = [];
      json['variation'].forEach((v) {
        if (v['name'] == null) {
          productVariation!.add(Variation.fromJson(v as Map<String, dynamic>));
        } else {
          foodVariation!.add(Variation.fromJson(v as Map<String, dynamic>));
        }
      });
    }
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    item = json['item'] != null
        ? Item.fromJson(json['item'] as Map<String, dynamic>)
        : null;
  }
  int? id;
  int? userId;
  int? moduleId;
  int? itemId;
  bool? isGuest;
  List<int>? addOnIds;
  List<int>? addOnQtys;
  String? itemType;
  num? price;
  int? quantity;
  List<Variation>? foodVariation;
  List<Variation>? productVariation;
  String? createdAt;
  String? updatedAt;
  Item? item;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['module_id'] = moduleId;
    data['item_id'] = itemId;
    data['is_guest'] = isGuest;
    data['add_on_ids'] = addOnIds;
    data['add_on_qtys'] = addOnQtys;
    data['item_type'] = itemType;
    data['price'] = price;
    data['quantity'] = quantity;
    if (foodVariation != null) {
      data['variation'] = foodVariation!.map((v) => v.toJson()).toList();
    }
    if (productVariation != null) {
      data['variation'] = productVariation!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class Variation {
  Variation({this.name, this.values, this.type, this.price, this.stock});

  Variation.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    price = json['price'] as num?;
    name = json['name'] as String?;
    stock = json['stock'] as int?;
    values = json['values'] != null
        ? Value.fromJson(json['values'] as Map<String, dynamic>)
        : null;
  }
  String? type;
  num? price;
  String? name;
  int? stock;
  Value? values;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    data['name'] = name;
    data['stock'] = stock;
    if (values != null) {
      data['values'] = values!.toJson();
    }
    return data;
  }
}

class Value {
  Value({this.label});

  Value.fromJson(Map<String, dynamic> json) {
    label = json['label'].cast<String>() as List<String>?;
  }
  List<String>? label;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    return data;
  }
}
