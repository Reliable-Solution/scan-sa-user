class CategoryModel {
  CategoryModel({
    int? id,
    String? name,
    int? parentId,
    int? position,
    String? createdAt,
    String? updatedAt,
    String? imageFullUrl,
  }) {
    _id = id;
    _name = name;
    _parentId = parentId;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageFullUrl = imageFullUrl;
  }

  CategoryModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'] as int?;
    _name = json['name'] as String?;
    _parentId = json['parent_id'] as int?;
    _position = json['position'] as int?;
    _createdAt = json['created_at'] as String?;
    _updatedAt = json['updated_at'] as String?;
    _imageFullUrl = json['image_full_url'] as String?;
  }
  int? _id;
  String? _name;
  int? _parentId;
  int? _position;
  String? _createdAt;
  String? _updatedAt;
  String? _imageFullUrl;

  int? get id => _id;
  String? get name => _name;
  int? get parentId => _parentId;
  int? get position => _position;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageFullUrl => _imageFullUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['parent_id'] = _parentId;
    data['position'] = _position;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['image_full_url'] = _imageFullUrl;

    return data;
  }
}
