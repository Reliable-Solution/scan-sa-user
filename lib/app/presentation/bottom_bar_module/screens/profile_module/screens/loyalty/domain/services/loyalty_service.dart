import 'package:get/get_connect/http/src/response/response.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/domain/repositories/loyalty_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/domain/services/loyalty_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/model/transaction_model.dart';

class LoyaltyService implements LoyaltyServiceInterface {
  LoyaltyService({required this.loyaltyRepositoryInterface});
  final LoyaltyRepositoryInterface loyaltyRepositoryInterface;

  @override
  Future<TransactionModel?> getLoyaltyTransactionList(String offset) async {
    return (await loyaltyRepositoryInterface.getList(offset: int.parse(offset)))
        as TransactionModel?;
  }

  @override
  Future<Response<dynamic>> pointToWallet({int? point}) async {
    return loyaltyRepositoryInterface.pointToWallet(point: point);
  }
}
