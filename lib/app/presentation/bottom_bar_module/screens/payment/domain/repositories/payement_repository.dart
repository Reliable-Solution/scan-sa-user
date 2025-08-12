import 'dart:convert';

import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/offline_method_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/payment/domain/repositories/payment_repository_interface.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentRepository implements PaymentRepositoryInterface {
  PaymentRepository({required this.apiClient, required this.sharedPreferences});
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

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
      response.body.forEach(
        (method) => offlineMethodList!.add(
          OfflineMethodModel.fromJson(method as Map<String, dynamic>),
        ),
      );
    }
    return offlineMethodList;
  }

  @override
  Future<bool> saveOfflineInfo(String data) async {
    final response = await apiClient.postData(
      AppConstants.offlinePaymentSaveInfoUri,
      jsonDecode(data),
    );
    return (response.statusCode == 200);
  }

  @override
  Future<bool> updateOfflineInfo(String data) async {
    final response = await apiClient.postData(
      AppConstants.offlinePaymentUpdateInfoUri,
      jsonDecode(data),
    );
    return (response.statusCode == 200);
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
