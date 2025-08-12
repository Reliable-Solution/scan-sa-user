class SupportModel {
  SupportModel({this.totalSize, this.limit, this.offset, this.data});

  SupportModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'] as int?;
    limit = json['limit'] as int?;
    offset = json['offset'] as int?;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? totalSize;
  int? limit;
  int? offset;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Data({this.id, this.message, this.translations});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    message = json['message'] as String?;
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(Translations.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? id;
  String? message;
  List<Translations>? translations;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
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
