class SignUpBodyModel {
  SignUpBodyModel({
    this.fName,
    this.lName,
    this.phone,
    this.email = '',
    this.password,
    this.refCode = '',
    this.deviceToken,
    this.guestId,
    this.name,
  });

  SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'] as String?;
    lName = json['l_name'] as String?;
    phone = json['phone'] as String?;
    email = json['email'] as String?;
    password = json['password'] as String?;
    refCode = json['ref_code'] as String?;
    deviceToken = json['fcm_firebase_token'] as String?;
    guestId = json['guest_id'] as int?;
    name = json['name'] as String?;
  }
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? refCode;
  String? deviceToken;
  int? guestId;
  String? name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['ref_code'] = refCode;
    data['cm_firebase_token'] = deviceToken;
    data['guest_id'] = guestId;
    data['name'] = name;
    return data;
  }
}
