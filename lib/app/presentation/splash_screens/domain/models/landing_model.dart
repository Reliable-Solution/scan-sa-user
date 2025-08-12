class LandingModel {
  LandingModel({
    this.fixedHeaderTitle,
    this.fixedHeaderSubTitle,
    this.fixedHeaderImageFullUrl,
    this.fixedModuleTitle,
    this.fixedModuleSubTitle,
    this.fixedLocationTitle,
    this.joinSellerTitle,
    this.joinSellerSubTitle,
    this.joinSellerButtonName,
    this.joinSellerButtonUrl,
    this.joinDeliveryManTitle,
    this.joinDeliveryManSubTitle,
    this.joinDeliveryManButtonName,
    this.joinDeliveryManButtonUrl,
    this.downloadUserAppTitle,
    this.downloadUserAppSubTitle,
    this.downloadUserAppImageFullUrl,
    this.specialCriterias,
    this.downloadUserAppLinks,
    this.availableZoneStatus,
    this.availableZoneTitle,
    this.availableZoneShortDescription,
    this.availableZoneImage,
    this.availableZoneImageFullUrl,
    this.availableZoneList,
    this.joinSellerStatus,
    this.joinDeliveryManStatus,
  });

  LandingModel.fromJson(Map<String, dynamic> json) {
    fixedHeaderTitle = json['fixed_header_title'] as String?;
    fixedHeaderSubTitle = json['fixed_header_sub_title'] as String?;
    fixedHeaderImageFullUrl = json['fixed_header_image_full_url'] as String?;
    fixedModuleTitle = json['fixed_module_title'] as String?;
    fixedModuleSubTitle = json['fixed_module_sub_title'] as String?;
    fixedLocationTitle = json['fixed_location_title'] as String?;
    joinSellerTitle = json['join_seller_title'] as String?;
    joinSellerSubTitle = json['join_seller_sub_title'] as String?;
    joinSellerButtonName = json['join_seller_button_name'] as String?;
    joinSellerButtonUrl = json['join_seller_button_url'] as String?;
    joinDeliveryManTitle = json['join_delivery_man_title'] as String?;
    joinDeliveryManSubTitle = json['join_delivery_man_sub_title'] as String?;
    joinDeliveryManButtonName =
        json['join_delivery_man_button_name'] as String?;
    joinDeliveryManButtonUrl = json['join_delivery_man_button_url'] as String?;
    downloadUserAppTitle = json['download_user_app_title'] as String?;
    downloadUserAppSubTitle = json['download_user_app_sub_title'] as String?;
    downloadUserAppImageFullUrl =
        json['download_user_app_image_full_url'] as String?;
    if (json['special_criterias'] != null) {
      specialCriterias = <SpecialCriterias>[];
      json['special_criterias'].forEach((v) {
        specialCriterias!.add(
          SpecialCriterias.fromJson(v as Map<String, dynamic>),
        );
      });
    }
    downloadUserAppLinks = json['download_user_app_links'] != null
        ? DownloadUserAppLinks.fromJson(
            json['download_user_app_links'] as Map<String, dynamic>,
          )
        : null;
    availableZoneStatus = json['available_zone_status'] as int?;
    availableZoneTitle = json['available_zone_title'] as String?;
    availableZoneShortDescription =
        json['available_zone_short_description'] as String?;
    availableZoneImage = json['available_zone_image'] as String?;
    availableZoneImageFullUrl =
        json['available_zone_image_full_url'] as String?;
    if (json['available_zone_list'] != null) {
      availableZoneList = <AvailableZoneList>[];
      json['available_zone_list'].forEach((v) {
        availableZoneList!.add(
          AvailableZoneList.fromJson(v as Map<String, dynamic>),
        );
      });
    }
    joinSellerStatus = json['join_seller_status'] as int?;
    joinDeliveryManStatus = json['join_delivery_man_status'] as int?;
  }
  String? fixedHeaderTitle;
  String? fixedHeaderSubTitle;
  String? fixedHeaderImageFullUrl;
  String? fixedModuleTitle;
  String? fixedModuleSubTitle;
  String? fixedLocationTitle;
  String? joinSellerTitle;
  String? joinSellerSubTitle;
  String? joinSellerButtonName;
  String? joinSellerButtonUrl;
  String? joinDeliveryManTitle;
  String? joinDeliveryManSubTitle;
  String? joinDeliveryManButtonName;
  String? joinDeliveryManButtonUrl;
  String? downloadUserAppTitle;
  String? downloadUserAppSubTitle;
  String? downloadUserAppImageFullUrl;
  List<SpecialCriterias>? specialCriterias;
  DownloadUserAppLinks? downloadUserAppLinks;
  int? availableZoneStatus;
  String? availableZoneTitle;
  String? availableZoneShortDescription;
  String? availableZoneImage;
  String? availableZoneImageFullUrl;
  List<AvailableZoneList>? availableZoneList;
  int? joinSellerStatus;
  int? joinDeliveryManStatus;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fixed_header_title'] = fixedHeaderTitle;
    data['fixed_header_sub_title'] = fixedHeaderSubTitle;
    data['fixed_header_image_full_url'] = fixedHeaderImageFullUrl;
    data['fixed_module_title'] = fixedModuleTitle;
    data['fixed_module_sub_title'] = fixedModuleSubTitle;
    data['fixed_location_title'] = fixedLocationTitle;
    data['join_seller_title'] = joinSellerTitle;
    data['join_seller_sub_title'] = joinSellerSubTitle;
    data['join_seller_button_name'] = joinSellerButtonName;
    data['join_seller_button_url'] = joinSellerButtonUrl;
    data['join_delivery_man_title'] = joinDeliveryManTitle;
    data['join_delivery_man_sub_title'] = joinDeliveryManSubTitle;
    data['join_delivery_man_button_name'] = joinDeliveryManButtonName;
    data['join_delivery_man_button_url'] = joinDeliveryManButtonUrl;
    data['download_user_app_title'] = downloadUserAppTitle;
    data['download_user_app_sub_title'] = downloadUserAppSubTitle;
    data['download_user_app_image_full_url'] = downloadUserAppImageFullUrl;
    if (specialCriterias != null) {
      data['special_criterias'] = specialCriterias!
          .map((v) => v.toJson())
          .toList();
    }
    if (downloadUserAppLinks != null) {
      data['download_user_app_links'] = downloadUserAppLinks!.toJson();
    }
    data['available_zone_status'] = availableZoneStatus;
    data['available_zone_title'] = availableZoneTitle;
    data['available_zone_short_description'] = availableZoneShortDescription;
    data['available_zone_image'] = availableZoneImage;
    data['available_zone_image_full_url'] = availableZoneImageFullUrl;
    if (availableZoneList != null) {
      data['available_zone_list'] = availableZoneList!
          .map((v) => v.toJson())
          .toList();
    }
    data['join_seller_status'] = joinSellerStatus;
    data['join_delivery_man_status'] = joinDeliveryManStatus;
    return data;
  }
}

