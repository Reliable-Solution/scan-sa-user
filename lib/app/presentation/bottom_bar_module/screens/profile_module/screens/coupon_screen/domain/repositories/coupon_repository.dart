import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/models/coupon_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/domain/repositories/coupon_repository_interface.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class CouponRepository implements CouponRepositoryInterface {
  CouponRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<dynamic> getList({
    int? offset,
    bool couponList = false,
    bool taxiCouponList = false,
  }) async {
    if (couponList) {
      return _getCouponList();
    } else if (taxiCouponList) {
      return _getTaxiCouponList();
    }
  }

  Future<List<CouponModel>?> _getCouponList() async {
    List<CouponModel>? couponList;
    final response = await apiClient.getData(AppConstants.couponUri);
    if (response.statusCode == 200) {
      couponList = [];
      response.body.forEach((category) {
        final coupon = CouponModel.fromJson(category as Map<String, dynamic>);
        couponList!.add(coupon);
      });
    }
    return couponList;
  }

  Future<List<CouponModel>?> _getTaxiCouponList() async {
    List<CouponModel>? taxiCouponList;
    final response = await apiClient.getData(AppConstants.taxiCouponUri);
    if (response.statusCode == 200) {
      taxiCouponList = [];
      response.body.forEach(
        (category) => taxiCouponList!.add(
          CouponModel.fromJson(category as Map<String, dynamic>),
        ),
      );
    }
    return taxiCouponList;
  }

  @override
  Future<CouponModel?> applyCoupon(String couponCode, int? storeID) async {
    CouponModel? couponModel;
    final response = await apiClient.getData(
      '${AppConstants.couponApplyUri}$couponCode&store_id=$storeID',
    );
    if (response.statusCode == 200) {
      couponModel = CouponModel.fromJson(response.body as Map<String, dynamic>);
    }
    return couponModel;
  }

  @override
  Future<CouponModel?> applyTaxiCoupon(
    String couponCode,
    int? providerId,
  ) async {
    CouponModel? taxiCouponModel;
    final response = await apiClient.getData(
      '${AppConstants.taxiCouponApplyUri}$couponCode&provider_id=$providerId',
    );
    if (response.statusCode == 200) {
      taxiCouponModel = CouponModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return taxiCouponModel;
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
