import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class LocationRepositoryInterface<T>
    implements RepositoryInterface<AddressModel> {
  Future<String> getAddressFromGeocode(LatLng latLng);
  Future<ZoneResponseModel> getZone(
    String? lat,
    String? lng, {
    bool handleError = false,
  });
  Future<Response<dynamic>> searchLocation(String text);
}
