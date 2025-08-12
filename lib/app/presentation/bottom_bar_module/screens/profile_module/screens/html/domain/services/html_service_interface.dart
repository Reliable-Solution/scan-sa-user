import 'package:get/get.dart';

abstract class HtmlServiceInterface {
  Future<Response<dynamic>> getHtmlText(bool isPrivacyPolicy);
}
