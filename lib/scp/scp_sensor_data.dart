import 'dart:convert';

class ScpSensorData {
  //
  final int status;

  //
  final String serial;

  //
  final List<double> value;

  //
  final String name;

  ScpSensorData(this.status, this.serial, this.value, this.name);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'value': value,
      'name': name,
    };
  }

  factory ScpSensorData.fromMap(Map<String, dynamic> map) {
    return ScpSensorData(
      map['status'],
      map['serial'],
      List<double>.from(map['value']),
      map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScpSensorData.fromJson(String source) =>
      ScpSensorData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScpSensorData(status: $status, serial: $serial, value: $value, name: $name)';
  }
}
