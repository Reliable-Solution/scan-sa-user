import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/order_module/domain/models/parcel_category_model.dart';
import 'package:scan_sa_user/common/models/address_model.dart';

class PaginatedOrderModel {
  PaginatedOrderModel({this.totalSize, this.limit, this.offset, this.orders});

  PaginatedOrderModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'] as int?;
    limit = json['limit'].toString();
    offset =
        (json['offset'] != null && json['offset'].toString().trim().isNotEmpty)
        ? int.parse(json['offset'].toString())
        : null;
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders!.add(OrderModel.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? totalSize;
  String? limit;
  int? offset;
  List<OrderModel>? orders;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderModel {
  OrderModel({
    this.id,
    this.userId,
    this.orderAmount,
    this.couponDiscountAmount,
    this.couponDiscountTitle,
    this.paymentStatus,
    this.orderStatus,
    this.totalTaxAmount,
    this.paymentMethod,
    this.couponCode,
    this.orderNote,
    this.orderType,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.scheduleAt,
    this.otp,
    this.pending,
    this.accepted,
    this.confirmed,
    this.processing,
    this.handover,
    this.pickedUp,
    this.delivered,
    this.canceled,
    this.refundRequested,
    this.refunded,
    this.scheduled,
    this.storeDiscountAmount,
    this.failed,
    this.detailsCount,
    this.chargePayer,
    this.moduleType,
    this.deliveryMan,
    this.deliveryAddress,
    this.receiverDetails,
    this.parcelCategory,
    this.store,
    this.orderAttachmentFullUrl,
    this.dmTips,
    this.refundCancellationNote,
    this.refundCustomerNote,
    this.refund,
    this.prescriptionOrder,
    this.taxStatus,
    this.cancellationReason,
    this.processingTime,
    this.cutlery,
    this.unavailableItemNote,
    this.deliveryInstruction,
    this.taxPercentage,
    this.additionalCharge,
    this.partiallyPaidAmount,
    this.payments,
    this.orderProofFullUrl,
    this.offlinePayment,
    this.flashAdminDiscountAmount,
    this.flashStoreDiscountAmount,
    this.extraPackagingAmount,
    this.referrerBonusAmount,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    userId = json['user_id'] as int?;
    orderAmount = json['order_amount'] as num?;
    couponDiscountAmount = json['coupon_discount_amount'] as num?;
    couponDiscountTitle = json['coupon_discount_title'] as String?;
    paymentStatus = json['payment_status'] as String?;
    orderStatus = json['order_status'] as String?;
    totalTaxAmount = json['total_tax_amount'] as num?;
    paymentMethod = json['payment_method'] as String?;
    couponCode = json['coupon_code'] as String?;
    orderNote = json['order_note'] as String?;
    orderType = json['order_type'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    deliveryCharge = json['delivery_charge'] as num?;
    scheduleAt = json['schedule_at'] as String?;
    otp = json['otp'] as String?;
    pending = json['pending'] as String?;
    accepted = json['accepted'] as String?;
    confirmed = json['confirmed'] as String?;
    processing = json['processing'] as String?;
    handover = json['handover'] as String?;
    pickedUp = json['picked_up'] as String?;
    delivered = json['delivered'] as String?;
    canceled = json['canceled'] as String?;
    refundRequested = json['refund_requested'] as String?;
    refunded = json['refunded'] as String?;
    scheduled = json['scheduled'] as int?;
    storeDiscountAmount = json['store_discount_amount'] as num?;
    failed = json['failed'] as String?;
    detailsCount = json['details_count'] as int?;
    if (json['order_attachment_full_url'] != null) {
      orderAttachmentFullUrl = [];
      json['order_attachment_full_url'].forEach((v) {
        orderAttachmentFullUrl!.add(v as String);
      });
    }
    chargePayer = json['charge_payer'] as String?;
    moduleType = json['module_type'] as String?;
    deliveryMan = json['delivery_man'] != null
        ? DeliveryMan.fromJson(json['delivery_man'] as Map<String, dynamic>)
        : null;
    store = json['store'] != null
        ? Store.fromJson(json['store'] as Map<String, dynamic>)
        : null;
    deliveryAddress = json['delivery_address'] != null
        ? AddressModel.fromJson(
            json['delivery_address'] as Map<String, dynamic>,
          )
        : null;
    receiverDetails = json['receiver_details'] != null
        ? AddressModel.fromJson(
            json['receiver_details'] as Map<String, dynamic>,
          )
        : null;
    parcelCategory = json['parcel_category'] != null
        ? ParcelCategoryModel.fromJson(
            json['parcel_category'] as Map<String, dynamic>,
          )
        : null;
    dmTips = json['dm_tips'] as num?;
    refundCancellationNote = json['refund_cancellation_note'] as String?;
    refundCustomerNote = json['refund_customer_note'] as String?;
    refund = json['refund'] != null
        ? Refund.fromJson(json['refund'] as Map<String, dynamic>)
        : null;
    prescriptionOrder = json['prescription_order'] as bool?;
    taxStatus = json['tax_status'] == 'included';
    cancellationReason = json['cancellation_reason'] as String?;
    processingTime = json['processing_time'] as int?;
    cutlery = json['cutlery'] as bool?;
    unavailableItemNote = json['unavailable_item_note'] as String?;
    deliveryInstruction = json['delivery_instruction'] as String?;
    taxPercentage = json['tax_percentage'] as num?;
    additionalCharge = json['additional_charge'] as num?;
    if (json['partially_paid_amount'] != null) {
      partiallyPaidAmount = num.parse(json['partially_paid_amount'].toString());
    }
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(Payments.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['order_proof_full_url'] != null) {
      orderProofFullUrl = [];
      json['order_proof_full_url'].forEach((v) {
        if (v != null) {
          orderProofFullUrl!.add(v.toString());
        }
      });
    }
    offlinePayment = json['offline_payment'] != null
        ? OfflinePayment.fromJson(
            json['offline_payment'] as Map<String, dynamic>,
          )
        : null;
    flashAdminDiscountAmount = json['flash_admin_discount_amount'] as num?;
    flashStoreDiscountAmount = json['flash_store_discount_amount'] as num?;
    extraPackagingAmount = json['extra_packaging_amount'] as num?;
    referrerBonusAmount = json['ref_bonus_amount'] as num?;
  }
  int? id;
  int? userId;
  num? orderAmount;
  num? couponDiscountAmount;
  String? couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  num? totalTaxAmount;
  String? paymentMethod;
  String? couponCode;
  String? orderNote;
  String? orderType;
  String? createdAt;
  String? updatedAt;
  num? deliveryCharge;
  String? scheduleAt;
  String? otp;
  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  int? scheduled;
  num? storeDiscountAmount;
  String? failed;
  int? detailsCount;
  List<String?>? orderAttachmentFullUrl;
  String? chargePayer;
  String? moduleType;
  DeliveryMan? deliveryMan;
  Store? store;
  AddressModel? deliveryAddress;
  AddressModel? receiverDetails;
  ParcelCategoryModel? parcelCategory;
  num? dmTips;
  String? refundCancellationNote;
  String? refundCustomerNote;
  Refund? refund;
  bool? prescriptionOrder;
  bool? taxStatus;
  String? cancellationReason;
  int? processingTime;
  bool? cutlery;
  String? unavailableItemNote;
  String? deliveryInstruction;
  num? taxPercentage;
  num? additionalCharge;
  num? partiallyPaidAmount;
  List<Payments>? payments;
  List<String>? orderProofFullUrl;
  OfflinePayment? offlinePayment;
  num? flashAdminDiscountAmount;
  num? flashStoreDiscountAmount;
  num? extraPackagingAmount;
  num? referrerBonusAmount;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_amount'] = orderAmount;
    data['coupon_discount_amount'] = couponDiscountAmount;
    data['coupon_discount_title'] = couponDiscountTitle;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    data['total_tax_amount'] = totalTaxAmount;
    data['payment_method'] = paymentMethod;
    data['coupon_code'] = couponCode;
    data['order_note'] = orderNote;
    data['order_type'] = orderType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['delivery_charge'] = deliveryCharge;
    data['schedule_at'] = scheduleAt;
    data['otp'] = otp;
    data['pending'] = pending;
    data['accepted'] = accepted;
    data['confirmed'] = confirmed;
    data['processing'] = processing;
    data['handover'] = handover;
    data['picked_up'] = pickedUp;
    data['delivered'] = delivered;
    data['canceled'] = canceled;
    data['refund_requested'] = refundRequested;
    data['refunded'] = refunded;
    data['scheduled'] = scheduled;
    data['store_discount_amount'] = storeDiscountAmount;
    data['failed'] = failed;
    data['order_attachment_full_url'] = orderAttachmentFullUrl;
    data['charge_payer'] = chargePayer;
    data['module_type'] = moduleType;
    data['details_count'] = detailsCount;
    if (deliveryMan != null) {
      data['delivery_man'] = deliveryMan!.toJson();
    }
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (deliveryAddress != null) {
      data['delivery_address'] = deliveryAddress!.toJson();
    }
    if (receiverDetails != null) {
      data['receiver_details'] = receiverDetails!.toJson();
    }
    if (parcelCategory != null) {
      data['parcel_category'] = parcelCategory!.toJson();
    }
    data['dm_tips'] = dmTips;
    data['refund_cancellation_note'] = refundCancellationNote;
    data['refund_customer_note'] = refundCustomerNote;
    if (deliveryAddress != null) {
      data['refund'] = refund!.toJson();
    }
    data['prescription_order'] = prescriptionOrder;
    data['processing_time'] = processingTime;
    data['cutlery'] = cutlery;
    data['unavailable_item_note'] = unavailableItemNote;
    data['delivery_instruction'] = deliveryInstruction;
    data['additional_charge'] = additionalCharge;
    data['partially_paid_amount'] = partiallyPaidAmount;
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    data['order_proof_full_url'] = orderProofFullUrl;
    if (offlinePayment != null) {
      data['offline_payment'] = offlinePayment!.toJson();
    }
    data['offline_payment'] = offlinePayment;
    data['flash_admin_discount_amount'] = flashAdminDiscountAmount;
    data['flash_store_discount_amount'] = flashStoreDiscountAmount;
    data['extra_packaging_amount'] = extraPackagingAmount;
    data['ref_bonus_amount'] = referrerBonusAmount;
    return data;
  }
}

class DeliveryMan {
  DeliveryMan({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.imageFullUrl,
    this.zoneId,
    this.active,
    this.available,
    this.avgRating,
    this.ratingCount,
    this.lat,
    this.lng,
    this.location,
  });

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    fName = json['f_name'] as String?;
    lName = json['l_name'] as String?;
    phone = json['phone'] as String?;
    email = json['email'] as String?;
    imageFullUrl = json['image_full_url'] as String?;
    zoneId = json['zone_id'] as int?;
    active = json['active'] as int?;
    available = json['available'] as int?;
    avgRating = json['avg_rating'] as num?;
    ratingCount = json['rating_count'] as int?;
    lat = json['lat'] as String?;
    lng = json['lng'] as String?;
    location = json['location'] as String?;
  }
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? imageFullUrl;
  int? zoneId;
  int? active;
  int? available;
  num? avgRating;
  int? ratingCount;
  String? lat;
  String? lng;
  String? location;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['image_full_url'] = imageFullUrl;
    data['zone_id'] = zoneId;
    data['active'] = active;
    data['available'] = available;
    data['avg_rating'] = avgRating;
    data['rating_count'] = ratingCount;
    data['lat'] = lat;
    data['lng'] = lng;
    data['location'] = location;
    return data;
  }
}

class Payments {
  Payments({
    this.id,
    this.orderId,
    this.amount,
    this.paymentStatus,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
  });

