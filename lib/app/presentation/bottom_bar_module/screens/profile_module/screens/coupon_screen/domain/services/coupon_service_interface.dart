import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/models/coupon_model.dart';

abstract class CouponServiceInterface {
  Future<List<CouponModel>?> getCouponList();
  Future<List<CouponModel>?> getTaxiCouponList();
  Future<CouponModel?> applyCoupon(String couponCode, int? storeID);
  Future<CouponModel?> applyTaxiCoupon(String couponCode, int? providerId);
}
