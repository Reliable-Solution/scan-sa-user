import 'package:get/get.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class HtmlRepositoryInterface implements RepositoryInterface<dynamic> {
  Future<Response<dynamic>> getHtmlText(bool isPrivacyPolicy);
}
