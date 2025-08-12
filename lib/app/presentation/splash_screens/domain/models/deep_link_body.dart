enum DeepLinkType { restaurant, cuisine, category }

class DeepLinkBody {
  DeepLinkBody({this.deepLinkType, this.id, this.name});

  DeepLinkBody.fromJson(Map<String, dynamic> json) {
    deepLinkType = convertToEnum(json['deepLinkType'] as String?);
    id = json['id'] as int?;
    name = json['name'] as String?;
  }
  DeepLinkType? deepLinkType;
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['deepLinkType'] = deepLinkType.toString();
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  DeepLinkType convertToEnum(String? enumString) {
    if (enumString == DeepLinkType.restaurant.toString()) {
      return DeepLinkType.restaurant;
    } else if (enumString == DeepLinkType.cuisine.toString()) {
      return DeepLinkType.cuisine;
    } else {
      return DeepLinkType.category;
    }
  }
}
