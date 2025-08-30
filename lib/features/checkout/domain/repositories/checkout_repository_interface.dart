import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/features/checkout/domain/models/place_order_body_model.dart';
import 'package:scan_sa_user/interfaces/repository_interface.dart';

abstract class CheckoutRepositoryInterface extends RepositoryInterface {
  Future<int> getDmTipMostTapped();
  String getSharedPrefDmTipIndex();
  Future<bool> saveSharedPrefDmTipIndex(String index);
  Future<Response> getDistanceInMeter(
    LatLng originLatLng,
    LatLng destinationLatLng,
  );
  Future<num> getExtraCharge(num? distance);
  Future<Response> placeOrder(
    PlaceOrderBodyModel orderBody,
    List<MultipartBody>? orderAttachment,
  );
  Future<Response> placePrescriptionOrder(
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
