class ParcelCategoryModel {
  ParcelCategoryModel({
    this.id,
    this.imageFullUrl,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.parcelPerKmShippingCharge,
    this.parcelMinimumShippingCharge,
  });

  ParcelCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    imageFullUrl = json['image_full_url'] as String?;
    name = json['name'] as String?;
    description = json['description'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    parcelPerKmShippingCharge = json['parcel_per_km_shipping_charge'] != null
        ? json['parcel_per_km_shipping_charge'] as num
        : 0;
    parcelMinimumShippingCharge = json['parcel_minimum_shipping_charge'] != null
        ? json['parcel_minimum_shipping_charge'] as num
        : 0;
  }
  int? id;
  String? imageFullUrl;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  num? parcelPerKmShippingCharge;
  num? parcelMinimumShippingCharge;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image_full_url'] = imageFullUrl;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['parcel_per_km_shipping_charge'] = parcelPerKmShippingCharge;
    data['parcel_minimum_shipping_charge'] = parcelMinimumShippingCharge;
    return data;
  }
}
