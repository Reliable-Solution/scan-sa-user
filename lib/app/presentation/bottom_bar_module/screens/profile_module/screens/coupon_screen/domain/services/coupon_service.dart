import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/models/coupon_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/repositories/coupon_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/services/coupon_service_interface.dart';

class CouponService implements CouponServiceInterface {
  CouponService({required this.couponRepositoryInterface});
  final CouponRepositoryInterface couponRepositoryInterface;

  @override
  Future<List<CouponModel>?> getCouponList() async {
    return (await couponRepositoryInterface.getList(couponList: true))
        as List<CouponModel>?;
  }

  @override
  Future<List<CouponModel>?> getTaxiCouponList() async {
    return (await couponRepositoryInterface.getList(taxiCouponList: true))
        as List<CouponModel>?;
  }

  @override
  Future<CouponModel?> applyCoupon(String couponCode, int? storeID) async {
    return (await couponRepositoryInterface.applyCoupon(couponCode, storeID))
        as CouponModel?;
  }

  @override
  Future<CouponModel?> applyTaxiCoupon(
    String couponCode,
    int? providerId,
  ) async {
    return (await couponRepositoryInterface.applyTaxiCoupon(
          couponCode,
          providerId,
        ))
        as CouponModel?;
  }
}
