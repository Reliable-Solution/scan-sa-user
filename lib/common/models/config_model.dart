import 'package:scan_sa_user/common/models/module_model.dart';

class ConfigModel {
  ConfigModel({
    this.businessName,
    this.logoFullUrl,
    this.address,
    this.phone,
    this.email,
    this.country,
    this.defaultLocation,
    this.currencySymbol,
    this.currencySymbolDirection,
    this.appMinimumVersionAndroid,
    this.appUrlAndroid,
    this.appMinimumVersionIos,
    this.appUrlIos,
    this.customerVerification,
    this.scheduleOrder,
    this.orderDeliveryVerification,
    this.cashOnDelivery,
    this.digitalPayment,
    this.perKmShippingCharge,
    this.minimumShippingCharge,
    this.demo,
    this.maintenanceMode,
    this.orderConfirmationModel,
    this.showDmEarning,
    this.canceledByDeliveryman,
    this.timeformat,
    this.language,
    this.toggleVegNonVeg,
    this.toggleDmRegistration,
    this.toggleStoreRegistration,
    this.scheduleOrderSlotDuration,
    this.digitAfterDecimalPoint,
    this.module,
    this.moduleConfig,
    this.parcelPerKmShippingCharge,
    this.parcelMinimumShippingCharge,
    this.landingPageSettings,
    this.socialMedia,
    this.footerText,
    this.landingPageLinks,
    this.loyaltyPointExchangeRate,
    this.loyaltyPointItemPurchasePoint,
    this.loyaltyPointStatus,
    this.minimumPointToTransfer,
    this.customerWalletStatus,
    this.dmTipsStatus,
    this.refEarningStatus,
    this.refEarningExchangeRate,
    this.socialLogin,
    this.appleLogin,
    this.refundActiveStatus,
    this.refundPolicyStatus,
    this.cancellationPolicyStatus,
    this.shippingPolicyStatus,
    this.prescriptionStatus,
    this.taxIncluded,
    this.cookiesText,
    this.homeDeliveryStatus,
    this.takeawayStatus,
    this.partialPaymentStatus,
    this.partialPaymentMethod,
    this.additionalChargeStatus,
    this.additionalChargeName,
    this.additionCharge,
    this.activePaymentMethodList,
    this.digitalPaymentInfo,
    this.addFundStatus,
    this.offlinePaymentStatus,
    this.guestCheckoutStatus,
    this.subscriptionFreeTrialDays,
    this.subscriptionFreeTrialStatus,
    this.subscriptionBusinessModel,
    this.commissionBusinessModel,
    this.subscriptionFreeTrialType,
    this.countryPickerStatus,
    this.firebaseOtpVerification,
    this.centralizeLoginSetup,
    this.vehicleDistanceMinPrice,
    this.vehicleHourlyMinPrice,
    this.adminFreeDelivery,
    this.isSmsActive,
    this.isMailActive,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'] as String?;
    logoFullUrl = json['logo_full_url'] as String?;
    address = json['address'] as String?;
    phone = json['phone'] as String?;
    email = json['email'] as String?;
    country = json['country'] as String?;
    defaultLocation = json['default_location'] != null
        ? DefaultLocation.fromJson(
            json['default_location'] as Map<String, dynamic>,
          )
        : null;
    currencySymbol = json['currency_symbol'] as String?;
    currencySymbolDirection = json['currency_symbol_direction'] as String?;
    appMinimumVersionAndroid = json['app_minimum_version_android'] as num?;
    appUrlAndroid = json['app_url_android'] as String?;
    appMinimumVersionIos = json['app_minimum_version_ios'] as num?;
    appUrlIos = json['app_url_ios'] as String?;
    customerVerification = json['customer_verification'] as bool?;
    scheduleOrder = json['schedule_order'] as bool?;
    orderDeliveryVerification = json['order_delivery_verification'] as bool?;
    cashOnDelivery = json['cash_on_delivery'] as bool?;
    digitalPayment = json['digital_payment'] as bool?;
    perKmShippingCharge = json['per_km_shipping_charge'] as num?;
    minimumShippingCharge = json['minimum_shipping_charge'] as num?;
    demo = json['demo'] as bool?;
    maintenanceMode = json['maintenance_mode'] as bool?;
    orderConfirmationModel = json['order_confirmation_model'] as String?;
    showDmEarning = json['show_dm_earning'] as bool?;
    canceledByDeliveryman = json['canceled_by_deliveryman'] as bool?;
    timeformat = json['timeformat'] as String?;
    if (json['language'] != null) {
      language = <Language>[];
      json['language'].forEach((v) {
        language!.add(Language.fromJson(v as Map<String, dynamic>));
      });
    }
    toggleVegNonVeg = json['toggle_veg_non_veg'] as bool?;
    toggleDmRegistration = json['toggle_dm_registration'] as bool?;
    toggleStoreRegistration = json['toggle_store_registration'] as bool?;
    scheduleOrderSlotDuration = json['schedule_order_slot_duration'] == 0
        ? 30
        : json['schedule_order_slot_duration'] as int?;
    digitAfterDecimalPoint = json['digit_after_decimal_point'] as int?;
    module = json['module'] != null
        ? ModuleModel.fromJson(json['module'] as Map<String, dynamic>)
        : null;
    moduleConfig = json['module_config'] != null
        ? ModuleConfig.fromJson(json['module_config'] as Map<String, dynamic>)
        : null;
    parcelPerKmShippingCharge = json['parcel_per_km_shipping_charge'] as num?;
    parcelMinimumShippingCharge =
        json['parcel_minimum_shipping_charge'] as num?;
    landingPageSettings = json['landing_page_settings'] != null
        ? LandingPageSettings.fromJson(
            json['landing_page_settings'] as Map<String, dynamic>,
          )
        : null;
    if (json['social_media'] != null) {
      socialMedia = <SocialMedia>[];
      json['social_media'].forEach((v) {
        socialMedia!.add(SocialMedia.fromJson(v as Map<String, dynamic>));
      });
    }
    footerText = json['footer_text'] as String?;
    landingPageLinks = json['landing_page_links'] != null
        ? LandingPageLinks.fromJson(
            json['landing_page_links'] as Map<String, dynamic>,
          )
        : null;
    loyaltyPointExchangeRate = json['loyalty_point_exchange_rate'] as int?;
    loyaltyPointItemPurchasePoint =
        json['loyalty_point_item_purchase_point'] as num?;
    loyaltyPointStatus = json['loyalty_point_status'] as int?;
    minimumPointToTransfer = json['loyalty_point_minimum_point'] as int?;
    customerWalletStatus = json['customer_wallet_status'] as int?;
    dmTipsStatus = json['dm_tips_status'] as int?;
    refEarningStatus = json['ref_earning_status'] as int?;
    refundActiveStatus = json['refund_active_status'] as bool?;
    refEarningExchangeRate = json['ref_earning_exchange_rate'] as num?;
    if (json['social_login'] != null) {
      socialLogin = <SocialLogin>[];
      json['social_login'].forEach((v) {
        socialLogin!.add(SocialLogin.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['apple_login'] != null) {
      appleLogin = <SocialLogin>[];
      json['apple_login'].forEach((v) {
        appleLogin!.add(SocialLogin.fromJson(v as Map<String, dynamic>));
      });
    }
    refundPolicyStatus = json['refund_policy'] as int?;
    cancellationPolicyStatus = json['cancelation_policy'] as int?;
    shippingPolicyStatus = json['shipping_policy'] as int?;
    prescriptionStatus = json['prescription_order_status'] as bool?;
    taxIncluded = json['tax_included'] as int?;
    cookiesText = json['cookies_text'] as String?;
    homeDeliveryStatus = json['home_delivery_status'] as int?;
    takeawayStatus = json['takeaway_status'] as int?;
    partialPaymentStatus = json['partial_payment_status'] == 1;
    partialPaymentMethod = json['partial_payment_method'] as String?;
    additionalChargeStatus = json['additional_charge_status'] == 1;
    additionalChargeName = json['additional_charge_name'] as String?;
    additionCharge = json['additional_charge'] as num?;
    if (json['active_payment_method_list'] != null) {
      activePaymentMethodList = <PaymentBody>[];
      json['active_payment_method_list'].forEach((v) {
        activePaymentMethodList!.add(
          PaymentBody.fromJson(v as Map<String, dynamic>),
        );
      });
    }
    digitalPaymentInfo = json['digital_payment_info'] != null
        ? DigitalPaymentInfo.fromJson(
            json['digital_payment_info'] as Map<String, dynamic>,
          )
        : null;
    addFundStatus = json['add_fund_status'] == 1;
    offlinePaymentStatus = json['offline_payment_status'] == 1;
    guestCheckoutStatus = json['guest_checkout_status'] == 1;
    adminCommission = json['admin_commission'] as num?;
    subscriptionFreeTrialDays = json['subscription_free_trial_days'] as int?;
    subscriptionFreeTrialStatus = json['subscription_free_trial_status'] == 1;
    subscriptionBusinessModel = json['subscription_business_model'] as int?;
    commissionBusinessModel = json['commission_business_model'] as int?;
    subscriptionFreeTrialType = json['subscription_free_trial_type'] as String?;
    countryPickerStatus = json['country_picker_status'] == 1;
    firebaseOtpVerification = json['firebase_otp_verification'] == 1;
    centralizeLoginSetup = json['centralize_login'] != null
        ? CentralizeLoginSetup.fromJson(
            json['centralize_login'] as Map<String, dynamic>,
          )
        : null;
    vehicleDistanceMinPrice = json['vehicle_distance_min'] as num?;
    vehicleHourlyMinPrice = json['vehicle_hourly_min'] as num?;
    adminFreeDelivery = json['admin_free_delivery'] != null
        ? AdminFreeDelivery.fromJson(
            json['admin_free_delivery'] as Map<String, dynamic>,
          )
        : null;
    isSmsActive = json['is_sms_active'] as bool?;
    isMailActive = json['is_mail_active'] as bool?;
  }
  String? businessName;
  String? logoFullUrl;
  String? address;
  String? phone;
  String? email;
  String? country;
  DefaultLocation? defaultLocation;
  String? currencySymbol;
  String? currencySymbolDirection;
  num? appMinimumVersionAndroid;
  String? appUrlAndroid;
  num? appMinimumVersionIos;
  String? appUrlIos;
  bool? customerVerification;
  bool? scheduleOrder;
  bool? orderDeliveryVerification;
  bool? cashOnDelivery;
  bool? digitalPayment;
  num? perKmShippingCharge;
  num? minimumShippingCharge;
  bool? demo;
  bool? maintenanceMode;
  String? orderConfirmationModel;
  bool? showDmEarning;
  bool? canceledByDeliveryman;
  String? timeformat;
  List<Language>? language;
  bool? toggleVegNonVeg;
  bool? toggleDmRegistration;
  bool? toggleStoreRegistration;
  int? scheduleOrderSlotDuration;
  int? digitAfterDecimalPoint;
  num? parcelPerKmShippingCharge;
  num? parcelMinimumShippingCharge;
  ModuleModel? module;
  ModuleConfig? moduleConfig;
  LandingPageSettings? landingPageSettings;
  List<SocialMedia>? socialMedia;
  String? footerText;
  LandingPageLinks? landingPageLinks;
  int? loyaltyPointExchangeRate;
  num? loyaltyPointItemPurchasePoint;
  int? loyaltyPointStatus;
  int? minimumPointToTransfer;
  int? customerWalletStatus;
  int? dmTipsStatus;
  int? refEarningStatus;
  num? refEarningExchangeRate;
  List<SocialLogin>? socialLogin;
  List<SocialLogin>? appleLogin;
  bool? refundActiveStatus;
  int? refundPolicyStatus;
  int? cancellationPolicyStatus;
  int? shippingPolicyStatus;
  bool? prescriptionStatus;
  int? taxIncluded;
  String? cookiesText;
  int? homeDeliveryStatus;
  int? takeawayStatus;
  bool? partialPaymentStatus;
  String? partialPaymentMethod;
  bool? additionalChargeStatus;
  String? additionalChargeName;
  num? additionCharge;
  List<PaymentBody>? activePaymentMethodList;
  DigitalPaymentInfo? digitalPaymentInfo;
  bool? addFundStatus;
  bool? offlinePaymentStatus;
  bool? guestCheckoutStatus;
  num? adminCommission;
  int? subscriptionFreeTrialDays;
  bool? subscriptionFreeTrialStatus;
  int? subscriptionBusinessModel;
  int? commissionBusinessModel;
  String? subscriptionFreeTrialType;
  bool? countryPickerStatus;
  bool? firebaseOtpVerification;
  CentralizeLoginSetup? centralizeLoginSetup;
  num? vehicleDistanceMinPrice;
  num? vehicleHourlyMinPrice;
  AdminFreeDelivery? adminFreeDelivery;
  bool? isSmsActive;
  bool? isMailActive;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['business_name'] = businessName;
    data['logo_full_url'] = logoFullUrl;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['country'] = country;
    if (defaultLocation != null) {
      data['default_location'] = defaultLocation!.toJson();
    }
    data['currency_symbol'] = currencySymbol;
    data['currency_symbol_direction'] = currencySymbolDirection;
    data['app_minimum_version_android'] = appMinimumVersionAndroid;
    data['app_url_android'] = appUrlAndroid;
    data['app_minimum_version_ios'] = appMinimumVersionIos;
    data['app_url_ios'] = appUrlIos;
    data['customer_verification'] = customerVerification;
    data['schedule_order'] = scheduleOrder;
    data['order_delivery_verification'] = orderDeliveryVerification;
    data['cash_on_delivery'] = cashOnDelivery;
    data['digital_payment'] = digitalPayment;
    data['per_km_shipping_charge'] = perKmShippingCharge;
    data['minimum_shipping_charge'] = minimumShippingCharge;
    data['demo'] = demo;
    data['maintenance_mode'] = maintenanceMode;
    data['order_confirmation_model'] = orderConfirmationModel;
    data['show_dm_earning'] = showDmEarning;
    data['canceled_by_deliveryman'] = canceledByDeliveryman;
    data['timeformat'] = timeformat;
    if (language != null) {
      data['language'] = language!.map((v) => v.toJson()).toList();
    }
    data['toggle_veg_non_veg'] = toggleVegNonVeg;
    data['toggle_dm_registration'] = toggleDmRegistration;
    data['toggle_store_registration'] = toggleStoreRegistration;
    data['schedule_order_slot_duration'] = scheduleOrderSlotDuration;
    data['digit_after_decimal_point'] = digitAfterDecimalPoint;
    if (module != null) {
      data['module'] = module!.toJson();
    }
    if (moduleConfig != null) {
      data['module_config'] = moduleConfig!.toJson();
    }
    data['parcel_per_km_shipping_charge'] = parcelPerKmShippingCharge;
    data['parcel_minimum_shipping_charge'] = parcelMinimumShippingCharge;
    if (landingPageSettings != null) {
      data['landing_page_settings'] = landingPageSettings!.toJson();
    }
    if (socialMedia != null) {
      data['social_media'] = socialMedia!.map((v) => v.toJson()).toList();
    }
    data['footer_text'] = footerText;
    if (landingPageLinks != null) {
      data['landing_page_links'] = landingPageLinks!.toJson();
    }
    data['loyalty_point_exchange_rate'] = loyaltyPointExchangeRate;
    data['loyalty_point_item_purchase_point'] = loyaltyPointItemPurchasePoint;
    data['loyalty_point_status'] = loyaltyPointStatus;
    data['loyalty_point_minimum_point'] = minimumPointToTransfer;
    data['customer_wallet_status'] = customerWalletStatus;
    data['dm_tips_status'] = dmTipsStatus;
    data['ref_earning_status'] = refEarningStatus;
    data['ref_earning_exchange_rate'] = refEarningExchangeRate;
    data['refund_active_status'] = refundActiveStatus;
    if (socialLogin != null) {
      data['social_login'] = socialLogin!.map((v) => v.toJson()).toList();
    }
    if (appleLogin != null) {
      data['apple_login'] = appleLogin!.map((v) => v.toJson()).toList();
    }
    data['tax_included'] = taxIncluded;
    data['cookies_text'] = cookiesText;
    data['home_delivery_status'] = homeDeliveryStatus;
    data['takeaway_status'] = takeawayStatus;
    data['partial_payment_status'] = partialPaymentStatus;
    data['partial_payment_method'] = partialPaymentMethod;
    data['additional_charge_status'] = additionalChargeStatus;
    data['additional_charge_name'] = additionalChargeName;
    data['additional_charge'] = additionCharge;
    if (activePaymentMethodList != null) {
      data['active_payment_method_list'] = activePaymentMethodList!
          .map((v) => v.toJson())
          .toList();
    }
    if (digitalPaymentInfo != null) {
      data['digital_payment_info'] = digitalPaymentInfo!.toJson();
    }
    data['add_fund_status'] = addFundStatus;
    data['offline_payment_status'] = offlinePaymentStatus;
    data['guest_checkout_status'] = guestCheckoutStatus;
    data['admin_commission'] = adminCommission;
    data['subscription_free_trial_days'] = subscriptionFreeTrialDays;
    data['subscription_free_trial_status'] = subscriptionFreeTrialStatus;
    data['subscription_business_model'] = subscriptionBusinessModel;
    data['commission_business_model'] = commissionBusinessModel;
    data['subscription_free_trial_type'] = subscriptionFreeTrialType;
    data['country_picker_status'] = countryPickerStatus;
    data['firebase_otp_verification'] = firebaseOtpVerification;
    if (centralizeLoginSetup != null) {
      data['centralize_login'] = centralizeLoginSetup!.toJson();
    }
    data['vehicle_distance_min'] = vehicleDistanceMinPrice;
    data['vehicle_hourly_min'] = vehicleHourlyMinPrice;
    if (adminFreeDelivery != null) {
      data['admin_free_delivery'] = adminFreeDelivery!.toJson();
    }
    data['is_sms_active'] = isSmsActive;
    data['is_mail_active'] = isMailActive;
    return data;
  }
}

class BaseUrls {
  BaseUrls({
    this.itemImageUrl,
    this.customerImageUrl,
    this.bannerImageUrl,
    this.categoryImageUrl,
    this.reviewImageUrl,
    this.notificationImageUrl,
    this.vendorImageUrl,
    this.storeImageUrl,
    this.storeCoverPhotoUrl,
    this.deliveryManImageUrl,
    this.chatImageUrl,
    this.campaignImageUrl,
    this.moduleImageUrl,
    this.orderAttachmentUrl,
    this.parcelCategoryImageUrl,
    this.landingPageImageUrl,
    this.businessLogoUrl,
    this.refundImageUrl,
    this.vehicleImageUrl,
    this.vehicleBrandImageUrl,
    this.gatewayImageUrl,
    this.brandImageUrl,
  });

  BaseUrls.fromJson(Map<String, dynamic> json) {
    itemImageUrl = json['item_image_url'] as String?;
    customerImageUrl = json['customer_image_url'] as String?;
    bannerImageUrl = json['banner_image_url'] as String?;
    categoryImageUrl = json['category_image_url'] as String?;
    reviewImageUrl = json['review_image_url'] as String?;
    notificationImageUrl = json['notification_image_url'] as String?;
    vendorImageUrl = json['vendor_image_url'] as String?;
    storeImageUrl = json['store_image_url'] as String?;
    storeCoverPhotoUrl = json['store_cover_photo_url'] as String?;
    deliveryManImageUrl = json['delivery_man_image_url'] as String?;
    chatImageUrl = json['chat_image_url'] as String?;
    campaignImageUrl = json['campaign_image_url'] as String?;
    moduleImageUrl = json['module_image_url'] as String?;
    orderAttachmentUrl = json['order_attachment_url'] as String?;
    parcelCategoryImageUrl = json['parcel_category_image_url'] as String?;
    landingPageImageUrl = json['landing_page_image_url'] as String?;
    businessLogoUrl = json['business_logo_url'] as String?;
    refundImageUrl = json['refund_image_url'] as String?;
    vehicleImageUrl = json['vehicle_image_url'] as String?;
    vehicleBrandImageUrl = json['vehicle_brand_image_url'] as String?;
    gatewayImageUrl = json['gateway_image_url'] as String?;
    brandImageUrl = json['brand_image_url'] as String?;
  }
  String? itemImageUrl;
  String? customerImageUrl;
  String? bannerImageUrl;
  String? categoryImageUrl;
  String? reviewImageUrl;
  String? notificationImageUrl;
  String? vendorImageUrl;
  String? storeImageUrl;
  String? storeCoverPhotoUrl;
  String? deliveryManImageUrl;
  String? chatImageUrl;
  String? campaignImageUrl;
  String? moduleImageUrl;
  String? orderAttachmentUrl;
  String? parcelCategoryImageUrl;
  String? landingPageImageUrl;
  String? businessLogoUrl;
  String? refundImageUrl;
  String? vehicleImageUrl;
  String? vehicleBrandImageUrl;
  String? gatewayImageUrl;
  String? brandImageUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_image_url'] = itemImageUrl;
    data['customer_image_url'] = customerImageUrl;
    data['banner_image_url'] = bannerImageUrl;
    data['category_image_url'] = categoryImageUrl;
    data['review_image_url'] = reviewImageUrl;
    data['notification_image_url'] = notificationImageUrl;
    data['vendor_image_url'] = vendorImageUrl;
    data['store_image_url'] = storeImageUrl;
    data['store_cover_photo_url'] = storeCoverPhotoUrl;
    data['delivery_man_image_url'] = deliveryManImageUrl;
    data['chat_image_url'] = chatImageUrl;
    data['campaign_image_url'] = campaignImageUrl;
    data['module_image_url'] = moduleImageUrl;
    data['order_attachment_url'] = orderAttachmentUrl;
    data['parcel_category_image_url'] = parcelCategoryImageUrl;
    data['landing_page_image_url'] = landingPageImageUrl;
    data['business_logo_url'] = businessLogoUrl;
    data['refund_image_url'] = refundImageUrl;
    data['vehicle_image_url'] = vehicleImageUrl;
    data['vehicle_brand_image_url'] = vehicleBrandImageUrl;
    data['gateway_image_url'] = gatewayImageUrl;
    data['brand_image_url'] = brandImageUrl;
    return data;
  }
}

class DefaultLocation {
  DefaultLocation({this.lat, this.lng});

  DefaultLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as String?;
    lng = json['lng'] as String?;
  }
  String? lat;
  String? lng;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Language {
  Language({this.key, this.value});

  Language.fromJson(Map<String, dynamic> json) {
    key = json['key'] as String?;
    value = json['value'] as String?;
  }
  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class ModuleConfig {
  ModuleConfig({this.moduleType, this.module});

  ModuleConfig.fromJson(Map<String, dynamic> json) {
    moduleType = (json['module_type'] as List)
        .map((e) => e.toString())
        .toList();
    module = json[moduleType![0]] != null
        ? Module.fromJson(json[moduleType![0]] as Map<String, dynamic>)
        : null;
  }
  List<String>? moduleType;
  Module? module;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['module_type'] = moduleType;
    if (module != null) {
      data[moduleType![0]] = module!.toJson();
    }
    return data;
  }
}

class Module {
  Module({
    this.orderPlaceToScheduleInterval,
    this.addOn,
    this.stock,
    this.vegNonVeg,
    this.unit,
    this.orderAttachment,
    this.showRestaurantText,
    this.isParcel,
    this.isTaxi,
    this.newVariation,
    this.description,
  });

  Module.fromJson(Map<String, dynamic> json) {
    orderPlaceToScheduleInterval =
        json['order_place_to_schedule_interval'] as bool?;
    addOn = json['add_on'] as bool?;
    stock = json['stock'] as bool?;
    vegNonVeg = json['veg_non_veg'] as bool?;
    unit = json['unit'] as bool?;
    orderAttachment = json['order_attachment'] as bool?;
    showRestaurantText = json['show_restaurant_text'] as bool?;
    isParcel = json['is_parcel'] as bool?;
    isTaxi = json['is_taxi'] as bool?;
    newVariation = json['new_variation'] as bool?;
    description = json['description'] as String?;
  }
  bool? orderPlaceToScheduleInterval;
  bool? addOn;
  bool? stock;
  bool? vegNonVeg;
  bool? unit;
  bool? orderAttachment;
  bool? showRestaurantText;
  bool? isParcel;
  bool? isTaxi;
  bool? newVariation;
  String? description;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_place_to_schedule_interval'] = orderPlaceToScheduleInterval;
    data['add_on'] = addOn;
    data['stock'] = stock;
    data['veg_non_veg'] = vegNonVeg;
    data['unit'] = unit;
    data['order_attachment'] = orderAttachment;
    data['show_restaurant_text'] = showRestaurantText;
    data['is_parcel'] = isParcel;
    data['is_taxi'] = isTaxi;
    data['new_variation'] = newVariation;
    data['description'] = description;
    return data;
  }
}

class OrderStatus {
  OrderStatus({this.accepted});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    accepted = json['accepted'] as bool?;
  }
  bool? accepted;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accepted'] = accepted;
    return data;
  }
}

