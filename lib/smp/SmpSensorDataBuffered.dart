import 'dart:convert';

class SmpSensorBufferedData {
  final int status;

  final String serial;

  final String name;

  // index
  final int index;

  // cavity
  final int cavity;

  // position
  final int position;

  // hrn
  final int hrn;

  // pressure curve
  final List<double> p;

  // curve peak point
  final double max;

  // curve integral value
  final double integral;

  // curve tFill value
  final double tFill;

  SmpSensorBufferedData(
    this.status,
    this.serial,
    this.name,
    this.index,
    this.cavity,
    this.position,
    this.hrn,
    this.p,
    this.max,
    this.integral,
    this.tFill,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'name': name,
      'index': index,
      'cavity': cavity,
      'position': position,
      'hrn': hrn,
      'p': p,
      'max': max,
      'int': integral,
      'tFill': tFill,
    };
  }

  factory SmpSensorBufferedData.fromMap(Map<String, dynamic> map) {
    return SmpSensorBufferedData(
      map['status'],
      map['serial'],
      map['name'],
      map['index'],
      map['cavity'],
      map['position'],
      map['hrn'],
      List<double>.from(map['p']),
      map['max'],
      map['int'],
      map['tFill'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSensorBufferedData.fromJson(String source) =>
      SmpSensorBufferedData.fromMap(json.decode(source));
}
