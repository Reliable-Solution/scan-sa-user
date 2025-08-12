import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/model/transaction_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/models/fund_bonus_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/models/wallet_filter_body_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/domain/services/wallet_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/utils/app_constants.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher_string.dart';

class WalletController extends GetxController implements GetxService {
  WalletController({required this.walletServiceInterface});
  final WalletServiceInterface walletServiceInterface;

  List<Transaction> _transactionList = [];
  List<Transaction> get transactionList => _transactionList;

  List<String> _offsetList = [];

  int _offset = 1;
  int get offset => _offset;

  int? _pageSize;
  int? get popularPageSize => _pageSize;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;

  bool _amountEmpty = true;
  bool get amountEmpty => _amountEmpty;

  List<FundBonusModel>? _fundBonusList;
  List<FundBonusModel>? get fundBonusList => _fundBonusList;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  String _type = 'all';
  String get type => _type;

  List<WalletFilterBodyModel> _walletFilterList = [];
  List<WalletFilterBodyModel> get walletFilterList => _walletFilterList;

  void setWalletFilerType(String type, {bool isUpdate = true}) {
    _type = type;
    if (isUpdate) {
      update();
    }
  }

  void insertFilterList() {
    _walletFilterList = [];
    for (var i = 0; i < AppConstants.walletTransactionSortingList.length; i++) {
      _walletFilterList.add(
        WalletFilterBodyModel.fromJson(
          AppConstants.walletTransactionSortingList[i],
        ),
      );
    }
  }

  void changeDigitalPaymentName(String name, {bool isUpdate = true}) {
    _digitalPaymentName = name;
    if (isUpdate) {
      update();
    }
  }

  void isTextFieldEmpty(String value, {bool isUpdate = true}) {
    _amountEmpty = value.isNotEmpty;
    if (isUpdate) {
      update();
    }
  }

  void setOffset(int offset) {
    _offset = offset;
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  Future<void> getWalletTransactionList(
    String offset,
    bool reload,
    String walletType,
  ) async {
    _isLoading = true;
    update();
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      _transactionList = [];
      if (reload) {
        update();
      }
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final transactionModel = await walletServiceInterface
          .getWalletTransactionList(offset, walletType);

      if (offset == '1') {
        _transactionList = [];
      }
      if (transactionModel?.data != null) {
        _transactionList.addAll(transactionModel!.data!);

        _pageSize = transactionModel.totalSize;
      }

      _isLoading = false;
      update();
    } else {
      if (isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  Future<void> addFundToWallet(num amount, String paymentMethod) async {
    EasyLoading.load();
    final response = await walletServiceInterface.addFundToWallet(
      amount,
      paymentMethod,
    );
    if (response.statusCode == 200) {
      final redirectUrl = response.body['redirect_link'] as String;
      Get.back();
      if (GetPlatform.isWeb) {
        html.window.open(redirectUrl, '_self');
      } else {
        await launchUrlString(redirectUrl);
        // Get.toNamed(
        //   RouteHelper.getPaymentRoute(
        //     '0',
        //     0,
        //     '',
        //     0,
        //     false,
        //     '',
        //     addFundUrl: redirectUrl,
        //     guestId: '',
        //   ),
        // );
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> getWalletBonusList({bool isUpdate = true}) async {
    _isLoading = true;
    if (isUpdate) {
      update();
    }

    final bonuses = await walletServiceInterface.getWalletBonusList();
    if (bonuses != null) {
      _fundBonusList = [];
      _fundBonusList!.addAll(bonuses);

      _isLoading = false;
      update();
    }
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }

  void setWalletAccessToken(String accessToken) {
    walletServiceInterface.setWalletAccessToken(accessToken);
  }

  String getWalletAccessToken() {
    return walletServiceInterface.getWalletAccessToken();
  }

  @override
  void onInit() {
    insertFilterList();
    super.onInit();
  }
}
