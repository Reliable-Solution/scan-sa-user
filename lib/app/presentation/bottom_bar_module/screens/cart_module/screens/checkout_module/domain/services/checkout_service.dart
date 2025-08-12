import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/offline_method_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/place_order_body_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/models/timeslote_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/repositories/checkout_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/domain/services/checkout_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/helper/date_converter.dart';

class CheckoutService implements CheckoutServiceInterface {
  CheckoutService({required this.checkoutRepositoryInterface});
  final CheckoutRepositoryInterface checkoutRepositoryInterface;

  @override
  Future<List<OfflineMethodModel>?> getOfflineMethodList() async {
    return (await checkoutRepositoryInterface.getList())
        as List<OfflineMethodModel>?;
  }

  @override
  Future<int> getDmTipMostTapped() async {
    return checkoutRepositoryInterface.getDmTipMostTapped();
  }

  @override
  String getSharedPrefDmTipIndex() {
    return checkoutRepositoryInterface.getSharedPrefDmTipIndex();
  }

  @override
  Future<bool> saveSharedPrefDmTipIndex(String index) async {
    return checkoutRepositoryInterface.saveSharedPrefDmTipIndex(index);
  }

  @override
  Future<List<TimeSlotModel>?> initializeTimeSlot(
    Store store,
    int? scheduleOrderSlotDuration,
  ) async {
    final timeSlots = <TimeSlotModel>[];
    var minutes = 0;
    final now = DateTime.now();
    for (var index = 0; index < store.schedules!.length; index++) {
      final openTime = DateTime(
        now.year,
        now.month,
        now.day,
        DateConverter.convertStringTimeToDate(
          store.schedules![index].openingTime!,
        ).hour,
        DateConverter.convertStringTimeToDate(
          store.schedules![index].openingTime!,
        ).minute,
      );
      final closeTime = DateTime(
        now.year,
        now.month,
        now.day,
        DateConverter.convertStringTimeToDate(
          store.schedules![index].closingTime!,
        ).hour,
        DateConverter.convertStringTimeToDate(
          store.schedules![index].closingTime!,
        ).minute,
      );
      if (closeTime.difference(openTime).isNegative) {
        minutes = openTime.difference(closeTime).inMinutes;
      } else {
        minutes = closeTime.difference(openTime).inMinutes;
      }
      if (minutes > scheduleOrderSlotDuration!) {
        var time = openTime;
        for (;;) {
          if (time.isBefore(closeTime)) {
            final start = time;
            var end = start.add(Duration(minutes: scheduleOrderSlotDuration));
            if (end.isAfter(closeTime)) {
              end = closeTime;
            }
            timeSlots.add(
              TimeSlotModel(
                day: store.schedules![index].day,
                startTime: start,
                endTime: end,
              ),
            );
            time = time.add(Duration(minutes: scheduleOrderSlotDuration));
          } else {
            break;
          }
        }
      } else {
        timeSlots.add(
          TimeSlotModel(
            day: store.schedules![index].day,
            startTime: openTime,
            endTime: closeTime,
          ),
        );
      }
    }
    return timeSlots;
  }

  @override
  List<TimeSlotModel>? validateTimeSlot(
    List<TimeSlotModel> slots,
    int dateIndex,
    int? interval,
    bool? orderPlaceToScheduleInterval,
  ) {
    final timeSlots = <TimeSlotModel>[];

    var now = DateTime.now();
    if (orderPlaceToScheduleInterval!) {
      now = now.add(Duration(minutes: interval ?? 30));
    }
    var day = 0;
    if (dateIndex == 0) {
      day = DateTime.now().weekday;
    } else {
      day = DateTime.now().add(const Duration(days: 1)).weekday;
    }
    if (day == 7) {
      day = 0;
    }
    for (final slot in slots) {
      if (day == slot.day && (dateIndex == 0 || slot.endTime!.isAfter(now))) {
        timeSlots.add(slot);
      }
    }
    return timeSlots;
  }

  @override
  Future<Response<dynamic>> getDistanceInMeter(
    LatLng originLatLng,
    LatLng destinationLatLng,
  ) async {
    return checkoutRepositoryInterface.getDistanceInMeter(
      originLatLng,
      destinationLatLng,
    );
  }

  @override
  Future<num> getExtraCharge(num? distance) async {
    return checkoutRepositoryInterface.getExtraCharge(distance);
  }

  @override
  Future<Response<dynamic>> placeOrder(
    PlaceOrderBodyModel orderBody,
    List<MultipartBody> orderAttachment,
  ) async {
    return checkoutRepositoryInterface.placeOrder(orderBody, orderAttachment);
  }

  @override
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
  ) async {
    return checkoutRepositoryInterface.placePrescriptionOrder(
      storeId,
      distance,
      address,
      longitude,
      latitude,
      note,
      orderAttachment,
      dmTips,
      deliveryInstruction,
    );
  }
}
