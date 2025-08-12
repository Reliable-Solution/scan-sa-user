import 'dart:convert';

import 'package:get/get.dart';
import 'package:scan_sa_user/common/models/address_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderHelper {
  static Map<String, String> featuredHeader() {
    final sharedPreferences = Get.find<SharedPreferences>();
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(
        jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!)
            as Map<String, dynamic>,
      );
    } catch (_) {}
    int? moduleID;
    if (GetPlatform.isWeb &&
        sharedPreferences.containsKey(AppConstants.moduleId)) {
      try {
        moduleID = ModuleModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.moduleId)!)
              as Map<String, dynamic>,
        ).id;
      } catch (_) {}
    }
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.zoneId: addressModel?.zoneIds != null
          ? jsonEncode(addressModel?.zoneIds)
          : '',
      moduleID != null ? AppConstants.moduleId : '$moduleID': '',
      AppConstants.localizationKey:
          sharedPreferences.getString(AppConstants.languageCode) ??
          AppConstants.languages[0].languageCode!,
      AppConstants.latitude: addressModel?.latitude != null
          ? jsonEncode(addressModel?.latitude)
          : '',
      AppConstants.longitude: addressModel?.longitude != null
          ? jsonEncode(addressModel?.longitude)
          : '',
      // 'Authorization': 'Bearer $token'
    };
  }
}
