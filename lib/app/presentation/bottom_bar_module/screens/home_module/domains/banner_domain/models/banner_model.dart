import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/basic_campaign_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';

class BannerModel {
  BannerModel({this.campaigns, this.banners});

  BannerModel.fromJson(Map<String, dynamic> json) {
    if (json['campaigns'] != null) {
      campaigns = [];
      json['campaigns'].forEach((v) {
        campaigns!.add(BasicCampaignModel.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners!.add(Banner.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<BasicCampaignModel>? campaigns;
  List<Banner>? banners;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (campaigns != null) {
      data['campaigns'] = campaigns!.map((v) => v.toJson()).toList();
    }
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banner {
  Banner({
    this.id,
    this.title,
    this.type,
    this.imageFullUrl,
    this.link,
    this.store,
    this.item,
  });

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    type = json['type'] as String?;
    imageFullUrl = json['image_full_url'] as String?;
    link = json['link'] as String?;
    store = json['store'] != null
        ? Store.fromJson(json['store'] as Map<String, dynamic>)
        : null;
    item = json['item'] != null
        ? Items.fromJson(json['item'] as Map<String, dynamic>)
        : null;
  }
  int? id;
  String? title;
  String? type;
  String? imageFullUrl;
  String? link;
  Store? store;
  Items? item;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['image_full_url'] = imageFullUrl;
    data['link'] = link;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}
