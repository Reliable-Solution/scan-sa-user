class DeliveryManVehicleModel {
  DeliveryManVehicleModel({this.id, this.type});

  DeliveryManVehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    type = json['type'] as String?;
  }
  int? id;
  String? type;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}
