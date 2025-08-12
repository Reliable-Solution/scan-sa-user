import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class OrderRepositoryInterface extends RepositoryInterface<dynamic> {
  @override
  Future<dynamic> get(String? id, {String? guestId});
  @override
  Future<dynamic> getList({
    int? offset,
    bool isRunningOrder = false,
    bool isHistoryOrder = false,
    bool isCancelReasons = false,
    bool isRefundReasons = false,
    bool fromDashboard,
    bool isSupportReasons = false,
  });
  Future<Response<dynamic>> submitRefundRequest(
    Map<String, String> body,
    XFile? data,
  );
  Future<Response<dynamic>> trackOrder(
    String? orderID,
    String? guestId, {
    String? contactNumber,
  });
  Future<bool> cancelOrder(String orderID, String? reason, {String? guestId});
  Future<Response<dynamic>> switchToCOD(String? orderID, {String? guestId});
}
