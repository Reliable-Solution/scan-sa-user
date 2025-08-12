import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/model/transaction_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/models/fund_bonus_model.dart';

abstract class WalletServiceInterface {
  Future<TransactionModel?> getWalletTransactionList(
    String offset,
    String sortingType,
  );
  Future<dynamic> addFundToWallet(num amount, String paymentMethod);
  Future<List<FundBonusModel>?> getWalletBonusList();
  Future<void> setWalletAccessToken(String token);
  String getWalletAccessToken();
}
