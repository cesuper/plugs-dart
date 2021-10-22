import 'dart:convert';

import 'package:plugs/flw/flw_sensor_data.dart';

class FlwData {
  //
  final int ts;

  //
  final List<FlwSensorData> sensors;

  FlwData(this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwData.fromMap(Map<String, dynamic> map) {
    return FlwData(
      map['ts'],
      List<FlwSensorData>.from(
          map['sensors']?.map((x) => FlwSensorData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwData.fromJson(String source) =>
      FlwData.fromMap(json.decode(source));

  @override
  String toString() => 'FlwData(ts: $ts, sensors: $sensors)';
}
