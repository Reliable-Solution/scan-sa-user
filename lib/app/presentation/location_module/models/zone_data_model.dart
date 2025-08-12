import 'package:google_maps_flutter/google_maps_flutter.dart';

class ZoneDataModel {
  ZoneDataModel({
    this.id,
    this.name,
    this.coordinates,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.restaurantWiseTopic,
    this.customerWiseTopic,
    this.deliverymanWiseTopic,
    this.minimumShippingCharge,
    this.perKmShippingCharge,
    this.formatedCoordinates,
  });

  ZoneDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>)
        : null;
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    restaurantWiseTopic = json['restaurant_wise_topic'] as String?;
    customerWiseTopic = json['customer_wise_topic'] as String?;
    deliverymanWiseTopic = json['deliveryman_wise_topic'] as String?;
    minimumShippingCharge = json['minimum_shipping_charge'] != null
        ? json['minimum_shipping_charge'] as num?
        : 0 as num?;
    perKmShippingCharge = json['per_km_shipping_charge'] != null
        ? json['per_km_shipping_charge'] as num?
        : 0 as num?;
    if (json['formated_coordinates'] != null) {
      formatedCoordinates = <FormatedCoordinates>[];
      json['formated_coordinates'].forEach((v) {
        formatedCoordinates!.add(
          FormatedCoordinates.fromJson(v as Map<String, dynamic>),
        );
      });
    }
  }
  int? id;
  String? name;
  Coordinates? coordinates;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? restaurantWiseTopic;
  String? customerWiseTopic;
  String? deliverymanWiseTopic;
  num? minimumShippingCharge;
  num? perKmShippingCharge;
  List<FormatedCoordinates>? formatedCoordinates;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['restaurant_wise_topic'] = restaurantWiseTopic;
    data['customer_wise_topic'] = customerWiseTopic;
    data['deliveryman_wise_topic'] = deliverymanWiseTopic;
    data['minimum_shipping_charge'] = minimumShippingCharge;
    data['per_km_shipping_charge'] = perKmShippingCharge;
    if (formatedCoordinates != null) {
      data['formated_coordinates'] = formatedCoordinates!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class Coordinates {
  Coordinates({this.type, this.coordinates});

  Coordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    if (json['coordinates'] != null) {
      coordinates = <LatLng>[];
      json['coordinates'][0].forEach((v) {
        coordinates!.add(
          LatLng(double.parse(v[0].toString()), double.parse(v[1].toString())),
        );
      });
    }
  }
  String? type;
  List<LatLng>? coordinates;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FormatedCoordinates {
  FormatedCoordinates({this.lat, this.lng});

  FormatedCoordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as num?;
    lng = json['lng'] as num?;
  }
  num? lat;
  num? lng;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