class LandingPageSettings {
  LandingPageSettings({this.mobileAppSectionImage, this.topContentImage});

  LandingPageSettings.fromJson(Map<String, dynamic> json) {
    mobileAppSectionImage = json['mobile_app_section_image'] as String?;
    topContentImage = json['top_content_image'] as String?;
  }
  String? mobileAppSectionImage;
  String? topContentImage;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mobile_app_section_image'] = mobileAppSectionImage;
    data['top_content_image'] = topContentImage;
    return data;
  }
}

class SocialMedia {
  SocialMedia({this.id, this.name, this.link, this.status});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    link = json['link'] as String?;
    status = json['status'] as int?;
  }
  int? id;
  String? name;
  String? link;
  int? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['status'] = status;
    return data;
  }
}

class LandingPageLinks {
  LandingPageLinks({
    this.appUrlAndroidStatus,
    this.appUrlAndroid,
    this.appUrlIosStatus,
    this.appUrlIos,
  });

  LandingPageLinks.fromJson(Map<String, dynamic> json) {
    appUrlAndroidStatus = json['app_url_android_status'] as String?;
    appUrlAndroid = json['app_url_android'] as String?;
    appUrlIosStatus = json['app_url_ios_status'] as String?;
    appUrlIos = json['app_url_ios'] as String?;
  }
  String? appUrlAndroidStatus;
  String? appUrlAndroid;
  String? appUrlIosStatus;
  String? appUrlIos;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['app_url_android_status'] = appUrlAndroidStatus;
    data['app_url_android'] = appUrlAndroid;
    data['app_url_ios_status'] = appUrlIosStatus;
    data['app_url_ios'] = appUrlIos;
    return data;
  }
}

