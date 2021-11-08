import 'dart:convert';

import '../ain/ain_sensor_param.dart';

class FlwSensor extends AinSensorParam {
  ///
  FlwSensor(String serial, String name) : super(serial, name);

  ///
  factory FlwSensor.fromMap(Map<String, dynamic> map) {
    return FlwSensor(
      map['serial'],
      map['name'],
    );
  }

  ///
  factory FlwSensor.fromJson(String source) =>
      FlwSensor.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSensor(serial: $serial, name: $name)';
}
