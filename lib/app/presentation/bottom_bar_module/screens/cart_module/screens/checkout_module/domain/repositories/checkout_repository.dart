import 'package:get/get_connect/connect.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/offline_method_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/place_order_body_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/repositories/checkout_repository_interface.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutRepository implements CheckoutRepositoryInterface {
  CheckoutRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  @override
  Future<int> getDmTipMostTapped() async {
    var mostDmTipAmount = 0;
    final response = await apiClient.getData(AppConstants.mostTipsUri);
    if (response.statusCode == 200) {
      mostDmTipAmount = response.body['most_tips_amount'] as int? ?? 0;
    }
    return mostDmTipAmount;
  }

  @override
  Future<bool> saveSharedPrefDmTipIndex(String index) async {
    return sharedPreferences.setString(AppConstants.dmTipIndex, index);
  }

  @override
  String getSharedPrefDmTipIndex() {
    return sharedPreferences.getString(AppConstants.dmTipIndex) ?? '';
  }

  @override
  Future<Response<dynamic>> getDistanceInMeter(
    LatLng originLatLng,
    LatLng destinationLatLng,
  ) async {
    return apiClient.getData(
      '${AppConstants.distanceMatrixUri}?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
      '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}&mode=WALK',
      handleError: false,
    );
  }

  @override
  Future<num> getExtraCharge(num? distance) async {
    num extraCharge = 0;
    final response = await apiClient.getData(
      '${AppConstants.vehicleChargeUri}?distance=$distance',
      handleError: false,
    );
    if (response.statusCode == 200) {
      extraCharge = num.parse(response.body.toString());
    }
    return extraCharge;
  }

  @override
  Future<Response<dynamic>> placeOrder(
    PlaceOrderBodyModel orderBody,
    List<MultipartBody>? orderAttachment,
  ) async {
    return apiClient.postMultipartData(
      AppConstants.placeOrderUri,
      orderBody.toJson(),
      orderAttachment ?? [],
      handleError: false,
    );
  }

  @override
  Future<Response<dynamic>> placePrescriptionOrder(
    int? storeId,
    num? distance,
    String address,
    String longitude,
    String latitude,
    String note,
    List<MultipartBody> orderAttachment,
    String dmTips,
    String deliveryInstruction,
  ) async {
    final body = <String, String>{
      'store_id': storeId.toString(),
      'distance': distance.toString(),
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'order_note': note,
      'dm_tips': dmTips,
      'delivery_instruction': deliveryInstruction,
    };
    return apiClient.postMultipartData(
      AppConstants.placePrescriptionOrderUri,
      body,
      orderAttachment,
      handleError: false,
    );
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
  Future<List<OfflineMethodModel>?> getList({int? offset}) async {
    return _getOfflineMethodList();
  }

  Future<List<OfflineMethodModel>?> _getOfflineMethodList() async {
    List<OfflineMethodModel>? offlineMethodList;
    final response = await apiClient.getData(AppConstants.offlineMethodListUri);
    if (response.statusCode == 200) {
      offlineMethodList = [];
      if (response.body is List) {
        for (final method in (response.body as List)) {
          offlineMethodList.add(
            OfflineMethodModel.fromJson(method as Map<String, dynamic>),
          );
        }
      }
    }
    return offlineMethodList;
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
