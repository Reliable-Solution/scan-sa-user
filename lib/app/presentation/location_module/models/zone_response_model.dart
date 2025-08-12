class ZoneResponseModel {
  ZoneResponseModel(
    this._isSuccess,
    this._message,
    this._zoneIds,
    this._zoneData,
    this._areaIds,
    this.statusCode,
  );
  final bool _isSuccess;
  final List<int> _zoneIds;
  final String? _message;
  final List<ZoneData> _zoneData;
  final List<int> _areaIds;
  final int? statusCode;

  String? get message => _message;
  List<int> get zoneIds => _zoneIds;
  bool get isSuccess => _isSuccess;
  List<ZoneData> get zoneData => _zoneData;
  List<int> get areaIds => _areaIds;
  int? get status => statusCode;
}

class ZoneData {
  ZoneData({
    this.id,
    this.status,
    this.cashOnDelivery,
    this.digitalPayment,
    this.offlinePayment,
    this.increaseDeliveryFee,
    this.increaseDeliveryFeeStatus,
    this.increaseDeliveryFeeMessage,
    this.modules,
  });

  ZoneData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    status = json['status'] as int?;
    cashOnDelivery = json['cash_on_delivery'] as bool?;
    digitalPayment = json['digital_payment'] as bool?;
    offlinePayment = json['offline_payment'] as bool?;
    increaseDeliveryFee = json['increased_delivery_fee']?.toDouble() as double?;
    increaseDeliveryFeeStatus = json['increased_delivery_fee_status'] as int?;
    increaseDeliveryFeeMessage =
        json['increase_delivery_charge_message'] as String?;
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? id;
  int? status;
  bool? cashOnDelivery;
  bool? digitalPayment;
  bool? offlinePayment;
  double? increaseDeliveryFee;
  int? increaseDeliveryFeeStatus;
  String? increaseDeliveryFeeMessage;
  List<Modules>? modules;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['cash_on_delivery'] = cashOnDelivery;
    data['digital_payment'] = digitalPayment;
    data['offline_payment'] = offlinePayment;
    data['increased_delivery_fee'] = increaseDeliveryFee;
    data['increased_delivery_fee_status'] = increaseDeliveryFeeStatus;
    data['increase_delivery_charge_message'] = increaseDeliveryFeeMessage;
    if (modules != null) {
      data['modules'] = modules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modules {
  Modules({
    this.id,
    this.moduleName,
    this.moduleType,
    this.thumbnail,
    this.status,
    this.storesCount,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.themeId,
    this.description,
    this.allZoneService,
    this.pivot,
  });

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    moduleName = json['module_name'] as String?;
    moduleType = json['module_type'] as String?;
    thumbnail = json['thumbnail'] as String?;
    status = json['status'] as String?;
    storesCount = json['stores_count'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    icon = json['icon'] as String?;
    themeId = json['theme_id'] as int?;
    description = json['description'] as String?;
    allZoneService = json['all_zone_service'] as int?;
    pivot = json['pivot'] != null
        ? Pivot.fromJson(json['pivot'] as Map<String, dynamic>)
        : null;
  }
  int? id;
  String? moduleName;
  String? moduleType;
  String? thumbnail;
  String? status;
  int? storesCount;
  String? createdAt;
  String? updatedAt;
  String? icon;
  int? themeId;
  String? description;
  int? allZoneService;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['module_name'] = moduleName;
    data['module_type'] = moduleType;
    data['thumbnail'] = thumbnail;
    data['status'] = status;
    data['stores_count'] = storesCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['icon'] = icon;
    data['theme_id'] = themeId;
    data['description'] = description;
    data['all_zone_service'] = allZoneService;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  Pivot({
    this.zoneId,
    this.moduleId,
    this.perKmShippingCharge,
    this.minimumShippingCharge,
    this.maximumShippingCharge,
    this.maximumCodOrderAmount,
  });

  Pivot.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'] as int?;
    moduleId = json['module_id'] as int?;
    perKmShippingCharge = json['per_km_shipping_charge']?.toDouble() as double?;
    minimumShippingCharge =
        json['minimum_shipping_charge']?.toDouble() as double?;
    maximumShippingCharge =
        json['maximum_shipping_charge']?.toDouble() as double?;
    maximumCodOrderAmount =
        json['maximum_cod_order_amount']?.toDouble() as double?;
  }
  int? zoneId;
  int? moduleId;
  double? perKmShippingCharge;
  double? minimumShippingCharge;
  double? maximumShippingCharge;
  double? maximumCodOrderAmount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['zone_id'] = zoneId;
    data['module_id'] = moduleId;
    data['per_km_shipping_charge'] = perKmShippingCharge;
    data['minimum_shipping_charge'] = minimumShippingCharge;
    data['maximum_shipping_charge'] = maximumShippingCharge;
    data['maximum_cod_order_amount'] = maximumCodOrderAmount;
    return data;
  }
}
