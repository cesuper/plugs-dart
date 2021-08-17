import 'dart:convert';

class SmpSensorData {
  // status of the sensor data, where -1 = DISABLED, 0 = OK, 1 = ERROR
  final int status;

  // serial number of the sensor
  final String serial;

  // name
  final String name;

  // group
  final String group;

  // index
  final int index;

  // cavity
  final int cavity;

  // position
  final int position;

  // hrn
  final int hrn;

  // value
  final double p;

  SmpSensorData(
    this.status,
    this.serial,
    this.name,
    this.group,
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
      'group': group,
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
      map['group'],
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
