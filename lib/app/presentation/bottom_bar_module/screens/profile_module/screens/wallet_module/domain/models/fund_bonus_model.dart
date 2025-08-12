class FundBonusModel {
  FundBonusModel({
    this.id,
    this.title,
    this.description,
    this.bonusType,
    this.bonusAmount,
    this.minimumAddAmount,
    this.maximumBonusAmount,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.translations,
  });

  FundBonusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    description = json['description'] as String?;
    bonusType = json['bonus_type'] as String?;
    bonusAmount = json['bonus_amount'] as num?;
    minimumAddAmount = json['minimum_add_amount'] as num?;
    maximumBonusAmount = json['maximum_bonus_amount'] as num?;
    startDate = json['start_date'] as String?;
    endDate = json['end_date'] as String?;
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
  String? description;
  String? bonusType;
  num? bonusAmount;
  num? minimumAddAmount;
  num? maximumBonusAmount;
  String? startDate;
  String? endDate;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Translations>? translations;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['bonus_type'] = bonusType;
    data['bonus_amount'] = bonusAmount;
    data['minimum_add_amount'] = minimumAddAmount;
    data['maximum_bonus_amount'] = maximumBonusAmount;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
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
