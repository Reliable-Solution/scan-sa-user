class VerificationDataModel {
  VerificationDataModel({
    this.phone,
    this.email,
    this.verificationType,
    this.otp,
    this.loginType,
    this.guestId,
  });

  VerificationDataModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'] as String?;
    email = json['email'] as String?;
    verificationType = json['verification_type'] as String?;
    otp = json['otp'] as String?;
    loginType = json['login_type'] as String?;
    guestId = json['guest_id'] as String?;
  }
  String? phone;
  String? email;
  String? verificationType;
  String? otp;
  String? loginType;
  String? guestId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (phone != null) {
      data['phone'] = phone;
    }
    if (email != null) {
      data['email'] = email;
    }
    data['verification_type'] = verificationType;
    data['otp'] = otp;
    data['login_type'] = loginType;
    if (guestId != null) {
      data['guest_id'] = guestId;
    }
    return data;
  }
}
