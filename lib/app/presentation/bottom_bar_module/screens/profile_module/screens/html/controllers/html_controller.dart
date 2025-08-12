import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/html/domain/services/html_service_interface.dart';

class HtmlController extends GetxController implements GetxService {
  HtmlController({required this.htmlServiceInterface});
  final HtmlServiceInterface htmlServiceInterface;

  String? _htmlText;
  String? get htmlText => _htmlText;

  Future<void> getHtmlText(bool isPrivacyPolicy) async {
    _htmlText = null;
    final response = await htmlServiceInterface.getHtmlText(isPrivacyPolicy);
    if (response.statusCode == 200) {
      final body = response.body as String?;
      if (body != null && body.isNotEmpty && response.body is String) {
        _htmlText = body.replaceAll('href=', 'target="_blank" href=');
      } else {
        _htmlText = '';
      }
    }
    update();
  }
}
