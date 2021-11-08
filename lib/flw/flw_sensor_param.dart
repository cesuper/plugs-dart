import 'dart:convert';

import '../ain/ain_sensor_param.dart';

class FlwSensorParam extends AinSensorParam {
  ///
  FlwSensorParam(String serial, String name) : super(serial, name);

  ///
  factory FlwSensorParam.fromMap(Map<String, dynamic> map) {
    return FlwSensorParam(
      map['serial'],
      map['name'],
    );
  }

  ///
  factory FlwSensorParam.fromJson(String source) =>
      FlwSensorParam.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSensorParam(serial: $serial, name: $name)';
}