  Payments.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    orderId = json['order_id'] as int?;
    amount = json['amount'] as num?;
    paymentStatus = json['payment_status'] as String?;
    paymentMethod = json['payment_method'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }
  int? id;
  int? orderId;
  num? amount;
  String? paymentStatus;
  String? paymentMethod;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['amount'] = amount;
    data['payment_status'] = paymentStatus;
    data['payment_method'] = paymentMethod;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class OfflinePayment {
  OfflinePayment({this.input, this.data, this.methodFields});

  OfflinePayment.fromJson(Map<String, dynamic> json) {
    if (json['input'] != null) {
      input = <Input>[];
      json['input'].forEach((v) {
        input!.add(Input.fromJson(v as Map<String, dynamic>));
      });
    }
    data = json['data'] != null
        ? Data.fromJson(json['data'] as Map<String, dynamic>)
        : null;
    if (json['method_fields'] != null) {
      methodFields = <MethodFields>[];
      json['method_fields'].forEach((v) {
        methodFields!.add(MethodFields.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<Input>? input;
  Data? data;
  List<MethodFields>? methodFields;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (input != null) {
      data['input'] = input!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (methodFields != null) {
      data['method_fields'] = input!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Input {
  Input({this.userInput, this.userData});

  Input.fromJson(Map<String, dynamic> json) {
    userInput = json['user_input'] as String?;
    userData = json['user_data'] as String?;
  }
  String? userInput;
  String? userData;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_input'] = userInput;
    data['user_data'] = userData;
    return data;
  }
}

class Data {
  Data({this.status, this.methodId, this.methodName, this.customerNote});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    methodId = json['method_id'] as String?;
    methodName = json['method_name'] as String?;
    customerNote = json['customer_note'] as String?;
  }
  String? status;
  String? methodId;
  String? methodName;
  String? customerNote;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['method_id'] = methodId;
    data['method_name'] = methodName;
    data['customer_note'] = customerNote;
    return data;
  }
}

class MethodFields {
  MethodFields({this.inputName, this.inputData});

  MethodFields.fromJson(Map<String, dynamic> json) {
    inputName = json['input_name'] as String?;
    inputData = json['input_data'] as String?;
  }
  String? inputName;
  String? inputData;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['input_name'] = inputName;
    data['input_data'] = inputData;
    return data;
  }
}
