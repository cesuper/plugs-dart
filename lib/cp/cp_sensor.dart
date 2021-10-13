import 'dart:convert';

// This class represents the very basic cp sensor model
// with values are needed to get pressure data
class CpSensor {
  // sensor code
  final String serial;

  // sensor area in square millimeters
  final double area;

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

  CpSensor(this.serial, this.area, this.name, this.index, this.cavity,
      this.position, this.hrn);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'area': area,
      'name': name,
      'index': index,
      'cavity': cavity,
      'position': position,
      'hrn': hrn,
    };
  }

  factory CpSensor.fromMap(Map<String, dynamic> map) {
    return CpSensor(
      map['serial'],
      double.parse(map['area'].toString()),
      map['name'],
      map['index'],
      map['cavity'],
      map['position'],
      map['hrn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSensor.fromJson(String source) =>
      CpSensor.fromMap(json.decode(source));
}
