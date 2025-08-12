class TimeSlotModel {
  TimeSlotModel({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  TimeSlotModel.fromJson(Map<String, dynamic> json) {
    day = json['day'] as int?;
    startTime = json['start_time'] == null
        ? null
        : DateTime.tryParse((json['start_time'] as String?) ?? '');
    endTime = json['end_time'] == null
        ? null
        : DateTime.tryParse((json['end_time'] as String?) ?? '');
  }
  int? day;
  DateTime? startTime;
  DateTime? endTime;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
