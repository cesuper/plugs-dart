import 'dart:convert';

class SmpSensorData {
  // status of the sensor data, where -1 = DISABLED, 0 = OK, 1 = ERROR
  final int status;

  // identify the value with serial
  final String serial;

  // value
  final double p;

  SmpSensorData(
    this.status,
    this.serial,
    this.p,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'p': p,
    };
  }

  factory SmpSensorData.fromMap(Map<String, dynamic> map) {
    return SmpSensorData(
      map['status'],
      map['serial'],
      map['p'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSensorData.fromJson(String source) =>
      SmpSensorData.fromMap(json.decode(source));
}
