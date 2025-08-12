class DistanceModel {
  DistanceModel({
    this.destinationAddresses,
    this.originAddresses,
    this.rows,
    this.status,
  });

  DistanceModel.fromJson(Map<String, dynamic> json) {
    destinationAddresses =
        json['destination_addresses'] != null &&
            json['destination_addresses'] is List
        ? List.from(json['destination_addresses'] as List)
        : null;
    originAddresses =
        json['origin_addresses'] != null && json['origin_addresses'] is List
        ? List.from(json['origin_addresses'] as List)
        : null;
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v as Map<String, dynamic>));
      });
    }
    status = json['status'] as String?;
  }
  List<String>? destinationAddresses;
  List<String>? originAddresses;
  List<Rows>? rows;
  String? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['destination_addresses'] = destinationAddresses;
    data['origin_addresses'] = originAddresses;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Rows {
  Rows({this.elements});

  Rows.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = [];
      json['elements'].forEach((v) {
        elements!.add(Elements.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<Elements>? elements;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (elements != null) {
      data['elements'] = elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elements {
  Elements({this.distance, this.duration, this.status});

  Elements.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? Distance.fromJson(json['distance'] as Map<String, dynamic>)
        : null;
    duration = json['duration'] != null
        ? Distance.fromJson(json['duration'] as Map<String, dynamic>)
        : null;
    status = json['status'] as String?;
  }
  Distance? distance;
  Distance? duration;
  String? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Distance {
  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
    value = json['value'] as num?;
  }
  String? text;
  num? value;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['text'] = text;
    data['value'] = value;
    return data;
  }
}
