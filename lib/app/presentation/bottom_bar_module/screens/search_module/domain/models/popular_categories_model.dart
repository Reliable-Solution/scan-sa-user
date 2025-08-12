class PopularCategoryModel {
  PopularCategoryModel({
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
    this.featured,
    this.imageFullUrl,
  });

  PopularCategoryModel.fromJson(Map<String, dynamic> json) {
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
    featured = json['featured'] as int?;
    imageFullUrl = json['image_full_url'] as String?;
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
  int? featured;
  String? imageFullUrl;

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
    data['featured'] = featured;
    data['image_full_url'] = imageFullUrl;
    return data;
  }
}
