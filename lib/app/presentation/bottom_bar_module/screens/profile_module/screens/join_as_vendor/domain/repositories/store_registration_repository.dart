import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/package_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/store_body_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/repositories/store_registration_repository_interface.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class StoreRegistrationRepository
    implements StoreRegistrationRepositoryInterface {
  StoreRegistrationRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<Response<dynamic>> registerStore(
    StoreBodyModel store,
    XFile? logo,
    XFile? cover,
  ) async {
    final response = await apiClient.postMultipartData(
      AppConstants.storeRegisterUri,
      store.toJson(),
      [MultipartBody('logo', logo), MultipartBody('cover_photo', cover)],
    );
    return response;
  }

  @override
  Future<bool> checkInZone(String? lat, String? lng, int zoneId) async {
    final response = await apiClient.getData(
      '${AppConstants.checkZoneUri}?lat=$lat&lng=$lng&zone_id=$zoneId',
    );
    if (response.statusCode == 200) {
      return response.body as bool;
    } else {
      return response.body as bool;
    }
  }

  @override
  Future<PackageModel?> getPackageList({int? moduleId}) async {
    PackageModel? packageModel;
    final response = await apiClient.getData(
      '${AppConstants.storePackagesUri}?module_id=$moduleId',
    );
    if (response.statusCode == 200) {
      packageModel = PackageModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return packageModel;
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

  @override
  Future<void> getList({int? offset}) {
    throw UnimplementedError();
  }
}
