class UpdateUserModel {
  UpdateUserModel({
    this.name,
    this.email,
    this.phone,
    this.otp,
    this.buttonType,
    this.sessionInfo,
    this.verificationOn,
    this.verificationMedium,
  });

  UpdateUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    email = json['email'] as String?;
    phone = json['phone'] as String?;
    otp = json['otp'] as String?;
    buttonType = json['button_type'] as String?;
    sessionInfo = json['session_info'] as String?;
    verificationOn = json['verification_on'] as String?;
    verificationMedium = json['verification_medium'] as String?;
  }
  String? name;
  String? email;
  String? phone;
  String? otp;
  String? buttonType;
  String? sessionInfo;
  String? verificationOn;
  String? verificationMedium;

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['name'] = name ?? '';
    data['email'] = email ?? '';
    data['phone'] = phone ?? '';
    data['otp'] = otp ?? '';
    data['button_type'] = buttonType ?? '';
    if (sessionInfo != null) {
      data['session_info'] = sessionInfo ?? '';
    }
    if (verificationOn != null) {
      data['verification_on'] = verificationOn ?? '';
    }
    if (verificationMedium != null) {
      data['verification_medium'] = verificationMedium ?? '';
    }
    return data;
  }
}
