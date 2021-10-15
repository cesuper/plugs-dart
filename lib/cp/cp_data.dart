import 'dart:convert';

import 'cp_sensor_data.dart';

class CpData {
  //
  final int ts;

  //
  final List<CpSensorData> sensors;

  CpData(this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory CpData.fromMap(Map<String, dynamic> map) {
    return CpData(
      map['ts'],
      List<CpSensorData>.from(
          map['sensors']?.map((x) => CpSensorData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpData.fromJson(String source) => CpData.fromMap(json.decode(source));

  @override
  String toString() => 'CpData(ts: $ts, sensors: $sensors)';
}
