import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/domain/models/online_cart_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';

class OrderDetailsModel {
  OrderDetailsModel({
    this.id,
    this.itemId,
    this.orderId,
    this.price,
    this.itemDetails,
    this.variation,
    this.foodVariation,
    this.addOns,
    this.discountOnItem,
    this.discountType,
    this.quantity,
    this.taxAmount,
    this.variant,
    this.createdAt,
    this.updatedAt,
    this.itemCampaignId,
    this.totalAddOnPrice,
    this.imageFullUrl,
    this.isGuest,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    itemId = json['item_id'] as int?;
    orderId = json['order_id'] as int?;
    price = json['price'] as num?;
    itemDetails = json['item_details'] != null
        ? Item.fromJson(json['item_details'] as Map<String, dynamic>)
        : null;
    variation = [];
    foodVariation = [];
    if ((json['variation'] as List?)?.isNotEmpty ?? false) {
      if (json['variation'][0]['values'] != null) {
        json['variation'].forEach((v) {
          foodVariation!.add(FoodVariation.fromJson(v as Map<String, dynamic>));
        });
      } else {
        json['variation'].forEach((v) {
          variation!.add(Variation.fromJson(v as Map<String, dynamic>));
        });
      }
    }
    if (json['add_ons'] != null) {
      addOns = [];
      json['add_ons'].forEach((v) {
        addOns!.add(AddOn.fromJson(v as Map<String, dynamic>));
      });
    }
    discountOnItem = json['discount_on_item']?.toDouble() as num?;
    discountType = json['discount_type'] as String?;
    quantity = json['quantity'] as int?;
    taxAmount = json['tax_amount']?.toDouble() as num?;
    variant = json['variant'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    itemCampaignId = json['item_campaign_id'] as int?;
    totalAddOnPrice = json['total_add_on_price']?.toDouble() as num?;
    imageFullUrl = json['image_full_url'] as String?;
    isGuest = json['is_guest'] as int?;
  }
  int? id;
  int? itemId;
  int? orderId;
  num? price;
  Item? itemDetails;
  List<Variation>? variation;
  List<FoodVariation>? foodVariation;
  List<AddOn>? addOns;
  num? discountOnItem;
  String? discountType;
  int? quantity;
  num? taxAmount;
  String? variant;
  String? createdAt;
  String? updatedAt;
  int? itemCampaignId;
  num? totalAddOnPrice;
  String? imageFullUrl;
  int? isGuest;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    data['order_id'] = orderId;
    data['price'] = price;
    if (itemDetails != null) {
      data['item_details'] = itemDetails!.toJson();
    }
    if (variation != null) {
      data['variation'] = variation!.map((v) => v.toJson()).toList();
    } else if (foodVariation != null) {
      data['variation'] = foodVariation!.map((v) => v.toJson()).toList();
    }
    if (addOns != null) {
      data['add_ons'] = addOns!.map((v) => v.toJson()).toList();
    }
    data['discount_on_item'] = discountOnItem;
    data['discount_type'] = discountType;
    data['quantity'] = quantity;
    data['tax_amount'] = taxAmount;
    data['variant'] = variant;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['item_campaign_id'] = itemCampaignId;
    data['total_add_on_price'] = totalAddOnPrice;
    data['image_full_url'] = imageFullUrl;
    data['is_guest'] = isGuest;
    return data;
  }
}

class AddOn {
  AddOn({this.name, this.price, this.quantity});

  AddOn.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    price = json['price'] as num?;
    quantity = int.parse(json['quantity'].toString());
  }
  String? name;
  num? price;
  int? quantity;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
