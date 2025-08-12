class OfflineMethodModel {
  OfflineMethodModel({
    this.id,
    this.methodName,
    this.methodFields,
    this.methodInformations,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  OfflineMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    methodName = json['method_name'] as String?;
    if (json['method_fields'] != null) {
      methodFields = <MethodFields>[];
      json['method_fields'].forEach((v) {
        methodFields!.add(MethodFields.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['method_informations'] != null) {
      methodInformations = <MethodInformations>[];
      json['method_informations'].forEach((v) {
        methodInformations!.add(
          MethodInformations.fromJson(v as Map<String, dynamic>),
        );
      });
    }
    status = json['status'] as int?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
  }
  int? id;
  String? methodName;
  List<MethodFields>? methodFields;
  List<MethodInformations>? methodInformations;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['method_name'] = methodName;
    if (methodFields != null) {
      data['method_fields'] = methodFields!.map((v) => v.toJson()).toList();
    }
    if (methodInformations != null) {
      data['method_informations'] = methodInformations!
          .map((v) => v.toJson())
          .toList();
    }
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class MethodFields {
  MethodFields({this.inputName, this.inputData});

  MethodFields.fromJson(Map<String, dynamic> json) {
    inputName = json['input_name'] as String?;
    inputData = json['input_data'] as String?;
  }
  String? inputName;
  String? inputData;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['input_name'] = inputName;
    data['input_data'] = inputData;
    return data;
  }
}

class MethodInformations {
  MethodInformations({
    this.customerInput,
    this.customerPlaceholder,
    this.isRequired,
  });

  MethodInformations.fromJson(Map<String, dynamic> json) {
    customerInput = json['customer_input'] as String?;
    customerPlaceholder = json['customer_placeholder'] as String?;
    isRequired = json['is_required'] == 1;
  }
  String? customerInput;
  String? customerPlaceholder;
  bool? isRequired;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customer_input'] = customerInput;
    data['customer_placeholder'] = customerPlaceholder;
    data['is_required'] = isRequired;
    return data;
  }
}
