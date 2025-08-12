import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/offline_method_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/place_order_body_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/timeslote_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';

abstract class CheckoutServiceInterface {
  Future<List<OfflineMethodModel>?> getOfflineMethodList();
  Future<int> getDmTipMostTapped();
  String getSharedPrefDmTipIndex();
  Future<bool> saveSharedPrefDmTipIndex(String index);
  Future<List<TimeSlotModel>?> initializeTimeSlot(
    Store store,
    int? scheduleOrderSlotDuration,
  );
  List<TimeSlotModel>? validateTimeSlot(
    List<TimeSlotModel> slots,
    int dateIndex,
    int? interval,
    bool? orderPlaceToScheduleInterval,
  );
  Future<Response<dynamic>> getDistanceInMeter(
    LatLng originLatLng,
    LatLng destinationLatLng,
  );
  Future<num> getExtraCharge(num? distance);
  Future<Response<dynamic>> placeOrder(
    PlaceOrderBodyModel orderBody,
    List<MultipartBody> orderAttachment,
  );
  Future<Response<dynamic>> placePrescriptionOrder(
    int? storeId,
    num? distance,
    String address,
    String longitude,
    String latitude,
    String note,
    List<MultipartBody> orderAttachment,
    String dmTips,
    String deliveryInstruction,
  );
}
