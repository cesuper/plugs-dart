import 'dart:convert';

import '../ain/ain_sensor_param.dart';

class SfpSensorParam extends AinSensorParam {
  //
  final String group;

  //
  final String dir;

  ///
  SfpSensorParam(String serial, String name, this.group, this.dir)
      : super(serial, name);

  ///
  factory SfpSensorParam.fromMap(Map<String, dynamic> map) {
    return SfpSensorParam(
      map['serial'],
      map['name'],
      map['group'],
      map['dir'],
    );
  }

  ///
  factory SfpSensorParam.fromJson(String source) =>
      SfpSensorParam.fromMap(json.decode(source));

  @override
  String toString() =>
      'SfpSensorParam(serial: $serial, name: $name, group: $group, dir: $dir)';
}
