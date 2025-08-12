class PackageModel {
  PackageModel({this.packages});

  PackageModel.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<Packages>? packages;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  Packages({
    this.id,
    this.packageName,
    this.price,
    this.validity,
    this.maxOrder,
    this.maxProduct,
    this.pos,
    this.mobileApp,
    this.chat,
    this.review,
    this.selfDelivery,
    this.status,
    this.def,
    this.createdAt,
    this.updatedAt,
    this.color,
  });

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    packageName = json['package_name'] as String?;
    price = json['price'].toDouble() as num?;
    validity = json['validity'] as int?;
    maxOrder = json['max_order'] as String?;
    maxProduct = json['max_product'] as String?;
    pos = json['pos'] as int?;
    mobileApp = json['mobile_app'] as int?;
    chat = json['chat'] as int?;
    review = json['review'] as int?;
    selfDelivery = json['self_delivery'] as int?;
    status = json['status'] as int?;
    def = json['default'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    color = json['colour'] as String?;
  }
  int? id;
  String? packageName;
  num? price;
  int? validity;
  String? maxOrder;
  String? maxProduct;
  int? pos;
  int? mobileApp;
  int? chat;
  int? review;
  int? selfDelivery;
  int? status;
  int? def;
  String? createdAt;
  String? updatedAt;
  String? color;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['package_name'] = packageName;
    data['price'] = price;
    data['validity'] = validity;
    data['max_order'] = maxOrder;
    data['max_product'] = maxProduct;
    data['pos'] = pos;
    data['mobile_app'] = mobileApp;
    data['chat'] = chat;
    data['review'] = review;
    data['self_delivery'] = selfDelivery;
    data['status'] = status;
    data['default'] = def;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['colour'] = color;
    return data;
  }
}