class SocialLogin {
  SocialLogin({this.loginMedium, this.status, this.clientId, this.redirectUrl});

  SocialLogin.fromJson(Map<String, dynamic> json) {
    loginMedium = json['login_medium'] as String?;
    status = json['status'] as bool?;
    clientId = json['client_id'] as String?;
    redirectUrl = json['redirect_url_flutter'] as String?;
  }
  String? loginMedium;
  bool? status;
  String? clientId;
  String? redirectUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['login_medium'] = loginMedium;
    data['status'] = status;
    data['client_id'] = clientId;
    data['redirect_url_flutter'] = redirectUrl;
    return data;
  }
}

class PaymentBody {
  PaymentBody({this.getWay, this.getWayTitle, this.getWayImageFullUrl});

  PaymentBody.fromJson(Map<String, dynamic> json) {
    getWay = json['gateway'] as String?;
    getWayTitle = json['gateway_title'] as String?;
    getWayImageFullUrl = json['gateway_image_full_url'] as String?;
  }
  String? getWay;
  String? getWayTitle;
  String? getWayImageFullUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gateway'] = getWay;
    data['gateway_title'] = getWayTitle;
    data['gateway_image_full_url'] = getWayImageFullUrl;
    return data;
  }
}

class DigitalPaymentInfo {
  DigitalPaymentInfo({
    this.digitalPayment,
    this.pluginPaymentGateways,
    this.defaultPaymentGateways,
  });

