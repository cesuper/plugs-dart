import 'dart:convert';

import '../ain/ain_sensor.dart';

class ScpSensor extends AinSensor {
  //
  final num min;

  //
  final num max;

  //
  final num range;

  ScpSensor(
    String serial,
    String name,
    this.min,
    this.max,
    this.range,
  ) : super(serial, name);

  ///
  factory ScpSensor.fromJson(String source) =>
      ScpSensor.fromMap(json.decode(source));

  ///
  factory ScpSensor.fromMap(Map<String, dynamic> map) {
    return ScpSensor(
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
