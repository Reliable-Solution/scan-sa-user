import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/repositories/deliveryman_registration_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/package_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/store_body_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/repositories/store_registration_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/services/store_registration_service_interface.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_data_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';

class StoreRegistrationService implements StoreRegistrationServiceInterface {
  StoreRegistrationService({
    required this.deliverymanRegistrationRepositoryInterface,
    required this.storeRegistrationRepoInterface,
  });
  final StoreRegistrationRepositoryInterface storeRegistrationRepoInterface;
  final DeliverymanRegistrationRepositoryInterface
  deliverymanRegistrationRepositoryInterface;

  @override
  Future<List<ZoneDataModel>?> getZoneList() async {
    return (await deliverymanRegistrationRepositoryInterface.getList())
        as List<ZoneDataModel>?;
  }

  @override
  int? prepareSelectedZoneIndex(
    List<int>? zoneIds,
    List<ZoneDataModel>? zoneList,
  ) {
    int? selectedZoneIndex = 0;
    for (var index = 0; index < zoneList!.length; index++) {
      if (zoneIds!.contains(zoneList[index].id)) {
        selectedZoneIndex = index;
        break;
      }
    }
    return selectedZoneIndex;
  }

  @override
  Future<List<ModuleModel>?> getModules(int? zoneId) async {
    return (await deliverymanRegistrationRepositoryInterface.getList(
          isZone: false,
          zoneId: zoneId,
        ))
        as List<ModuleModel>?;
  }

  @override
  Future<Response<dynamic>> registerStore(
    StoreBodyModel store,
    XFile? logo,
    XFile? cover,
  ) async {
    return storeRegistrationRepoInterface.registerStore(store, logo, cover);
  }

  @override
  Future<bool> checkInZone(String? lat, String? lng, int zoneId) async {
    return storeRegistrationRepoInterface.checkInZone(lat, lng, zoneId);
  }

  @override
  Future<PackageModel?> getPackageList({int? moduleId}) async {
    return storeRegistrationRepoInterface.getPackageList(moduleId: moduleId);
  }
}
