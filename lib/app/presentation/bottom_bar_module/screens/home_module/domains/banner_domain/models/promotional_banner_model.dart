class PromotionalBanner {
  PromotionalBanner({
    this.basicSectionNearbyFullUrl,
    this.bottomSectionBannerFullUrl,
  });

  PromotionalBanner.fromJson(Map<String, dynamic> json) {
    basicSectionNearbyFullUrl =
        json['basic_section_nearby_full_url'] as String?;
    bottomSectionBannerFullUrl =
        json['bottom_section_banner_full_url'] as String?;
  }
  String? basicSectionNearbyFullUrl;
  String? bottomSectionBannerFullUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['basic_section_nearby_full_url'] = basicSectionNearbyFullUrl;
    data['bottom_section_banner_full_url'] = bottomSectionBannerFullUrl;
    return data;
  }
}
