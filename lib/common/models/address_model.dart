import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';

class AddressModel {
  AddressModel({
    this.id,
    this.addressType,
    this.contactPersonNumber,
    this.address,
    this.additionalAddress,
    this.latitude,
    this.longitude,
    this.zoneId,
    this.zoneIds,
    this.method,
    this.contactPersonName,
    this.streetNumber,
    this.house,
    this.floor,
    this.zoneData,
    this.areaIds,
    this.email,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    addressType = json['address_type'] as String?;
    contactPersonNumber = json['contact_person_number'].toString();
    address = json['address'] as String?;
    additionalAddress = json['additional_address'] as String?;
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    zoneId = (json['zone_id'] != null && json['zone_id'] != 'null')
        ? int.parse(json['zone_id'].toString())
        : null;
    zoneIds = (json['zone_ids'] as List?)
        ?.map((e) => int.tryParse(e.toString()))
        .toList()
        .cast<int>();
    method = json['_method'] as String?;
    contactPersonName = json['contact_person_name'] as String?;
    streetNumber = json['road'] as String?;
    house = json['house'] as String?;
    floor = json['floor'] as String?;
    if (json['zone_data'] != null) {
      zoneData = [];
      json['zone_data'].forEach((v) {
        zoneData?.add(ZoneData.fromJson(v as Map<String, dynamic>));
      });
    }
    areaIds = (json['area_ids'] as List?)
        ?.map((e) => int.tryParse(e.toString()))
        .toList()
        .cast<int>();
    if (json['contact_person_email'] != null) {
      email = json['contact_person_email'] as String?;
    }
  }

  int? id;
  String? addressType;
  String? contactPersonNumber;
  String? address;
  String? additionalAddress;
  String? latitude;
  String? longitude;
  int? zoneId;
  List<int>? zoneIds;
  String? method;
  String? contactPersonName;
  String? streetNumber;
  String? house;
  String? floor;
  List<ZoneData>? zoneData;
  List<int>? areaIds;
  String? email;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['address_type'] = addressType;
    data['contact_person_number'] = contactPersonNumber;
    data['address'] = address;
    data['additional_address'] = additionalAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['zone_id'] = zoneId;
    data['zone_ids'] = zoneIds;
    data['_method'] = method;
    data['contact_person_name'] = contactPersonName;
    data['road'] = streetNumber;
    data['house'] = house;
    data['floor'] = floor;
    if (zoneData != null) {
      data['zone_data'] = zoneData!.map((v) => v.toJson()).toList();
    }
    data['area_ids'] = areaIds;
    if (email != null) {
      data['contact_person_email'] = email;
    }
    return data;
  }
}
