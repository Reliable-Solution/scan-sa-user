import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/domain/repositories/html_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class HtmlRepository implements HtmlRepositoryInterface {
  HtmlRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<Response<dynamic>> getHtmlText(bool isPrivacyPolicy) async {
    return apiClient.getData(
      isPrivacyPolicy
          ? AppConstants.privacyPolicyUri
          : AppConstants.termsAndConditionUri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        AppConstants.moduleId: '',
        AppConstants.localizationKey:
            Get.find<GlobalController>().locale.value.languageCode,
      },
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
  Future<dynamic> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getList({int? offset}) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
