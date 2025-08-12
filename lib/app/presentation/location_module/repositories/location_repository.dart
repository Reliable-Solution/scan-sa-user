import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/models/zone_response_model.dart';
import 'package:scan_sa_user/app/presentation/location_module/repositories/location_repository_interface.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class LocationRepository implements LocationRepositoryInterface<AddressModel> {
  LocationRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<String> getAddressFromGeocode(LatLng latLng) async {
    final response = await apiClient.getData(
      '${AppConstants.geocodeUri}?lat=${latLng.latitude}&lng=${latLng.longitude}',
      handleError: false,
    );
    var address = 'Unknown Location Found';
    if (response.statusCode == 200 && response.body['status'] == 'OK') {
      address = response.body['results'][0]['formatted_address'].toString();
    } else {
      showCustomSnackBar(
        response.body['error_message'] as String? ?? response.bodyString,
      );
    }
    return address;
  }

  @override
  Future<ZoneResponseModel> getZone(
    String? lat,
    String? lng, {
    bool handleError = false,
  }) async {
    final response = await apiClient.getData(
      '${AppConstants.zoneUri}?lat=$lat&lng=$lng',
      handleError: handleError,
    );
    if (response.statusCode == 200) {
      final zoneIds = ZoneModel.fromJson(
        response.body as Map<String, dynamic>,
      ).zoneIds;
      final zoneData = ZoneModel.fromJson(
        response.body as Map<String, dynamic>,
      ).zoneData;

      return ZoneResponseModel(
        true,
        '',
        zoneIds ?? [],
        zoneData ?? [],
        [],
        response.statusCode,
      );
    } else {
      return ZoneResponseModel(
        false,
        response.statusText,
        [],
        [],
        [],
        response.statusCode,
      );
    }
  }

  @override
  Future<Response<dynamic>> searchLocation(String text) async {
    return apiClient.getData(
      '${AppConstants.searchLocationUri}?search_text=$text',
    );
  }

  @override
  Future<Response<dynamic>> get(String? id) async {
    final response = await apiClient.getData(
      '${AppConstants.placeDetailsUri}?placeid=$id',
    );
    return response;
  }

  @override
  Future<ResponseModel> add(AddressModel addressModel) async {
    return _addAddress(addressModel);
  }

  Future<ResponseModel> _addAddress(AddressModel addressModel) async {
    final response = await apiClient.postData(
      AppConstants.addAddressUri,
      addressModel.toJson(),
      handleError: false,
    );
    if (response.statusCode == 200) {
      final message =
          response.body['message'] as String? ?? 'Address added successfully';
      final zoneIds = <int>[];
      response.body['zone_ids'].forEach(zoneIds.add);
      return ResponseModel(true, message, zoneIds: zoneIds);
    } else {
      return ResponseModel(
        false,
        response.statusText == 'Out of coverage!'
            ? 'service_not_available_in_this_area'.tr
            : response.statusText,
      );
    }
  }

  @override
  Future<ResponseModel> delete(int? id) async {
    return _removeAddressByID(id);
  }

  Future<ResponseModel> _removeAddressByID(int? id) async {
    final response = await apiClient.postData(
      '${AppConstants.removeAddressUri}$id',
      {'_method': 'delete'},
      handleError: false,
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        true,
        response.body['message'] as String? ?? 'Address removed successfully',
      );
    } else {
      return ResponseModel(false, response.statusText);
    }
  }

  @override
  Future<List<AddressModel>?> getList({int? offset}) async {
    return _getAllAddress();
  }

  Future<List<AddressModel>?> _getAllAddress() async {
    List<AddressModel>? addressList;
    final response = await apiClient.getData(AppConstants.addressListUri);
    if (response.statusCode == 200) {
      addressList = [];
      response.body['addresses'].forEach((address) {
        addressList!.add(
          AddressModel.fromJson(address as Map<String, dynamic>),
        );
      });
    }
    return addressList;
  }

  @override
  Future<ResponseModel> update(Map<String, dynamic> body, int? id) async {
    return _updateAddress(body, id);
  }

  Future<ResponseModel> _updateAddress(
    Map<String, dynamic> addressBody,
    int? addressId,
  ) async {
    final response = await apiClient.putData(
      '${AppConstants.updateAddressUri}$addressId',
      addressBody,
    );
    if (response.statusCode == 200) {
      return ResponseModel(
        true,
        response.body['message'] as String? ?? 'Address updated successfully',
      );
    } else {
      return ResponseModel(false, response.statusText);
    }
  }
}
