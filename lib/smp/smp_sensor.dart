import 'dart:convert';

import 'package:plugs/ain/ain_sensor_param.dart';

// This class represents the very basic cp sensor model
// with values are needed to get pressure data
class SmpSensor extends AinSensorParam {
  //
  final num area;

  // mold-wise index
  final int index;

  // cavity number
  final int cavity;

  // position in the cavity
  final int position;

  // hot runner nozzle number
  final int hrn;

  SmpSensor(
    String serial,
    String name,
    this.area,
    this.index,
    this.cavity,
    this.position,
    this.hrn,
  ) : super(serial, name);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'area': area,
        'index': index,
        'cavity': cavity,
        'position': position,
        'hrn': hrn,
      });
  }

  factory SmpSensor.fromMap(Map<String, dynamic> map) {
    return SmpSensor(
      map['serial'],
      map['name'],
      map['area'],
      map['index'],
      map['cavity'],
      map['position'],
      map['hrn'],
    );
  }

  factory SmpSensor.fromJson(String source) =>
      SmpSensor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmpSensor(serial: $serial, name: $name, index: $index, cavity: $cavity, position: $position, hrn: $hrn)';
  }
}
