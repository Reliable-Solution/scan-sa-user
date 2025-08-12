import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class BannerRepositoryInterface
    implements RepositoryInterface<dynamic> {
  @override
  Future<dynamic> getList({
    int? offset,
    bool isBanner = false,
    bool isTaxiBanner = false,
    bool isFeaturedBanner = false,
    bool isParcelOtherBanner = false,
    bool isPromotionalBanner = false,
    DataSourceEnum? source,
  });
}
