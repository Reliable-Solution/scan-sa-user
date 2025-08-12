import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/models/delivery_man_body.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/models/delivery_man_vehicles_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/repositories/deliveryman_registration_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_data_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliverymanRegistrationRepository
    implements DeliverymanRegistrationRepositoryInterface {
  DeliverymanRegistrationRepository({
    required this.sharedPreferences,
    required this.apiClient,
  });
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  @override
  Future<bool> registerDeliveryMan(
    DeliveryManBody deliveryManBody,
    List<MultipartBody> multiParts,
  ) async {
    final response = await apiClient.postMultipartData(
      AppConstants.dmRegisterUri,
      deliveryManBody.toJson(),
      multiParts,
    );
    return (response.statusCode == 200);
  }

  @override
  Future<dynamic> getList({
    int? offset,
    int? zoneId,
    bool isZone = true,
    bool isVehicle = false,
  }) async {
    if (isZone) {
      return _getZoneList();
    } else if (isVehicle) {
      return _getVehicleList();
    } else {
      return _getModules(zoneId);
    }
  }

  Future<List<ZoneDataModel>?> _getZoneList() async {
    List<ZoneDataModel>? zoneList;
    final response = await apiClient.getData(AppConstants.zoneListUri);
    if (response.statusCode == 200) {
      zoneList = [];
      response.body.forEach(
        (zone) =>
            zoneList!.add(ZoneDataModel.fromJson(zone as Map<String, dynamic>)),
      );
    }
    return zoneList;
  }

  Future<List<ModuleModel>?> _getModules(int? zoneId) async {
    List<ModuleModel>? moduleList;
    final response = await apiClient.getData(
      '${AppConstants.moduleUri}?zone_id=$zoneId',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        AppConstants.localizationKey:
            sharedPreferences.getString(AppConstants.languageCode) ??
            AppConstants.languages[0].languageCode!,
      },
    );
    if (response.statusCode == 200) {
      moduleList = [];
      response.body.forEach(
        (storeCategory) => moduleList!.add(
          ModuleModel.fromJson(storeCategory as Map<String, dynamic>),
        ),
      );
    }
    return moduleList;
  }

  Future<List<DeliveryManVehicleModel>?> _getVehicleList() async {
    List<DeliveryManVehicleModel>? vehicles;
    final response = await apiClient.getData(AppConstants.vehiclesUri);
    if (response.statusCode == 200) {
      vehicles = [];
      response.body.forEach(
        (vehicle) => vehicles!.add(
          DeliveryManVehicleModel.fromJson(vehicle as Map<String, dynamic>),
        ),
      );
    }
    return vehicles;
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
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
}
