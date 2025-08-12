class ModuleModel {
  ModuleModel({
    this.id,
    this.moduleName,
    this.moduleType,
    this.thumbnailFullUrl,
    this.storesCount,
    this.iconFullUrl,
    this.themeId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.zones,
  });

  ModuleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    moduleName = json['module_name'] as String?;
    moduleType = json['module_type'] as String?;
    thumbnailFullUrl = json['thumbnail_full_url'] as String?;
    iconFullUrl = json['icon_full_url'] as String?;
    themeId = json['theme_id'] as int?;
    description = json['description'] as String?;
    storesCount = json['stores_count'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    if (json['zones'] != null) {
      zones = <ModuleZoneData>[];
      json['zones'].forEach(
        (v) => zones!.add(ModuleZoneData.fromJson(v as Map<String, dynamic>)),
      );
    }
  }
  int? id;
  String? moduleName;
  String? moduleType;
  String? thumbnailFullUrl;
  String? iconFullUrl;
  int? themeId;
  String? description;
  int? storesCount;
  String? createdAt;
  String? updatedAt;
  List<ModuleZoneData>? zones;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['module_name'] = moduleName;
    data['module_type'] = moduleType;
    data['thumbnail_full_url'] = thumbnailFullUrl;
    data['icon_full_url'] = iconFullUrl;
    data['theme_id'] = themeId;
    data['description'] = description;
    data['stores_count'] = storesCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (zones != null) {
      data['zones'] = zones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModuleZoneData {
  ModuleZoneData({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.cashOnDelivery,
    this.digitalPayment,
  });

  ModuleZoneData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    cashOnDelivery = json['cash_on_delivery'] as bool?;
    digitalPayment = json['digital_payment'] as bool?;
  }
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  bool? cashOnDelivery;
  bool? digitalPayment;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cash_on_delivery'] = cashOnDelivery;
    data['digital_payment'] = digitalPayment;
    return data;
  }
}
