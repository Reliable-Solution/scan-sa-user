import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/model/transaction_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/models/fund_bonus_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/repositories/wallet_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/services/wallet_service_interface.dart';

class WalletService implements WalletServiceInterface {
  WalletService({required this.walletRepositoryInterface});
  final WalletRepositoryInterface walletRepositoryInterface;

  @override
  Future<TransactionModel?> getWalletTransactionList(
    String offset,
    String sortingType,
  ) async {
    return (await walletRepositoryInterface.getList(
          offset: int.parse(offset),
          sortingType: sortingType,
        ))
        as TransactionModel?;
  }

  @override
  Future<dynamic> addFundToWallet(num amount, String paymentMethod) async {
    return walletRepositoryInterface.addFundToWallet(amount, paymentMethod);
  }

  @override
  Future<List<FundBonusModel>> getWalletBonusList() async {
    return ((await walletRepositoryInterface.getList(isBonusList: true))
            as List<FundBonusModel>?) ??
        [];
  }

  @override
  Future<void> setWalletAccessToken(String token) {
    return walletRepositoryInterface.setWalletAccessToken(token);
  }

  @override
  String getWalletAccessToken() {
    return walletRepositoryInterface.getWalletAccessToken();
  }
}
