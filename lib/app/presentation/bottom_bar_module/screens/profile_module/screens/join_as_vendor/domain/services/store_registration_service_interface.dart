import 'package:get/get_connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/package_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/store_body_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_data_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';

abstract class StoreRegistrationServiceInterface {
  Future<List<ZoneDataModel>?> getZoneList();
  int? prepareSelectedZoneIndex(
    List<int>? zoneIds,
    List<ZoneDataModel>? zoneList,
  );
  Future<List<ModuleModel>?> getModules(int? zoneId);
  Future<Response<dynamic>> registerStore(
    StoreBodyModel store,
    XFile? logo,
    XFile? cover,
  );
  Future<bool> checkInZone(String? lat, String? lng, int zoneId);
  Future<PackageModel?> getPackageList({int? moduleId});
}
