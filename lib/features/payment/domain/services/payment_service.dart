import 'package:scan_sa_user/features/payment/domain/models/offline_method_model.dart';
import 'package:scan_sa_user/features/payment/domain/repositories/payment_repository_interface.dart';
import 'package:scan_sa_user/features/payment/domain/services/payment_service_interface.dart';

class PaymentService implements PaymentServiceInterface {
  PaymentService({required this.paymentRepositoryInterface});
  final PaymentRepositoryInterface paymentRepositoryInterface;

  @override
  Future<List<OfflineMethodModel>?> getOfflineMethodList() async {
    return await paymentRepositoryInterface.getList();
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
