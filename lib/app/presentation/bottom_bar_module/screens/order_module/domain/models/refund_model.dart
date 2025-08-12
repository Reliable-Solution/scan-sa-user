class RefundModel {
  RefundModel({this.refundReasons});

  RefundModel.fromJson(Map<String, dynamic> json) {
    if (json['refund_reasons'] != null) {
      refundReasons = <RefundReasons>[];
      json['refund_reasons'].forEach((v) {
        refundReasons!.add(RefundReasons.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  List<RefundReasons>? refundReasons;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (refundReasons != null) {
      data['refund_reasons'] = refundReasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefundReasons {
  RefundReasons({
    this.id,
    this.reason,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  RefundReasons.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    reason = json['reason'] as String?;
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }
  int? id;
  String? reason;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
