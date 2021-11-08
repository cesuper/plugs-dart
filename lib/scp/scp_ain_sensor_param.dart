import 'dart:convert';

import '../ain/ain_sensor_param.dart';

class ScpAinSensorParam extends AinSensorParam {
  //
  final num min;

  //
  final num max;

  //
  final num range;

  ScpAinSensorParam(
    String serial,
    String name,
    this.min,
    this.max,
    this.range,
  ) : super(serial, name);

  ///
  factory ScpAinSensorParam.fromJson(String source) =>
      ScpAinSensorParam.fromMap(json.decode(source));

  ///
  factory ScpAinSensorParam.fromMap(Map<String, dynamic> map) {
    return ScpAinSensorParam(
      map['serial'],
      map['name'],
      map['min'],
      map['max'],
      map['range'],
    );
  }

  @override
  String toString() =>
      'ScpSensorParam(serial: $serial, name: $name, min: $min, max: $max, range: $range)';

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
