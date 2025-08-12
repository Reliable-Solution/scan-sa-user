class WalletFilterBodyModel {
  WalletFilterBodyModel({this.title, this.value});

  WalletFilterBodyModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    value = json['value'] as String?;
  }
  String? title;
  String? value;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}
