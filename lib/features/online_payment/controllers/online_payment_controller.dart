import 'package:get/get.dart';
import 'package:scan_sa_user/features/online_payment/domain/services/online_payment_service_interface.dart';

class OnlinePaymentController extends GetxController implements GetxService {
  OnlinePaymentController({required this.onlinePaymentServiceInterface});
  final OnlinePaymentServiceInterface onlinePaymentServiceInterface;
}
