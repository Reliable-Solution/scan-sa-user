class Translation {
  Translation({this.id, this.locale, this.key, this.value});

  Translation.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    locale = json['locale'] as String?;
    key = json['key'] as String?;
    value = json['value'] as String?;
  }
  int? id;
  String? locale;
  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['locale'] = locale;
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
