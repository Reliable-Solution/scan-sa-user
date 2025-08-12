import 'package:get/get_connect/http/src/response/response.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class LoyaltyRepositoryInterface extends RepositoryInterface<dynamic> {
  Future<Response<dynamic>> pointToWallet({int? point});
}
