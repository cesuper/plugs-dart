import 'dart:convert';

class CpSensorData {
  //
  final int status;

  //
  final String serial;

  //
  final double value;

  //
  final String name;

  // mold-wise index
  final int index;

  // cavity number
  final int cavity;

  // position in the cavity
  final int position;

  // hot runner nozzle number
  final int hrn;

  CpSensorData(this.status, this.serial, this.value, this.name, this.index,
      this.cavity, this.position, this.hrn);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'value': value,
      'name': name,
      'index': index,
      'cavity': cavity,
      'position': position,
      'hrn': hrn,
    };
  }

  factory CpSensorData.fromMap(Map<String, dynamic> map) {
    return CpSensorData(
      map['status'],
      map['serial'],
      map['value'],
      map['name'] ?? '',
      map['index'] ?? 0,
      map['cavity'] ?? 0,
      map['position'] ?? 0,
      map['hrn'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSensorData.fromJson(String source) =>
      CpSensorData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CpSensorData(status: $status, serial: $serial, value: $value, name: $name, index: $index, cavity: $cavity, position: $position, hrn: $hrn)';
  }
}
