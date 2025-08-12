class UpdateProfileResponseModel {
  UpdateProfileResponseModel({
    this.verificationOn,
    this.verificationMedium,
    this.message,
  });

  UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    verificationOn = json['verification_on'] as String?;
    verificationMedium = json['verification_medium'] as String?;
    message = json['message'] as String?;
  }
  String? verificationOn;
  String? verificationMedium;
  String? message;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['verification_on'] = verificationOn;
    data['verification_medium'] = verificationMedium;
    data['message'] = message;
    return data;
  }
}
