import 'dart:convert';

class StoreBodyModel {
  StoreBodyModel({
    this.translation,
    this.tax,
    this.minDeliveryTime,
    this.maxDeliveryTime,
    this.lat,
    this.lng,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.password,
    this.zoneId,
    this.moduleId,
    this.deliveryTimeType,
    this.businessPlan,
    this.iban,
    this.packageId,
    this.pickUpZoneIds,
  });

  StoreBodyModel.fromJson(Map<String, dynamic> json) {
    translation = json['translation'] as String?;
    tax = json['tax'] as String?;
    minDeliveryTime = json['min_delivery_time'] as String?;
    maxDeliveryTime = json['max_delivery_time'] as String?;
    lat = json['lat'] as String?;
    lng = json['lng'] as String?;
    fName = json['f_name'] as String?;
    lName = json['l_name'] as String?;
    phone = json['phone'] as String?;
    email = json['email'] as String?;
    password = json['password'] as String?;
    zoneId = json['zone_id'] as String?;
    moduleId = json['module_id'] as String?;
    deliveryTimeType = json['delivery_time_type'] as String?;
    businessPlan = json['business_plan'] as String?;
    iban = json['iban'] as String?;
    packageId = json['package_id'] as String?;
    if (json['pickup_zone_id'] != null) {
      pickUpZoneIds = json['pickup_zone_id'] as List<String>;
    }
  }
  String? translation;
  String? tax;
  String? minDeliveryTime;
  String? maxDeliveryTime;
  String? lat;
  String? lng;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? zoneId;
  String? moduleId;
  String? deliveryTimeType;
  String? businessPlan;
  String? packageId;
  String? iban;
  List<String>? pickUpZoneIds;

  Map<String, String?> toJson() {
    final data = <String, String?>{};
    data['translations'] = translation;
    data['tax'] = tax;
    data['minimum_delivery_time'] = minDeliveryTime;
    data['maximum_delivery_time'] = maxDeliveryTime;
    data['latitude'] = lat;
    data['longitude'] = lng;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['zone_id'] = zoneId;
    data['module_id'] = moduleId;
    data['delivery_time_type'] = deliveryTimeType;
    data['business_plan'] = businessPlan ?? '';
    data['package_id'] = packageId;
    data['iban'] = iban;
    if (pickUpZoneIds != null) {
      data['pickup_zone_id'] = json.encode(pickUpZoneIds);
    }
    return data;
  }
}