  DigitalPaymentInfo.fromJson(Map<String, dynamic> json) {
    digitalPayment = json['digital_payment'] as bool?;
    pluginPaymentGateways = json['plugin_payment_gateways'] as bool?;
    defaultPaymentGateways = json['default_payment_gateways'] as bool?;
  }
  bool? digitalPayment;
  bool? pluginPaymentGateways;
  bool? defaultPaymentGateways;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['digital_payment'] = digitalPayment;
    data['plugin_payment_gateways'] = pluginPaymentGateways;
    data['default_payment_gateways'] = defaultPaymentGateways;
    return data;
  }
}

class BusinessPlan {
  BusinessPlan({this.commission, this.subscription});

  BusinessPlan.fromJson(Map<String, dynamic> json) {
    commission = json['commission'] as int?;
    subscription = json['subscription'] as int?;
  }
  int? commission;
  int? subscription;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['commission'] = commission;
    data['subscription'] = subscription;
    return data;
  }
}

class CentralizeLoginSetup {
  CentralizeLoginSetup({
    this.manualLoginStatus,
    this.otpLoginStatus,
    this.socialLoginStatus,
    this.googleLoginStatus,
    this.facebookLoginStatus,
    this.appleLoginStatus,
    this.emailVerificationStatus,
    this.phoneVerificationStatus,
  });

