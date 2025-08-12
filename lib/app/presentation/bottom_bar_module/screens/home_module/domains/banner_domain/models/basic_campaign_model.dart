import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';

class BasicCampaignModel {
  BasicCampaignModel({
    this.id,
    this.title,
    this.imageFullUrl,
    this.description,
    this.availableDateStarts,
    this.availableDateEnds,
    this.startTime,
    this.endTime,
    this.store,
  });

  BasicCampaignModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    imageFullUrl = json['image_full_url'] as String?;
    description = json['description'] as String?;
    availableDateStarts = json['available_date_starts'] as String?;
    availableDateEnds = json['available_date_ends'] as String?;
    startTime = json['start_time'] as String?;
    endTime = json['end_time'] as String?;
    if (json['stores'] != null) {
      store = [];
      json['stores'].forEach((v) {
        store!.add(Store.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? id;
  String? title;
  String? imageFullUrl;
  String? description;
  String? availableDateStarts;
  String? availableDateEnds;
  String? startTime;
  String? endTime;
  List<Store>? store;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_full_url'] = imageFullUrl;
    data['description'] = description;
    data['available_date_starts'] = availableDateStarts;
    data['available_date_ends'] = availableDateEnds;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    if (store != null) {
      data['stores'] = store!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
