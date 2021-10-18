import 'dart:convert';

class CpSensorData {
  //
  final int status;

  //
  final String serial;

  //
  final List<double> value;

  //
  final String name;

  CpSensorData(this.status, this.serial, this.value, this.name);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'value': value,
      'name': name,
    };
  }

  factory CpSensorData.fromMap(Map<String, dynamic> map) {
    return CpSensorData(
      map['status'],
      map['serial'],
      List<double>.from(map['value']),
      map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSensorData.fromJson(String source) =>
      CpSensorData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CpSensorData(status: $status, serial: $serial, value: $value, name: $name)';
  }
}
