class ParcelOtherBannerModel {
  ParcelOtherBannerModel({
    this.promotionalBannerUrl,
    this.promotionalBanners3Url,
    this.banners,
  });

  ParcelOtherBannerModel.fromJson(Map<String, dynamic> json) {
    promotionalBannerUrl = json['promotional_banner_url'] as String?;
    promotionalBanners3Url = json['promotional_banner_s3_url'] as String?;
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? promotionalBannerUrl;
  String? promotionalBanners3Url;
  List<Banners>? banners;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['promotional_banner_url'] = promotionalBannerUrl;
    data['promotional_banner_s3_url'] = promotionalBanners3Url;
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  Banners({
    this.id,
    this.moduleId,
    this.key,
    this.imageFullUrl,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    moduleId = json['module_id'] as int?;
    key = json['key'] as String?;
    imageFullUrl = json['value_full_url'] as String?;
    type = json['type'] as String?;
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }
  int? id;
  int? moduleId;
  String? key;
  String? imageFullUrl;
  String? type;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['module_id'] = moduleId;
    data['key'] = key;
    data['value_full_url'] = imageFullUrl;
    data['type'] = type;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
