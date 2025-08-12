import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/offline_method_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/payment/domain/repositories/payment_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/payment/domain/services/payment_service_interface.dart';

class PaymentService implements PaymentServiceInterface {
  PaymentService({required this.paymentRepositoryInterface});
  final PaymentRepositoryInterface paymentRepositoryInterface;

  @override
  Future<List<OfflineMethodModel>?> getOfflineMethodList() async {
    return (await paymentRepositoryInterface.getList())
        as List<OfflineMethodModel>?;
  }

  @override
  Future<bool> saveOfflineInfo(String data) async {
    return paymentRepositoryInterface.saveOfflineInfo(data);
  }

  @override
  Future<bool> updateOfflineInfo(String data) async {
    return paymentRepositoryInterface.updateOfflineInfo(data);
  }
}
