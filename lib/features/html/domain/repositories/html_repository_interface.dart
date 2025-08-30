import 'package:scan_sa_user/interfaces/repository_interface.dart';
import 'package:scan_sa_user/util/html_type.dart';

abstract class HtmlRepositoryInterface extends RepositoryInterface {
  Future<dynamic> getHtmlText(HtmlType htmlType);
}
