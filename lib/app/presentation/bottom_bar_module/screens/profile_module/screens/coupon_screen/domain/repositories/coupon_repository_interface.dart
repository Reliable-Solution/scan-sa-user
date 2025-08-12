import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class CouponRepositoryInterface extends RepositoryInterface<dynamic> {
  @override
  Future<dynamic> getList({
    int? offset,
    bool couponList = false,
    bool taxiCouponList = false,
  });
  Future<dynamic> applyCoupon(String couponCode, int? storeID);
  Future<dynamic> applyTaxiCoupon(String couponCode, int? providerId);
}
