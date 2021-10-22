import 'dart:convert';

import 'package:plugs/flw/flw_sensor_data.dart';

class FlwSnapshot {
  //
  final int ts;

  //
  final List<FlwSensorData> sensors;

  FlwSnapshot(this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwSnapshot.fromMap(Map<String, dynamic> map) {
    return FlwSnapshot(
      map['ts'],
      List<FlwSensorData>.from(
          map['sensors']?.map((x) => FlwSensorData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSnapshot.fromJson(String source) =>
      FlwSnapshot.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSnapshot(ts: $ts, sensors: $sensors)';
}
