import 'dart:convert';

import 'cp_sensor_data.dart';

class CpSnapshot {
  //
  final int ts;

  //
  final List<CpSensorData> sensors;

  CpSnapshot(this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory CpSnapshot.fromMap(Map<String, dynamic> map) {
    return CpSnapshot(
      map['ts'],
      List<CpSensorData>.from(
          map['sensors']?.map((x) => CpSensorData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSnapshot.fromJson(String source) =>
      CpSnapshot.fromMap(json.decode(source));

  @override
  String toString() => 'CpSnapshot(ts: $ts, sensors: $sensors)';
}
