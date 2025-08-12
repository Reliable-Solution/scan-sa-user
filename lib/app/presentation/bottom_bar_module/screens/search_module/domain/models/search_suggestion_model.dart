class SearchSuggestionModel {
  SearchSuggestionModel({this.items, this.stores});

  SearchSuggestionModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<Items>? items;
  List<Stores>? stores;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  Items({this.id, this.name, this.image, this.unitType, this.imageFullUrl});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    image = json['image'] as String?;
    unitType = json['unit_type'] as String?;
    imageFullUrl = json['image_full_url'] as String?;
  }
  int? id;
  String? name;
  String? image;
  String? unitType;
  String? imageFullUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['unit_type'] = unitType;
    return data;
  }
}

class Stores {
  Stores({
    this.id,
    this.name,
    this.logo,
    this.gstStatus,
    this.gstCode,
    this.logoFullUrl,
  });

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    logo = json['logo'] as String?;
    gstStatus = json['gst_status'] as bool?;
    gstCode = json['gst_code'] as String?;
    logoFullUrl = json['logo_full_url'] as String?;
  }
  int? id;
  String? name;
  String? logo;
  bool? gstStatus;
  String? gstCode;
  String? logoFullUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    data['gst_status'] = gstStatus;
    data['gst_code'] = gstCode;
    data['logo_full_url'] = logoFullUrl;
    return data;
  }
}
