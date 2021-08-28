import 'dart:convert';

class SmpSensor {
  final String serial;

  final double area;

  SmpSensor(this.serial, this.area);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'area': area,
    };
  }

  factory SmpSensor.fromMap(Map<String, dynamic> map) {
    return SmpSensor(
      map['serial'],
      map['area'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSensor.fromJson(String source) =>
      SmpSensor.fromMap(json.decode(source));

  @override
  String toString() => 'SmpChannel(serial: $serial, area: $area)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SmpSensor && other.serial == serial && other.area == area;
  }

  @override
  int get hashCode => serial.hashCode ^ area.hashCode;
}
