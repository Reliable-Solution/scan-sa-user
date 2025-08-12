import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';

class BasicMedicineModel {
  BasicMedicineModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.products,
    this.categories,
  });

  BasicMedicineModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'] as int?;
    limit = json['limit'] as String?;
    offset = json['offset'] as String?;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(Item.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? totalSize;
  String? limit;
  String? offset;
  List<Item>? products;
  List<Categories>? categories;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryIds {
  CategoryIds({this.id, this.position, this.name});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    position = json['position'] as int?;
    name = json['name'] as String?;
  }
  String? id;
  int? position;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['position'] = position;
    data['name'] = name;
    return data;
  }
}

class Unit {
  Unit({this.id, this.unit, this.createdAt, this.updatedAt});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    unit = json['unit'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }
  int? id;
  String? unit;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['unit'] = unit;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Module {
  Module({
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
  });

  Module.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Categories {
  Categories({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.position,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.priority,
    this.moduleId,
    this.slug,
    this.featured,
    this.productsCount,
    this.childesCount,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    image = json['image'] as String?;
    parentId = json['parent_id'] as int?;
    position = json['position'] as int?;
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    priority = json['priority'] as int?;
    moduleId = json['module_id'] as int?;
    slug = json['slug'] as String?;
    featured = json['featured'] as int?;
    productsCount = json['products_count'] as int?;
    childesCount = json['childes_count'] as int?;
  }
  int? id;
  String? name;
  String? image;
  int? parentId;
  int? position;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? priority;
  int? moduleId;
  String? slug;
  int? featured;
  int? productsCount;
  int? childesCount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['parent_id'] = parentId;
    data['position'] = position;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['priority'] = priority;
    data['module_id'] = moduleId;
    data['slug'] = slug;
    data['featured'] = featured;
    data['products_count'] = productsCount;
    data['childes_count'] = childesCount;
    return data;
  }
}
