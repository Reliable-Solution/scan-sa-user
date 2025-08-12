class TransactionModel {
  TransactionModel({this.totalSize, this.limit, this.offset, this.data});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'] as int?;
    limit = json['limit'] as String?;
    offset = json['offset'] as String?;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Transaction.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  int? totalSize;
  String? limit;
  String? offset;
  List<Transaction>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  Transaction({
    this.userId,
    this.transactionId,
    this.credit,
    this.debit,
    this.adminBonus,
    this.balance,
    this.transactionType,
    this.reference,
    this.createdAt,
    this.updatedAt,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] as int?;
    transactionId = json['transaction_id'] as String?;
    credit = json['credit'] as num?;
    debit = json['debit'] as num?;
    if (json['admin_bonus'] != null) {
      adminBonus = json['admin_bonus'] as num?;
    }
    balance = json['balance'] as num?;
    transactionType = json['transaction_type'] as String?;
    reference = json['reference'] as String?;
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'] as String)
        : null;
    updatedAt = json['updated_at'] != null
        ? DateTime.parse(json['updated_at'] as String)
        : null;
  }
  int? userId;
  String? transactionId;
  num? credit;
  num? debit;
  num? adminBonus;
  num? balance;
  String? transactionType;
  String? reference;
  DateTime? createdAt;
  DateTime? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['transaction_id'] = transactionId;
    data['credit'] = credit;
    data['debit'] = debit;
    data['admin_bonus'] = adminBonus;
    data['balance'] = balance;
    data['transaction_type'] = transactionType;
    data['reference'] = reference;
    data['created_at'] = createdAt!.toIso8601String();
    data['updated_at'] = updatedAt!.toIso8601String();
    return data;
  }
}