  CentralizeLoginSetup.fromJson(Map<String, dynamic> json) {
    manualLoginStatus = json['manual_login_status'] == 1;
    otpLoginStatus = json['otp_login_status'] == 1;
    socialLoginStatus = json['social_login_status'] == 1;
    googleLoginStatus = json['google_login_status'] == 1;
    facebookLoginStatus = json['facebook_login_status'] == 1;
    appleLoginStatus = json['apple_login_status'] == 1;
    emailVerificationStatus = json['email_verification_status'] == 1;
    phoneVerificationStatus = json['phone_verification_status'] == 1;
  }
  bool? manualLoginStatus;
  bool? otpLoginStatus;
  bool? socialLoginStatus;
  bool? googleLoginStatus;
  bool? facebookLoginStatus;
  bool? appleLoginStatus;
  bool? emailVerificationStatus;
  bool? phoneVerificationStatus;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['manual_login_status'] = manualLoginStatus;
    data['otp_login_status'] = otpLoginStatus;
    data['social_login_status'] = socialLoginStatus;
    data['google_login_status'] = googleLoginStatus;
    data['facebook_login_status'] = facebookLoginStatus;
    data['apple_login_status'] = appleLoginStatus;
    data['email_verification_status'] = emailVerificationStatus;
    data['phone_verification_status'] = phoneVerificationStatus;
    return data;
  }
}

class AdminFreeDelivery {
  AdminFreeDelivery({this.status, this.type, this.freeDeliveryOver});

  AdminFreeDelivery.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    type = json['type'] as String?;
    freeDeliveryOver = json['free_delivery_over'] as num?;
  }
  bool? status;
  String? type;
  num? freeDeliveryOver;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['type'] = type;
    data['free_delivery_over'] = freeDeliveryOver;
    return data;
  }
}
