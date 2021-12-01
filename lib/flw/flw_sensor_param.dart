import 'dart:convert';

import '../ain/ain_sensor_param.dart';

class FlwSensorParam extends AinSensorParam {
  //
  final String group;

  //
  final int dir;

  ///
  FlwSensorParam(String serial, String name, this.group, this.dir)
      : super(serial, name);

  ///
  factory FlwSensorParam.fromMap(Map<String, dynamic> map) {
    return FlwSensorParam(
      map['serial'],
      map['name'],
      map['group'],
      map['dir'],
    );
  }

  ///
  factory FlwSensorParam.fromJson(String source) =>
      FlwSensorParam.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSensorParam(serial: $serial, name: $name)';
}
