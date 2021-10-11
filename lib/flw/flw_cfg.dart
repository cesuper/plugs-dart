import 'dart:convert';

import 'flw_sensor_cfg.dart';

class FlwCfg {
  // list of sensors
  final List<FlwSensorCfg> sensors;

  FlwCfg(this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwCfg.fromMap(Map<String, dynamic> map) {
    return FlwCfg(
      List<FlwSensorCfg>.from(
          map['sensors']?.map((x) => FlwSensorCfg.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwCfg.fromJson(String source) => FlwCfg.fromMap(json.decode(source));

  @override
  String toString() => 'FlwCfg(sensors: $sensors)';
}
