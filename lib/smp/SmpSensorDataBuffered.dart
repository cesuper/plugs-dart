import 'dart:convert';

class SmpSensorDataBuffered {
  // status of the sensor data, where -1 = DISABLED, 0 = OK, 1 = ERROR
  final int status;

  // identify value
  final String serial;

  // pressure curve
  final List<double> p;

  SmpSensorDataBuffered(
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

  factory SmpSensorDataBuffered.fromMap(Map<String, dynamic> map) {
    return SmpSensorDataBuffered(
      map['status'],
      map['serial'],
      List<double>.from(map['p']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSensorDataBuffered.fromJson(String source) =>
      SmpSensorDataBuffered.fromMap(json.decode(source));
}
