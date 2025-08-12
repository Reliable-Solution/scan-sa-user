import 'package:get/get_connect/connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/order_cancellation_body.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/order_details_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/order_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/refund_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/support_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/repositories/order_repository_interface.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class OrderRepository implements OrderRepositoryInterface {
  OrderRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<Response<dynamic>> submitRefundRequest(
    Map<String, String> body,
    XFile? data,
  ) async {
    return apiClient.postMultipartData(AppConstants.refundRequestUri, body, [
      MultipartBody('image[]', data),
    ]);
  }

  @override
  Future<Response<dynamic>> trackOrder(
    String? orderID,
    String? guestId, {
    String? contactNumber,
  }) async {
    return apiClient.getData(
      '${AppConstants.trackUri}$orderID${guestId != null ? '&guest_id=$guestId' : ''}'
      '${contactNumber != null ? '&contact_number=$contactNumber' : ''}',
    );
  }

  @override
  Future<Response<dynamic>> switchToCOD(
    String? orderID, {
    String? guestId,
  }) async {
    final data = <String, String>{'_method': 'put', 'order_id': orderID!};
    if (GlobalHelper.isGuestLoggedIn() || guestId != null) {
      data.addAll({'guest_id': guestId ?? GlobalHelper.getGuestId()});
    }
    return apiClient.postData(AppConstants.codSwitchUri, data);
  }

  @override
  Future<dynamic> add(dynamic value) {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> cancelOrder(
    String orderID,
    String? reason, {
    String? guestId,
  }) async {
    var success = false;
    final data = <String, String>{
      '_method': 'put',
      'order_id': orderID,
      'reason': reason!,
    };
    if (GlobalHelper.isGuestLoggedIn() || guestId != null) {
      data.addAll({'guest_id': guestId ?? GlobalHelper.getGuestId()});
    }
    final response = await apiClient.postData(
      AppConstants.orderCancelUri,
      data,
    );
    if (response.statusCode == 200) {
      success = true;
      showCustomSnackBar(response.body['message'] as String, isError: false);
    }
    return success;
  }

  @override
  Future<dynamic> get(String? id, {String? guestId}) async {
    return _getOrderDetails(id!, guestId);
  }

  Future<List<OrderDetailsModel>?> _getOrderDetails(
    String orderID,
    String? guestId,
  ) async {
    List<OrderDetailsModel>? orderDetails;
    final response = await apiClient.getData(
      '${AppConstants.orderDetailsUri}$orderID${guestId != null ? '&guest_id=$guestId' : ''}',
    );
    if (response.statusCode == 200) {
      orderDetails = [];
      response.body.forEach(
        (orderDetail) => orderDetails!.add(
          OrderDetailsModel.fromJson(orderDetail as Map<String, dynamic>),
        ),
      );
    }
    return orderDetails;
  }

  @override
  Future<dynamic> getList({
    int? offset,
    bool isRunningOrder = false,
    bool isHistoryOrder = false,
    bool isCancelReasons = false,
    bool isRefundReasons = false,
    bool fromDashboard = false,
    bool isSupportReasons = false,
  }) async {
    if (isRunningOrder) {
      return _getRunningOrderList(offset!, fromDashboard);
    } else if (isHistoryOrder) {
      return _getHistoryOrderList(offset!);
    } else if (isCancelReasons) {
      return _getCancelReasons();
    } else if (isRefundReasons) {
      return _getRefundReasons();
    } else if (isSupportReasons) {
      return _getSupportReasons();
    }
  }

  Future<PaginatedOrderModel?> _getRunningOrderList(
    int offset,
    bool fromDashboard,
  ) async {
    PaginatedOrderModel? runningOrderModel;
    final response = await apiClient.getData(
      '${AppConstants.runningOrderListUri}?offset=$offset&limit=${fromDashboard ? 50 : 10}',
    );
    if (response.statusCode == 200) {
      runningOrderModel = PaginatedOrderModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return runningOrderModel;
  }

  Future<PaginatedOrderModel?> _getHistoryOrderList(int offset) async {
    PaginatedOrderModel? historyOrderModel;
    final response = await apiClient.getData(
      '${AppConstants.historyOrderListUri}?offset=$offset&limit=10',
    );
    if (response.statusCode == 200) {
      historyOrderModel = PaginatedOrderModel.fromJson(
        response.body as Map<String, dynamic>,
      );
    }
    return historyOrderModel;
  }

  Future<List<CancellationData>?> _getCancelReasons() async {
    List<CancellationData>? orderCancelReasons;
    final response = await apiClient.getData(
      '${AppConstants.orderCancellationUri}?offset=1&limit=30&type=customer',
    );
    if (response.statusCode == 200) {
      final orderCancellationBody = OrderCancellationBody.fromJson(
        response.body as Map<String, dynamic>,
      );
      orderCancelReasons = [];
      for (final element in orderCancellationBody.reasons!) {
        orderCancelReasons.add(element);
      }
    }
    return orderCancelReasons;
  }

  Future<List<String?>?> _getRefundReasons() async {
    List<String?>? refundReasons;
    final response = await apiClient.getData(AppConstants.refundReasonUri);
    if (response.statusCode == 200) {
      final refundModel = RefundModel.fromJson(
        response.body as Map<String, dynamic>,
      );
      refundReasons = [];
      refundReasons.insert(0, 'select_an_option');
      for (final element in refundModel.refundReasons!) {
        refundReasons.add(element.reason);
      }
    }
    return refundReasons;
  }

  Future<List<String?>?> _getSupportReasons() async {
    List<String?>? supportReasons;
    final response = await apiClient.getData(AppConstants.supportReasonUri);
    if (response.statusCode == 200) {
      final supportModel = SupportModel.fromJson(
        response.body as Map<String, dynamic>,
      );
      supportReasons = [];
      for (final element in supportModel.data!) {
        supportReasons.add(element.message);
      }
    }
    return supportReasons;
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