class SpecialCriterias {
  SpecialCriterias({
    this.id,
    this.title,
    this.imageFullUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.translations,
  });

  SpecialCriterias.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    imageFullUrl = json['image_full_url'] as String?;
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? id;
  String? title;
  String? imageFullUrl;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Translations>? translations;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_full_url'] = imageFullUrl;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (translations != null) {
      data['translations'] = translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  Translations({
    this.id,
    this.translationableType,
    this.translationableId,
    this.locale,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    translationableType = json['translationable_type'] as String?;
    translationableId = json['translationable_id'] as int?;
    locale = json['locale'] as String?;
    key = json['key'] as String?;
    value = json['value'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }
  int? id;
  String? translationableType;
  int? translationableId;
  String? locale;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['translationable_type'] = translationableType;
    data['translationable_id'] = translationableId;
    data['locale'] = locale;
    data['key'] = key;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class DownloadUserAppLinks {
  DownloadUserAppLinks({
    this.playstoreUrlStatus,
    this.playstoreUrl,
    this.appleStoreUrlStatus,
    this.appleStoreUrl,
  });

  DownloadUserAppLinks.fromJson(Map<String, dynamic> json) {
    playstoreUrlStatus = json['playstore_url_status'] as String?;
    playstoreUrl = json['playstore_url'] as String?;
    appleStoreUrlStatus = json['apple_store_url_status'] as String?;
    appleStoreUrl = json['apple_store_url'] as String?;
  }
  String? playstoreUrlStatus;
  String? playstoreUrl;
  String? appleStoreUrlStatus;
  String? appleStoreUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['playstore_url_status'] = playstoreUrlStatus;
    data['playstore_url'] = playstoreUrl;
    data['apple_store_url_status'] = appleStoreUrlStatus;
    data['apple_store_url'] = appleStoreUrl;
    return data;
  }
}

class AvailableZoneList {
  AvailableZoneList({this.id, this.name, this.displayName, this.modules});

  AvailableZoneList.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    displayName = json['display_name'] as String?;
    modules =
        (json['modules'] as List?)?.map((e) => e as String).toList() ?? [];
  }
  int? id;
  String? name;
  String? displayName;
  List<String>? modules;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['display_name'] = displayName;
    data['modules'] = modules;
    return data;
  }
}
