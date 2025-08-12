import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/order_cancellation_body.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/order_details_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/order_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/repositories/order_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/services/order_service_interface.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';

class OrderService implements OrderServiceInterface {
  OrderService({required this.orderRepositoryInterface});
  final OrderRepositoryInterface orderRepositoryInterface;

  @override
  Future<PaginatedOrderModel?> getRunningOrderList(
    int offset,
    bool fromDashboard,
  ) async {
    return (await orderRepositoryInterface.getList(
          isRunningOrder: true,
          offset: offset,
          fromDashboard: fromDashboard,
        ))
        as PaginatedOrderModel?;
  }

  @override
  Future<PaginatedOrderModel?> getHistoryOrderList(int offset) async {
    return (await orderRepositoryInterface.getList(
          isHistoryOrder: true,
          offset: offset,
        ))
        as PaginatedOrderModel;
  }

  @override
  Future<List<String?>?> getSupportReasonsList() async {
    return (await orderRepositoryInterface.getList(isSupportReasons: true))
        as List<String?>?;
  }

  @override
  Future<List<OrderDetailsModel>?> getOrderDetails(
    String orderID,
    String? guestId,
  ) async {
    return (await orderRepositoryInterface.get(orderID, guestId: guestId))
        as List<OrderDetailsModel>?;
  }

  @override
  Future<List<CancellationData>?> getCancelReasons() async {
    return (await orderRepositoryInterface.getList(isCancelReasons: true))
        as List<CancellationData>?;
  }

  @override
  Future<List<String?>?> getRefundReasons() async {
    return (await orderRepositoryInterface.getList(isRefundReasons: true))
        as List<String?>?;
  }

  @override
  Future<void> submitRefundRequest(
    int selectedReasonIndex,
    List<String?>? refundReasons,
    String note,
    String? orderId,
    XFile? refundImage,
  ) async {
    if (selectedReasonIndex == 0) {
      showCustomSnackBar('please_select_reason'.tr);
    } else {
      final body = <String, String>{};
      body.addAll(<String, String>{
        'customer_reason': refundReasons![selectedReasonIndex]!,
        'order_id': orderId!,
        'customer_note': note,
      });
      final response = await orderRepositoryInterface.submitRefundRequest(
        body,
        refundImage,
      );
      if (response.statusCode == 200) {
        showCustomSnackBar(response.body['message'] as String?, isError: false);
        // Get.offAllNamed(RouteHelper.getInitialRoute());
      }
    }
  }

  @override
  Future<Response<dynamic>> trackOrder(
    String? orderID,
    String? guestId, {
    String? contactNumber,
  }) async {
    return orderRepositoryInterface.trackOrder(
      orderID,
      guestId,
      contactNumber: contactNumber,
    );
  }

  @override
  Future<bool> cancelOrder(
    String orderID,
    String? reason, {
    String? guestId,
  }) async {
    return orderRepositoryInterface.cancelOrder(
      orderID,
      reason,
      guestId: guestId,
    );
  }

  @override
  OrderModel? prepareOrderModel(
    PaginatedOrderModel? runningOrderModel,
    int? orderID,
  ) {
    OrderModel? orderModel;
    if (runningOrderModel != null) {
      for (final order in runningOrderModel.orders!) {
        if (order.id == orderID) {
          orderModel = order;
          break;
        }
      }
    }
    return orderModel;
  }

  @override
  Future<bool> switchToCOD(String? orderID, {String? guestId}) async {
    var isSuccess = false;
    final response = await orderRepositoryInterface.switchToCOD(
      orderID,
      guestId: guestId,
    );
    if (response.statusCode == 200) {
      isSuccess = true;
      // await Get.offAllNamed(RouteHelper.getInitialRoute());
      showCustomSnackBar(response.body['message'] as String, isError: false);
    }
    return isSuccess;
  }

  @override
  void paymentRedirect({
    required String url,
    required bool canRedirect,
    required String? contactNumber,
    required Function onClose,
    required String? addFundUrl,
    required String? subscriptionUrl,
    required String orderID,
    int? storeId,
    required bool createAccount,
    required String guestId,
  }) {
    // final forOrder =
    //     addFundUrl == '' &&
    //     addFundUrl!.isEmpty &&
    //     subscriptionUrl == '' &&
    //     subscriptionUrl!.isEmpty;
    // final forSubscription =
    //     subscriptionUrl != null &&
    //     subscriptionUrl.isNotEmpty &&
    //     addFundUrl == '' &&
    //     addFundUrl!.isEmpty;

    // if (canRedirect) {
    //   final isSuccess = forSubscription
    //       ? url.startsWith('${AppConstants.baseUrl}/subscription-success')
    //       : url.startsWith('${AppConstants.baseUrl}/payment-success');
    //   final isFailed = forSubscription
    //       ? url.startsWith('${AppConstants.baseUrl}/subscription-fail')
    //       : url.startsWith('${AppConstants.baseUrl}/payment-fail');
    //   final isCancel = forSubscription
    //       ? url.startsWith('${AppConstants.baseUrl}/subscription-cancel')
    //       : url.startsWith('${AppConstants.baseUrl}/payment-cancel');
    //   if (isSuccess || isFailed || isCancel) {
    //     canRedirect = false;
    //     onClose();
    //   }

    //   if (forOrder) {
    //     if (isSuccess) {
    //       Get.offNamed(
    //         RouteHelper.getOrderSuccessRoute(
    //           orderID,
    //           contactNumber,
    //           createAccount: createAccount,
    //           guestId: guestId,
    //         ),
    //       );
    //     } else if (isFailed || isCancel) {
    //       Get.offNamed(
    //         RouteHelper.getOrderSuccessRoute(
    //           orderID,
    //           contactNumber,
    //           createAccount: createAccount,
    //           guestId: guestId,
    //         ),
    //       );
    //     }
    //   } else {
    //     if (isSuccess || isFailed || isCancel) {
    //       if (Get.currentRoute.contains(RouteHelper.payment)) {
    //         Get.back();
    //       }
    //       if (forSubscription) {
    //         Get.find<HomeController>()
    //             .saveRegistrationSuccessfulSharedPref(true);
    //         Get.find<HomeController>().saveIsStoreRegistrationSharedPref(true);
    //         Get.offAllNamed(
    //           RouteHelper.getSubscriptionSuccessRoute(
    //             status: isSuccess
    //                 ? 'success'
    //                 : isFailed
    //                     ? 'fail'
    //                     : 'cancel',
    //             fromSubscription: true,
    //             storeId: storeId,
    //           ),
    //         );
    //       } else {
    //         Get.back();
    //         Get.toNamed(
    //           RouteHelper.getWalletRoute(
    //             fundStatus: isSuccess
    //                 ? 'success'
    //                 : isFailed
    //                     ? 'fail'
    //                     : 'cancel',
    //             token: UniqueKey().toString(),
    //           ),
    //         );
    //       }
    //     }
    //   }
    // }
  }
}
