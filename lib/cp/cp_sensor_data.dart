import 'dart:convert';

class CpSensorData {
  //
  final int status;

  //
  final String serial;

  //
  final List<double> value;

  CpSensorData(this.status, this.serial, this.value);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'value': value,
    };
  }

  factory CpSensorData.fromMap(Map<String, dynamic> map) {
    return CpSensorData(
      map['status'],
      map['serial'],
      List<double>.from(map['value']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSensorData.fromJson(String source) =>
      CpSensorData.fromMap(json.decode(source));

  @override
  String toString() =>
      'CpSensorData(status: $status, serial: $serial, value: $value)';
}
