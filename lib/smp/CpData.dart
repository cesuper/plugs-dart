import 'dart:convert';

class CpData {
  // status of the sensor data, where -1 = DISABLED, 0 = OK, 1 = ERROR
  final int status;

  // identify the value with serial
  final String serial;

  // indentify the area that used for conversion
  final double area;

  // value
  final double p;

  CpData(
    this.status,
    this.serial,
    this.area,
    this.p,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'area': area,
      'p': p,
    };
  }

  factory CpData.fromMap(Map<String, dynamic> map) {
    return CpData(
      map['status'],
      map['serial'],
      map['area'],
      map['p'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CpData.fromJson(String source) => CpData.fromMap(json.decode(source));
}
