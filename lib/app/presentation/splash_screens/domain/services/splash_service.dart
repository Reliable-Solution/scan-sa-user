// import 'package:get/get.dart';
// import 'package:scan_sa_user/api/local_client.dart';
// import 'package:scan_sa_user/app/presentation/splash_screens/domain/models/landing_model.dart';
// import 'package:scan_sa_user/app/presentation/splash_screens/domain/repositories/splash_repository_interface.dart';
// import 'package:scan_sa_user/app/presentation/splash_screens/domain/services/splash_service_interface.dart';
// import 'package:scan_sa_user/common/models/config_model.dart';
// import 'package:scan_sa_user/common/models/module_model.dart';
// import 'package:scan_sa_user/common/models/response_model.dart';

// class SplashService implements SplashServiceInterface {
//   SplashService({required this.splashRepositoryInterface});
//   final SplashRepositoryInterface splashRepositoryInterface;

//   @override
//   Future<Response<dynamic>> getConfigData({
//     required DataSourceEnum source,
//   }) async {
//     final response = await splashRepositoryInterface.getConfigData(
//       source: source,
//     );
//     return response;
//   }

//   @override
//   ConfigModel? prepareConfigData(Response<dynamic> response) {
//     ConfigModel? configModel;
//     if (response.statusCode == 200) {
//       configModel = ConfigModel.fromJson(response.body as Map<String, dynamic>);
//     }
//     return configModel;
//   }

//   @override
//   Future<LandingModel?> getLandingPageData({
//     required DataSourceEnum source,
//   }) async {
//     return splashRepositoryInterface.getLandingPageData(source: source);
//   }

//   @override
//   Future<ModuleModel?> initSharedData() async {
//     return splashRepositoryInterface.initSharedData();
//   }

//   @override
//   void disableIntro() {
//     splashRepositoryInterface.disableIntro();
//   }

//   @override
//   bool? showIntro() {
//     return splashRepositoryInterface.showIntro();
//   }

//   @override
//   Future<void> setStoreCategory(int storeCategoryID) async {
//     return splashRepositoryInterface.setStoreCategory(storeCategoryID);
//   }

//   @override
//   Future<List<ModuleModel>?> getModules({
//     Map<String, String>? headers,
//     required DataSourceEnum source,
//   }) async {
//     return splashRepositoryInterface.getModules(
//       headers: headers,
//       source: source,
//     );
//   }

//   @override
//   Future<void> setModule(ModuleModel? module) async {
//     return splashRepositoryInterface.setModule(module);
//   }

//   @override
//   Future<ModuleModel?> setCacheModule(ModuleModel? module) async {
//     return splashRepositoryInterface.setCacheModule(module);
//   }

//   @override
//   ModuleModel? getCacheModule() {
//     return splashRepositoryInterface.getCacheModule();
//   }

//   @override
//   ModuleModel? getModule() {
//     return splashRepositoryInterface.getModule();
//   }

//   @override
//   Future<ResponseModel> subscribeEmail(String email) async {
//     return splashRepositoryInterface.subscribeEmail(email);
//   }

//   @override
//   bool getSavedCookiesData() {
//     return splashRepositoryInterface.getSavedCookiesData();
//   }

//   @override
//   Future<void> saveCookiesData(bool data) async {
//     return splashRepositoryInterface.saveCookiesData(data);
//   }

//   @override
//   void cookiesStatusChange(String? data) {
//     splashRepositoryInterface.cookiesStatusChange(data);
//   }

//   @override
//   bool getAcceptCookiesStatus(String data) {
//     return splashRepositoryInterface.getAcceptCookiesStatus(data);
//   }

//   @override
//   bool getSuggestedLocationStatus() {
//     return splashRepositoryInterface.getSuggestedLocationStatus();
//   }

//   @override
//   Future<void> saveSuggestedLocationStatus(bool data) async {
//     return splashRepositoryInterface.saveSuggestedLocationStatus(data);
//   }

//   @override
//   bool getReferBottomSheetStatus() {
//     return splashRepositoryInterface.getReferBottomSheetStatus();
//   }

//   @override
//   Future<void> saveReferBottomSheetStatus(bool data) async {
//     return splashRepositoryInterface.saveReferBottomSheetStatus(data);
//   }
// }
