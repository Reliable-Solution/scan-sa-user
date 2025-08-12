import 'package:get/get.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/model/transaction_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/models/fund_bonus_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/repositories/wallet_repository_interface.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

class WalletRepository implements WalletRepositoryInterface {
  WalletRepository({required this.apiClient, required this.sharedPreferences});
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  @override
  Future<Response<dynamic>> addFundToWallet(
    num amount,
    String paymentMethod,
  ) async {
    final hostname = html.window.location.hostname;
    final protocol = html.window.location.protocol;

    return apiClient.postData(AppConstants.addFundUri, {
      'amount': amount,
      'payment_method': paymentMethod,
      'payment_platform': GetPlatform.isWeb ? 'web' : '',
      'callback': '$protocol//$hostname/wallet',
    });
  }

  @override
  Future<void> setWalletAccessToken(String token) {
    return sharedPreferences.setString(AppConstants.walletAccessToken, token);
  }

  @override
  String getWalletAccessToken() {
    return sharedPreferences.getString(AppConstants.walletAccessToken) ?? '';
  }

  @override
  Future<void> add(dynamic value) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future<void> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> getList({
    int? offset,
    String? sortingType,
    bool isBonusList = false,
  }) async {
    if (isBonusList) {
      return _getWalletBonusList();
    } else {
      return _getWalletTransactionList(offset.toString(), sortingType!);
    }
  }

  Future<TransactionModel?> _getWalletTransactionList(
    String offset,
    String sortingType,
  ) async {
    TransactionModel? transactionModel;
    final response = await apiClient.getData(
      '${AppConstants.walletTransactionUri}?offset=$offset&limit=10&type=$sortingType',
    );
    if (response.statusCode == 200) {
      transactionModel = TransactionModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return transactionModel;
  }

  Future<List<FundBonusModel>?> _getWalletBonusList() async {
    List<FundBonusModel>? fundBonusList;
    final response = await apiClient.getData(AppConstants.walletBonusUri);
    if (response.statusCode == 200) {
      fundBonusList = [];
      response.body.forEach((value) {
        fundBonusList!.add(
          FundBonusModel.fromJson(value as Map<String, dynamic>),
        );
      });
    }
    return fundBonusList;
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
