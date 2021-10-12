import 'dart:convert';

import 'flw_sensor.dart';

class FlwPlugCfg {
  // list of sensors
  final List<FlwSensor> sensors;

  FlwPlugCfg(this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwPlugCfg.fromMap(Map<String, dynamic> map) {
    return FlwPlugCfg(
      List<FlwSensor>.from(map['sensors']?.map((x) => FlwSensor.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwPlugCfg.fromJson(String source) =>
      FlwPlugCfg.fromMap(json.decode(source));

  @override
  String toString() => 'FlwPlugCfg(sensors: $sensors)';
}
