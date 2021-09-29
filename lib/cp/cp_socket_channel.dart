import 'dart:convert';

import 'cp_sensor.dart';

/// This class represents the model to be saved into the socket
///
class CpSocketChannel extends CpSensor {
  // channel name
  final String name;

  // mold-wise index
  final int index;

  // cavity number
  final int cavity;

  // position in the cavity
  final int position;

  // hot runner nozzle number
  final int hrn;

  CpSocketChannel(
    String serial,
    double area, {
    this.name = '',
    this.index = 0,
    this.cavity = 0,
    this.position = 0,
    this.hrn = 0,
  }) : super(serial, area);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll({
        'name': name,
        'index': index,
        'cavity': cavity,
        'position': position,
        'hrn': hrn,
      });
  }

  factory CpSocketChannel.fromMap(Map<String, dynamic> map) {
    return CpSocketChannel(
      map['serial'],
      double.parse(map['area'].toString()),
      name: map['name'],
      index: map['index'],
      cavity: map['cavity'],
      position: map['position'],
      hrn: map['hrn'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory CpSocketChannel.fromJson(String source) =>
      CpSocketChannel.fromMap(json.decode(source));
}
