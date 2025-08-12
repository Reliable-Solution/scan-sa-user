import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/models/business_plan_body.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/domain/repositories/business_repo_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/package_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class BusinessRepo implements BusinessRepoInterface {
  BusinessRepo({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<Response<dynamic>> setUpBusinessPlan(
    BusinessPlanBody businessPlanBody,
  ) async {
    return apiClient.postData(
      AppConstants.businessPlanUri,
      businessPlanBody.toJson(),
    );
  }

  @override
  Future<Response<dynamic>> subscriptionPayment(
    String id,
    String? paymentName,
  ) async {
    const callback = '';

    return apiClient.postData(AppConstants.businessPlanPaymentUri, {
      'id': id,
      'payment_gateway': paymentName,
      'callback': callback,
    });
  }

  @override
  Future<PackageModel?> getList({int? offset}) async {
    PackageModel? packageModel;
    final response = await apiClient.getData(AppConstants.storePackagesUri);
    if (response.statusCode == 200) {
      packageModel = PackageModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return packageModel;
  }

  @override
  Future<dynamic> add(dynamic value) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
