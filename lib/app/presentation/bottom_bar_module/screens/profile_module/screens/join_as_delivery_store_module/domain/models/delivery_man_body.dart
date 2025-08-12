class DeliveryManBody {
  DeliveryManBody({
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.password,
    this.identityType,
    this.identityNumber,
    this.earning,
    this.zoneId,
    this.vehicleId,
  });

  DeliveryManBody.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'] as String?;
    lName = json['l_name'] as String?;
    phone = json['phone'] as String?;
    email = json['email'] as String?;
    password = json['password'] as String?;
    identityType = json['identity_type'] as String?;
    identityNumber = json['identity_number'] as String?;
    earning = json['earning'] as String?;
    zoneId = json['zone_id'] as String?;
    vehicleId = json['vehicle_id'] as String?;
  }
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? identityType;
  String? identityNumber;
  String? earning;
  String? zoneId;
  String? vehicleId;

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['f_name'] = fName!;
    data['l_name'] = lName!;
    data['phone'] = phone!;
    data['email'] = email!;
    data['password'] = password!;
    data['identity_type'] = identityType!;
    data['identity_number'] = identityNumber!;
    data['earning'] = earning!;
    data['zone_id'] = zoneId!;
    data['vehicle_id'] = vehicleId!;
    return data;
  }
}
