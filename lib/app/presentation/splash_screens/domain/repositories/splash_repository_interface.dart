// import 'package:get/get_connect/connect.dart';
// import 'package:scan_sa_user/api/local_client.dart';
// import 'package:scan_sa_user/app/presentation/splash_screens/domain/models/landing_model.dart';
// import 'package:scan_sa_user/common/models/module_model.dart';
// import 'package:scan_sa_user/common/models/response_model.dart';
// import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

// abstract class SplashRepositoryInterface extends RepositoryInterface<dynamic> {
//   Future<Response<dynamic>> getConfigData({required DataSourceEnum source});
//   Future<LandingModel?> getLandingPageData({required DataSourceEnum source});
//   Future<ModuleModel?> initSharedData();
//   void disableIntro();
//   bool? showIntro();
//   Future<void> setStoreCategory(int storeCategoryID);
//   Future<List<ModuleModel>?> getModules({
//     Map<String, String>? headers,
//     required DataSourceEnum source,
//   });
//   Future<void> setModule(ModuleModel? module);
//   Future<ModuleModel?> setCacheModule(ModuleModel? module);
//   ModuleModel? getCacheModule();
//   ModuleModel? getModule();
//   Future<ResponseModel> subscribeEmail(String email);
//   bool getSavedCookiesData();
//   Future<void> saveCookiesData(bool data);
//   void cookiesStatusChange(String? data);
//   bool getAcceptCookiesStatus(String data);
//   bool getSuggestedLocationStatus();
//   Future<void> saveSuggestedLocationStatus(bool data);
//   bool getReferBottomSheetStatus();
//   Future<void> saveReferBottomSheetStatus(bool data);
// }
