import 'dart:convert';

class SmpSensorData {
  // status of the sensor data, where -1 = DISABLED, 0 = OK, 1 = ERROR
  final int status;

  // serial number of the sensor
  final String serial;

  // name
  final String name;

  // index
  final int index;

  // cavity aka. 'group'
  final int cavity;

  // position, aka. 'index'
  final int position;

  // hrn
  final int hrn;

  // value
  final double p;

  SmpSensorData(
    this.status,
    this.serial,
    this.name,
    this.index,
    this.cavity,
    this.position,
    this.hrn,
    this.p,
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
    };
  }

  factory SmpSensorData.fromMap(Map<String, dynamic> map) {
    return SmpSensorData(
      map['status'],
      map['serial'],
      map['name'],
      map['index'],
      map['cavity'],
      map['position'],
      map['hrn'],
      map['p'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSensorData.fromJson(String source) =>
      SmpSensorData.fromMap(json.decode(source));
}
