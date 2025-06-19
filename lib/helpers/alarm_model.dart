class AlarmModel {
  final int? id;
  final DateTime dateTime;
  final bool enabled;

  AlarmModel({this.id, required this.dateTime, this.enabled = true});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'enabled': enabled ? 1 : 0,
    };
  }

  factory AlarmModel.fromMap(Map<String, dynamic> map) {
    return AlarmModel(
      id: map['id'],
      dateTime: DateTime.parse(map['dateTime']),
      enabled: map['enabled'] == 1,
    );
  }
}
