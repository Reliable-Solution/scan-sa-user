import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/offline_method_model.dart';

abstract class PaymentServiceInterface {
  Future<List<OfflineMethodModel>?> getOfflineMethodList();
  Future<bool> saveOfflineInfo(String data);
  Future<bool> updateOfflineInfo(String data);
}
