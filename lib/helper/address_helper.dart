import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressHelper {
  static Future<bool> saveUserAddressInSharedPref(AddressModel address) async {
    final sharedPreferences = Get.find<SharedPreferences>();
    final userAddress = jsonEncode(address.toJson());
    Get.find<GlobalController>()
      ..addressModel.value = address
      ..update();
    Get.find<ApiClient>().updateHeader(
      token: sharedPreferences.getString(AppConstants.token),
      zoneIDs: address.zoneIds,
      operationIds: [],
      languageCode: sharedPreferences.getString(AppConstants.languageCode),
      latitude: address.latitude,
      longitude: address.longitude,
    );
    return sharedPreferences.setString(AppConstants.userAddress, userAddress);
  }

  static AddressModel? getUserAddressFromSharedPref() {
    final sharedPreferences = Get.find<SharedPreferences>();
    AddressModel? addressModel;
    if (sharedPreferences.getString(AppConstants.userAddress)?.isNotEmpty ??
        false) {
      try {
        addressModel = AddressModel.fromJson(
          jsonDecode(
                sharedPreferences.getString(AppConstants.userAddress) ?? '{}',
              )
              as Map<String, dynamic>,
        );
        Get.find<GlobalController>()
          ..addressModel.value = addressModel
          ..update();
      } catch (e) {
        if (!GetPlatform.isWeb) {
          debugPrint('Address Catch exception : $e');
        }
      }
    }
    return addressModel;
  }

  static bool clearAddressFromSharedPref() {
    final sharedPreferences = Get.find<SharedPreferences>();
    sharedPreferences.remove(AppConstants.userAddress);
    return true;
  }
}
