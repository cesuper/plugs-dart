import 'dart:convert';

// This class represents the very basic flw sensor model
// with values are needed to get data
class FlwSensor {
  // serial
  final String serial;

  FlwSensor(this.serial);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
    };
  }

  factory FlwSensor.fromMap(Map<String, dynamic> map) {
    return FlwSensor(
      map['serial'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSensor.fromJson(String source) =>
      FlwSensor.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSensorg(serial: $serial)';
}
