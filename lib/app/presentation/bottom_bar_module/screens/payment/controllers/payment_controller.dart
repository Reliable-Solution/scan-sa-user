import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/offline_method_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/payment/domain/services/payment_service_interface.dart';

class PaymentController extends GetxController implements GetxService {
  PaymentController({required this.paymentServiceInterface});
  final PaymentServiceInterface paymentServiceInterface;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<OfflineMethodModel>? _offlineMethodList;
  List<OfflineMethodModel>? get offlineMethodList => _offlineMethodList;

  List<TextEditingController> informationControllerList = [];
  List<FocusNode> informationFocusList = [];

  int _selectedOfflineBankIndex = 0;
  int get selectedOfflineBankIndex => _selectedOfflineBankIndex;

  Future<void> getOfflineMethodList() async {
    _offlineMethodList = await paymentServiceInterface.getOfflineMethodList();
    update();
  }

  void selectOfflineBank(int index, {bool canUpdate = true}) {
    _selectedOfflineBankIndex = index;
    if (canUpdate) {
      update();
    }
  }

  void changesMethod({bool canUpdate = true}) {
    final methodInformation =
        offlineMethodList![selectedOfflineBankIndex].methodInformations;

    informationControllerList = [];
    informationFocusList = [];

    for (var index = 0; index < (methodInformation?.length ?? 0); index++) {
      informationControllerList.add(TextEditingController());
      informationFocusList.add(FocusNode());
    }
    if (canUpdate) {
      update();
    }
  }

  Future<bool> saveOfflineInfo(String data) async {
    _isLoading = true;
    update();
    final success = await paymentServiceInterface.saveOfflineInfo(data);
    _isLoading = false;
    update();
    return success;
  }

  Future<bool> updateOfflineInfo(String data) async {
    _isLoading = true;
    update();
    final success = await paymentServiceInterface.updateOfflineInfo(data);
    _isLoading = false;
    update();
    return success;
  }

  void changeLoadingStatus(bool status) {
    _isLoading = status;
    update();
  }
}
