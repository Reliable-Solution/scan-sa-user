import 'dart:convert';

import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';

class ZoneModel {
  ZoneModel({this.zoneIds, this.zoneData});

  ZoneModel.fromJson(Map<String, dynamic> json) {
    zoneIds = [];
    jsonDecode(json['zone_id'] as String).forEach((v) {
      zoneIds!.add(v as int);
    });
    if (json['zone_data'] != null) {
      zoneData = <ZoneData>[];
      json['zone_data'].forEach((v) {
        zoneData!.add(ZoneData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<int>? zoneIds;
  List<ZoneData>? zoneData;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['zone_id'] = zoneIds;
    if (zoneData != null) {
      data['zone_data'] = zoneData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
