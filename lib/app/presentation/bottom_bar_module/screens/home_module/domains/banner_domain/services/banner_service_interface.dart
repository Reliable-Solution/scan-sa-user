import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/others_banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/promotional_banner_model.dart';

abstract class BannerServiceInterface {
  Future<BannerModel?> getBannerList({required DataSourceEnum source});
  Future<BannerModel?> getTaxiBannerList();
  Future<BannerModel?> getFeaturedBannerList();
  Future<ParcelOtherBannerModel?> getParcelOtherBannerList({
    required DataSourceEnum source,
  });
  Future<PromotionalBanner?> getPromotionalBannerList();
  List<int?> moduleIdList();
}
