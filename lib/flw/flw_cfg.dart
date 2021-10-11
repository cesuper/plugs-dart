import 'dart:convert';

import 'flw_sensor.dart';

class FlwCfg {
  // list of sensors
  final List<FlwSensor> sensors;

  FlwCfg(this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwCfg.fromMap(Map<String, dynamic> map) {
    return FlwCfg(
      List<FlwSensor>.from(map['sensors']?.map((x) => FlwSensor.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwCfg.fromJson(String source) => FlwCfg.fromMap(json.decode(source));

  @override
  String toString() => 'FlwCfg(sensors: $sensors)';
}
