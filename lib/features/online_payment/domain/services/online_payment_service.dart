import 'package:scan_sa_user/features/online_payment/domain/repositories/online_payment_repo_interface.dart';
import 'online_payment_service_interface.dart';

class OnlinePaymentService implements OnlinePaymentServiceInterface {
  OnlinePaymentService({required this.onlinePaymentRepoInterface});
  final OnlinePaymentRepoInterface onlinePaymentRepoInterface;
}
