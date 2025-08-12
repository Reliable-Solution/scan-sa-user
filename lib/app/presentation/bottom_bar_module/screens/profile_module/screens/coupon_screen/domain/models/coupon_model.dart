class CouponModel {
  CouponModel({
    this.id,
    this.title,
    this.code,
    this.startDate,
    this.expireDate,
    this.minPurchase,
    this.maxDiscount,
    this.discount,
    this.discountType,
    this.couponType,
    this.limit,
    this.data,
    this.storeId,
    this.createdAt,
    this.updatedAt,
    this.store,
  });

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    code = json['code'] as String?;
    startDate = json['start_date'] as String?;
    expireDate = json['expire_date'] as String?;
    minPurchase = json['min_purchase'].toDouble() as num?;
    maxDiscount = json['max_discount'].toDouble() as num?;
    discount = json['discount'].toDouble() as num?;
    discountType = json['discount_type'] as String?;
    couponType = json['coupon_type'] as String?;
    limit = json['limit'] as int?;
    data = json['data'] as String?;
    storeId = json['store_id'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    if (json['store'] != null) {
      store = StoreData.fromJson(json['store'] as Map<String, dynamic>);
    }
  }
  int? id;
  String? title;
  String? code;
  String? startDate;
  String? expireDate;
  num? minPurchase;
  num? maxDiscount;
  num? discount;
  String? discountType;
  String? couponType;
  int? limit;
  String? data;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  StoreData? store;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['start_date'] = startDate;
    data['expire_date'] = expireDate;
    data['min_purchase'] = minPurchase;
    data['max_discount'] = maxDiscount;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['coupon_type'] = couponType;
    data['limit'] = limit;
    data['data'] = this.data;
    data['store_id'] = storeId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class StoreData {
  StoreData({this.id, this.name});

  StoreData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
