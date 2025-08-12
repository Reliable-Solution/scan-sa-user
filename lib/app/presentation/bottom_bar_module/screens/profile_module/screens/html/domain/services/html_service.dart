import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/domain/repositories/html_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/domain/services/html_service_interface.dart';

class HtmlService implements HtmlServiceInterface {
  HtmlService({required this.htmlRepositoryInterface});
  final HtmlRepositoryInterface htmlRepositoryInterface;

  @override
  Future<Response<dynamic>> getHtmlText(bool isPrivacyPolicy) async {
    return htmlRepositoryInterface.getHtmlText(isPrivacyPolicy);
  }
}
