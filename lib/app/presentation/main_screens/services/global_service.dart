import 'package:get/get.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/userinfo_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/repositories/global_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/services/global_service_interface.dart';
import 'package:scan_sa_user/app/presentation/splash_screens/domain/models/landing_model.dart';
import 'package:scan_sa_user/common/models/config_model.dart';
import 'package:scan_sa_user/common/models/module_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';

class GlobalService implements GlobalServiceInterface {
  GlobalService({required this.globalRepositoryInterface});
  final GlobalRepositoryInterface globalRepositoryInterface;

  @override
  Future<Response<dynamic>> getConfigData({
    required DataSourceEnum source,
  }) async {
    final response = await globalRepositoryInterface.getConfigData(
      source: source,
    );
    return response;
  }

  @override
  ConfigModel? prepareConfigData(Response<dynamic> response) {
    ConfigModel? configModel;
    if (response.statusCode == 200) {
      configModel = ConfigModel.fromJson(response.body as Map<String, dynamic>);
    }
    return configModel;
  }

  @override
  Future<LandingModel?> getLandingPageData({
    required DataSourceEnum source,
  }) async {
    return globalRepositoryInterface.getLandingPageData(source: source);
  }

  @override
  Future<ModuleModel?> initSharedData() async {
    return globalRepositoryInterface.initSharedData();
  }

  @override
  void disableIntro() {
    globalRepositoryInterface.disableIntro();
  }

  @override
  bool? showIntro() {
    return globalRepositoryInterface.showIntro();
  }

  @override
  Future<void> setStoreCategory(int storeCategoryID) async {
    return globalRepositoryInterface.setStoreCategory(storeCategoryID);
  }

  @override
  Future<List<ModuleModel>?> getModules({
    Map<String, String>? headers,
    required DataSourceEnum source,
  }) async {
    return globalRepositoryInterface.getModules(
      headers: headers,
      source: source,
    );
  }

  @override
  Future<void> setModule(ModuleModel? module) async {
    return globalRepositoryInterface.setModule(module);
  }

  @override
  Future<ModuleModel?> setCacheModule(ModuleModel? module) async {
    return globalRepositoryInterface.setCacheModule(module);
  }

  @override
  ModuleModel? getCacheModule() {
    return globalRepositoryInterface.getCacheModule();
  }

  @override
  ModuleModel? getModule() {
    return globalRepositoryInterface.getModule();
  }

  @override
  Future<ResponseModel> subscribeEmail(String email) async {
    return globalRepositoryInterface.subscribeEmail(email);
  }

  @override
  bool getSavedCookiesData() {
    return globalRepositoryInterface.getSavedCookiesData();
  }

  @override
  Future<void> saveCookiesData(bool data) async {
    return globalRepositoryInterface.saveCookiesData(data);
  }

  @override
  void cookiesStatusChange(String? data) {
    globalRepositoryInterface.cookiesStatusChange(data);
  }

  @override
  bool getAcceptCookiesStatus(String data) {
    return globalRepositoryInterface.getAcceptCookiesStatus(data);
  }

  @override
  bool getSuggestedLocationStatus() {
    return globalRepositoryInterface.getSuggestedLocationStatus();
  }

  @override
  Future<void> saveSuggestedLocationStatus(bool data) async {
    return globalRepositoryInterface.saveSuggestedLocationStatus(data);
  }

  @override
  bool getReferBottomSheetStatus() {
    return globalRepositoryInterface.getReferBottomSheetStatus();
  }

  @override
  Future<void> saveReferBottomSheetStatus(bool data) async {
    return globalRepositoryInterface.saveReferBottomSheetStatus(data);
  }

  @override
  Future<UserInfoModel?> getUserInfo() async {
    return (await globalRepositoryInterface.get(null)) as UserInfoModel?;
  }
}
