class SocialLogInBody {
  SocialLogInBody({
    this.email,
    this.token,
    this.uniqueId,
    this.medium,
    this.phone,
    this.deviceToken,
    this.accessToken,
    this.loginType,
    this.verified,
    this.guestId,
    this.platform,
  });

  SocialLogInBody.fromJson(Map<String, dynamic> json) {
    email = json['email'] as String?;
    token = json['token'] as String?;
    uniqueId = json['unique_id'] as String?;
    medium = json['medium'] as String?;
    phone = json['phone'] as String?;
    deviceToken = json['cm_firebase_token'] as String?;
    accessToken = json['access_token'] as int?;
    loginType = json['login_type'] as String?;
    verified = json['verified'] as String?;
    guestId = json['guest_id'] as String?;
    platform = json['platform'] as String?;
  }
  String? email;
  String? token;
  String? uniqueId;
  String? medium;
  String? phone;
  String? deviceToken;
  int? accessToken;
  String? loginType;
  String? verified;
  String? guestId;
  String? platform;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['token'] = token;
    data['unique_id'] = uniqueId;
    data['medium'] = medium;
    data['phone'] = phone;
    data['cm_firebase_token'] = deviceToken;
    if (accessToken != null) {
      data['access_token'] = accessToken;
    }
    data['login_type'] = loginType;
    if (verified != null) {
      data['verified'] = verified;
    }
    if (guestId != null) {
      data['guest_id'] = guestId;
    }
    if (platform != null) {
      data['platform'] = platform;
    }
    return data;
  }
}
