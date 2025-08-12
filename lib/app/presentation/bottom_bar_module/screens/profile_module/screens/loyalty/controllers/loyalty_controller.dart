import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/edit_profile/controller/edit_profile_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/domain/services/loyalty_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/model/transaction_model.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';

class LoyaltyController extends GetxController implements GetxService {
  LoyaltyController({required this.loyaltyServiceInterface});
  final LoyaltyServiceInterface loyaltyServiceInterface;

  List<Transaction> _transactionList = [];
  List<Transaction> get transactionList => _transactionList;

  List<String> _offsetList = [];

  int _offset = 1;
  int get offset => _offset;

  int? _pageSize;
  int? get popularPageSize => _pageSize;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getLoyaltyTransactionList(String offset, bool reload) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      _transactionList = [];
      if (reload) {
        _isLoading = true;
        update();
      }
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final transactionModel = await loyaltyServiceInterface
          .getLoyaltyTransactionList(offset);

      if (transactionModel != null) {
        if (offset == '1') {
          _transactionList = [];
        }
        _transactionList.addAll(transactionModel.data!);
        _pageSize = transactionModel.totalSize;

        _isLoading = false;
        update();
      }
    } else {
      if (isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  Future<void> pointToWallet(int point) async {
    _isLoading = true;
    update();
    final response = await loyaltyServiceInterface.pointToWallet(point: point);
    if (response.statusCode == 200) {
      Get.back();
      await getLoyaltyTransactionList('1', true);
      await Get.find<EditProfileController>().getUserInfo();
      showCustomSnackBar(
        'converted_successfully_transfer_to_your_wallet'.tr,
        isError: false,
      );
    }
    _isLoading = false;
    update();
  }

  void setOffset(int offset) {
    _offset = offset;
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}
