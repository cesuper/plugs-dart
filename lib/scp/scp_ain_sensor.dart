import 'dart:convert';

import '../ain/ain_sensor_param.dart';

class ScpAinSensor extends AinSensorParam {
  //
  final num min;

  //
  final num max;

  //
  final num range;

  ScpAinSensor(
    String serial,
    String name,
    this.min,
    this.max,
    this.range,
  ) : super(serial, name);

  ///
  factory ScpAinSensor.fromJson(String source) =>
      ScpAinSensor.fromMap(json.decode(source));

  ///
  factory ScpAinSensor.fromMap(Map<String, dynamic> map) {
    return ScpAinSensor(
      map['serial'],
      map['name'],
      map['min'],
      map['max'],
      map['range'],
    );
  }

  @override
  String toString() =>
      'ScpSensor(serial: $serial, name: $name, min: $min, max: $max, range: $range)';

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'min': min,
        'max': max,
        'range': range,
      });
  }
}
