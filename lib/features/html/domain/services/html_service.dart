import 'package:get/get.dart';
import 'package:scan_sa_user/features/html/domain/repositories/html_repository_interface.dart';
import 'package:scan_sa_user/features/html/domain/services/html_service_interface.dart';
import 'package:scan_sa_user/util/html_type.dart';

class HtmlService implements HtmlServiceInterface {
  HtmlService({required this.htmlRepositoryInterface});
  final HtmlRepositoryInterface htmlRepositoryInterface;

  @override
  Future<Response> getHtmlText(HtmlType htmlType) async {
    return await htmlRepositoryInterface.getHtmlText(htmlType);
  }
}
