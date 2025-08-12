import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class WalletRepositoryInterface extends RepositoryInterface<dynamic> {
  Future<dynamic> addFundToWallet(num amount, String paymentMethod);
  Future<void> setWalletAccessToken(String token);
  String getWalletAccessToken();
  @override
  Future<dynamic> getList({
    int? offset,
    String? sortingType,
    bool isBonusList = false,
  });
}
