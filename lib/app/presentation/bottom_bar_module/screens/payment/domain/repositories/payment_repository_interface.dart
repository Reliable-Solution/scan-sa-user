import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class PaymentRepositoryInterface extends RepositoryInterface<dynamic> {
  Future<bool> saveOfflineInfo(String data);
  Future<bool> updateOfflineInfo(String data);
}
