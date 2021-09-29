import 'dart:convert';

// This class represents the very basic cp sensor model
// with values are needed to get pressure data
class CpSensor {
  // sensor code
  final String serial;

  // sensor area in square millimeters
  final double area;

  CpSensor(this.serial, this.area);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'area': area,
    };
  }

  factory CpSensor.fromMap(Map<String, dynamic> map) {
    return CpSensor(
      map['serial'],
      map['area'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSensor.fromJson(String source) =>
      CpSensor.fromMap(json.decode(source));

  @override
  String toString() => 'CpSensor(serial: $serial, area: $area)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CpSensor && other.serial == serial && other.area == area;
  }

  @override
  int get hashCode => serial.hashCode ^ area.hashCode;
}
