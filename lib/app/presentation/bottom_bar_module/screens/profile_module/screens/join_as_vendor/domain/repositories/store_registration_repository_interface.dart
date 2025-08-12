import 'package:get/get_connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/package_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/domain/models/store_body_model.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class StoreRegistrationRepositoryInterface
    extends RepositoryInterface<dynamic> {
  Future<Response<dynamic>> registerStore(
    StoreBodyModel store,
    XFile? logo,
    XFile? cover,
  );
  Future<bool> checkInZone(String? lat, String? lng, int zoneId);
  Future<PackageModel?> getPackageList({int? moduleId});
}
