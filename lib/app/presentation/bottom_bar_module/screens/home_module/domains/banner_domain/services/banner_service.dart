import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/others_banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/promotional_banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/repositories/banner_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/services/banner_service_interface.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';
import 'package:scan_sa_user/helper/address_helper.dart';

class BannerService implements BannerServiceInterface {
  BannerService({required this.bannerRepositoryInterface});
  final BannerRepositoryInterface bannerRepositoryInterface;

  @override
  Future<BannerModel?> getBannerList({required DataSourceEnum source}) async {
    return await bannerRepositoryInterface.getList(
          isBanner: true,
          source: source,
        )
        as BannerModel?;
  }

  @override
  Future<BannerModel?> getTaxiBannerList() async {
    return await bannerRepositoryInterface.getList(isTaxiBanner: true)
        as BannerModel?;
  }

  @override
  Future<BannerModel?> getFeaturedBannerList() async {
    return await bannerRepositoryInterface.getList(isFeaturedBanner: true)
        as BannerModel?;
  }

  @override
  Future<ParcelOtherBannerModel?> getParcelOtherBannerList({
    required DataSourceEnum source,
  }) async {
    return await bannerRepositoryInterface.getList(
          isParcelOtherBanner: true,
          source: source,
        )
        as ParcelOtherBannerModel?;
  }

  @override
  Future<PromotionalBanner?> getPromotionalBannerList() async {
    return await bannerRepositoryInterface.getList(isPromotionalBanner: true)
        as PromotionalBanner?;
  }

  @override
  List<int?> moduleIdList() {
    final moduleIdList = <int?>[];
    for (final zone
        in AddressHelper.getUserAddressFromSharedPref()!.zoneData!) {
      for (final module in zone.modules ?? <Modules>[]) {
        moduleIdList.add(module.id);
      }
    }
    return moduleIdList;
  }
}
