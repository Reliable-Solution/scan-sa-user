class BusinessPlanBody {
  BusinessPlanBody({
    this.businessPlan,
    this.storeId,
    this.packageId,
    this.payment,
    this.paymentGateway,
    this.callBack,
    this.paymentPlatform,
    this.type,
  });

  BusinessPlanBody.fromJson(Map<String, dynamic> json) {
    businessPlan = json['business_plan'] as String?;
    storeId = json['store_id'] as String?;
    packageId = json['package_id'] as String?;
    payment = json['payment'] as String?;
    paymentGateway = json['payment_gateway'] as String?;
    callBack = json['callback'] as String?;
    paymentPlatform = json['payment_platform'] as String?;
    type = json['type'] as String?;
  }
  String? businessPlan;
  String? storeId;
  String? packageId;
  String? payment;
  String? paymentGateway;
  String? callBack;
  String? paymentPlatform;
  String? type;

  Map<String, String?> toJson() {
    final data = <String, String?>{};
    data['business_plan'] = businessPlan;
    data['store_id'] = storeId;
    data['package_id'] = packageId;
    data['payment'] = payment;
    data['payment_gateway'] = paymentGateway;
    data['callback'] = callBack;
    data['payment_platform'] = paymentPlatform;
    data['type'] = type;
    return data;
  }
}
