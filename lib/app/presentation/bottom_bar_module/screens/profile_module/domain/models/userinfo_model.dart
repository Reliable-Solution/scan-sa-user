class UserInfoModel {
  UserInfoModel({
    this.id,
    this.fName,
    this.lName,
    this.email,
    this.imageFullUrl,
    this.phone,
    this.createdAt,
    this.password,
    this.orderCount,
    this.memberSinceDays,
    this.walletBalance,
    this.loyaltyPoint,
    this.refCode,
    this.socialId,
    this.userInfo,
    this.isValidForDiscount,
    this.discountAmount,
    this.discountAmountType,
    this.validity,
    this.selectedModuleForInterest,
    this.isPhoneVerified,
    this.isEmailVerified,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    fName = json['f_name'] as String?;
    lName = json['l_name'] as String?;
    email = json['email'] as String?;
    imageFullUrl = json['image_full_url'] as String?;
    phone = json['phone'] as String?;
    createdAt = json['created_at'] as String?;
    password = json['password'] as String?;
    orderCount = json['order_count'] as int?;
    memberSinceDays = json['member_since_days'] as int?;
    walletBalance = json['wallet_balance'] as num?;
    loyaltyPoint = json['loyalty_point'] as num?;
    refCode = json['ref_code'] as String?;
    socialId = json['social_id'] as String?;
    userInfo = json['userinfo'] != null
        ? User.fromJson(json['userinfo'] as Map<String, dynamic>)
        : null;
    isValidForDiscount = json['is_valid_for_discount'] as bool? ?? false;
    discountAmount = json['discount_amount'] as num?;
    discountAmountType = json['discount_amount_type'] as String?;
    validity = json['validity'] as String?;
    if (json['selected_modules_for_interest'] != null) {
      selectedModuleForInterest = [];
      json['selected_modules_for_interest'].forEach((value) {
        if (value != null && value != 'null') {
          selectedModuleForInterest!.add(int.parse(value.toString()));
        }
      });
    }
    isPhoneVerified = json['is_phone_verified'] == 1;
    isEmailVerified = json['is_email_verified'] == 1;
  }
  int? id;
  String? fName;
  String? lName;
  String? email;
  String? imageFullUrl;
  String? phone;
  String? createdAt;
  String? password;
  int? orderCount;
  int? memberSinceDays;
  num? walletBalance;
  num? loyaltyPoint;
  String? refCode;
  String? socialId;
  User? userInfo;
  bool? isValidForDiscount;
  num? discountAmount;
  String? discountAmountType;
  String? validity;
  List<int>? selectedModuleForInterest;
  bool? isPhoneVerified;
  bool? isEmailVerified;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['email'] = email;
    data['image_full_url'] = imageFullUrl;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['password'] = password;
    data['order_count'] = orderCount;
    data['member_since_days'] = memberSinceDays;
    data['wallet_balance'] = walletBalance;
    data['loyalty_point'] = loyaltyPoint;
    data['ref_code'] = refCode;
    if (userInfo != null) {
      data['user`info'] = userInfo!.toJson();
    }
    data['is_valid_for_discount'] = isValidForDiscount;
    data['discount_amount'] = discountAmount;
    data['discount_amount_type'] = discountAmountType;
    data['validity'] = validity;
    data['selected_modules_for_interest'] = selectedModuleForInterest;
    data['is_phone_verified'] = isPhoneVerified;
    data['is_email_verified'] = isEmailVerified;
    return data;
  }
}

class User {
  User({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.imageFullUrl,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    fName = json['f_name'] as String?;
    lName = json['l_name'] as String?;
    phone = json['phone'] as String?;
    email = json['email'] as String?;
    imageFullUrl = json['image_full_url'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? imageFullUrl;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['image_full_url'] = imageFullUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
