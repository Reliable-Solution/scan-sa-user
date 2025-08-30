// To parse this JSON data, do
//
//     final storeMenuModel = storeMenuModelFromJson(jsonString);

import 'dart:convert';

StoreMenuModel storeMenuModelFromJson(String str) =>
    StoreMenuModel.fromJson(json.decode(str));

String storeMenuModelToJson(StoreMenuModel data) => json.encode(data.toJson());

class StoreMenuModel {
  StoreMenuModel({
    this.success,
    this.message,
    this.data,
  });

  factory StoreMenuModel.fromJson(Map<String, dynamic> json) => StoreMenuModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MenuModelData>.from(
                json["data"]!.map((x) => MenuModelData.fromJson(x)),
              ),
      );
  final bool? success;
  final String? message;
  final List<MenuModelData>? data;

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MenuModelData {
  MenuModelData({
    this.id,
    this.storeId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory MenuModelData.fromJson(Map<String, dynamic> json) => MenuModelData(
        id: json["id"],
        storeId: json["store_id"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
      );
  final int? id;
  final int? storeId;
  final String? image;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "image": image,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image_url": imageUrl,
      };
}
