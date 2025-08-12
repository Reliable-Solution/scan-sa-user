import 'dart:convert';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/others_banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/promotional_banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/repositories/banner_repository_interface.dart';
import 'package:scan_sa_user/helper/header_helper.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class BannerRepository implements BannerRepositoryInterface {
  BannerRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<dynamic> getList({
    int? offset,
    bool isBanner = false,
    bool isTaxiBanner = false,
    bool isFeaturedBanner = false,
    bool isParcelOtherBanner = false,
    bool isPromotionalBanner = false,
    DataSourceEnum? source,
  }) async {
    if (isBanner) {
      return _getBannerList(source: source!);
    } else if (isTaxiBanner) {
      return _getTaxiBannerList();
    } else if (isFeaturedBanner) {
      return _getFeaturedBannerList();
    } else if (isParcelOtherBanner) {
      return _getParcelOtherBannerList();
    } else if (isPromotionalBanner) {
      return _getPromotionalBannerList();
    }
    return null;
  }

  Future<BannerModel?> _getBannerList({required DataSourceEnum source}) async {
    BannerModel? bannerModel;
    const cacheId = AppConstants.bannerUri;

    switch (source) {
      case DataSourceEnum.client:
        final response = await apiClient.getData(AppConstants.bannerUri);
        if (response.statusCode == 200) {
          bannerModel = BannerModel.fromJson(
            response.body as Map<String, dynamic>,
          );
          await LocalClient.organize(
            source,
            cacheId,
            jsonEncode(response.body),
            apiClient.getHeader(),
          );
        }
      case DataSourceEnum.local:
        final cacheResponseData = await LocalClient.organize(
          source,
          cacheId,
          null,
          null,
        );
        if (cacheResponseData != null) {
          bannerModel = BannerModel.fromJson(
            jsonDecode(cacheResponseData) as Map<String, dynamic>,
          );
        }
    }

    return bannerModel;
  }

  Future<BannerModel?> _getTaxiBannerList() async {
    BannerModel? bannerModel;
    final response = await apiClient.getData(AppConstants.taxiBannerUri);
    if (response.statusCode == 200) {
      bannerModel = BannerModel.fromJson(response.body as Map<String, dynamic>);
    }
    return bannerModel;
  }

  Future<BannerModel?> _getFeaturedBannerList() async {
    BannerModel? bannerModel;
    final response = await apiClient.getData(
      '${AppConstants.bannerUri}?featured=1',
      headers: HeaderHelper.featuredHeader(),
    );
    if (response.statusCode == 200) {
      bannerModel = BannerModel.fromJson(response.body as Map<String, dynamic>);
    }
    return bannerModel;
  }

  Future<ParcelOtherBannerModel?> _getParcelOtherBannerList() async {
    ParcelOtherBannerModel? parcelOtherBannerModel;
    final response = await apiClient.getData(AppConstants.parcelOtherBannerUri);
    if (response.statusCode == 200) {
      parcelOtherBannerModel = ParcelOtherBannerModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return parcelOtherBannerModel;
  }

  Future<PromotionalBanner?> _getPromotionalBannerList() async {
    PromotionalBanner? promotionalBanner;
    final response = await apiClient.getData(AppConstants.promotionalBannerUri);
    if (response.statusCode == 200 && response.body is Map) {
      promotionalBanner = PromotionalBanner.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return promotionalBanner;
  }

  @override
  Future<void> add(dynamic value) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future<void> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
