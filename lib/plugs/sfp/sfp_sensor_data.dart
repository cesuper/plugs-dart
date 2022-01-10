import 'dart:convert';

import '../ain/ain_sensor_data.dart';

class SfpSensorData extends AinSensorData {
  ///
  final String group;

  ///
  final String dir;

  /// Flowrate value in l/min
  final num v;

  /// Temperature value in Celsius
  final num t;

  /// Pressure value in Bar
  final num p;

  ///
  SfpSensorData(
    String plug,
    int status,
    String serial,
    String name,
    this.group,
    this.dir,
    this.v,
    this.t,
    this.p,
  ) : super(plug, status, serial, name);

  @override
  String toString() {
    return 'SfpSensorData(plug: $plug, serial: $serial, name: $name, group: $group, dir: $dir, p: $p, t: $t, v: $v)';
  }

  Map<String, dynamic> toMap() {
    return {
      'plug': plug,
      'status': status,
      'serial': serial,
      'name': name,
      'group': group,
      'dir': dir,
      'v': v,
      't': t,
      'p': p,
    };
  }

  ///
  factory SfpSensorData.fromMap(Map<String, dynamic> map) {
    return SfpSensorData(
      map['plug'],
      map['status'],
      map['serial'],
      map['name'],
      map['group'],
      map['dir'],
      map['v'],
      map['t'],
      map['p'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SfpSensorData.fromJson(String source) =>
      SfpSensorData.fromMap(json.decode(source));
}
