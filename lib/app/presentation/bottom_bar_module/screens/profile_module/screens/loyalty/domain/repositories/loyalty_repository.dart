import 'package:get/get_connect.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/domain/repositories/loyalty_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/model/transaction_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class LoyaltyRepository implements LoyaltyRepositoryInterface {
  LoyaltyRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<Response<dynamic>> pointToWallet({int? point}) async {
    return apiClient.postData(AppConstants.loyaltyPointTransferUri, {
      'point': point,
    });
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
  Future<TransactionModel?> getList({int? offset}) async {
    return _getLoyaltyTransactionList(offset);
  }

  Future<TransactionModel?> _getLoyaltyTransactionList(int? offset) async {
    TransactionModel? transactionModel;
    final response = await apiClient.getData(
      '${AppConstants.loyaltyTransactionUri}?offset=$offset&limit=10',
    );
    if (response.statusCode == 200) {
      transactionModel = TransactionModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return transactionModel;
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
