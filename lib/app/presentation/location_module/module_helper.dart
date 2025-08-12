import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/common/models/config_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';

class ModuleHelper {
  static ModuleModel? getModule() {
    return Get.find<GlobalController>().module;
  }

  static ModuleModel? getCacheModule() {
    return Get.find<GlobalController>().cacheModule;
  }

  static Module? getModuleConfig(String? moduleType) {
    return Get.find<GlobalController>().getModuleConfig(moduleType);
  }
}
