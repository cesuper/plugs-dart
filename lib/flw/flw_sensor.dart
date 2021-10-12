import 'dart:convert';

// This class represents the very basic flw sensor model
// with values are needed to get data
class FlwSensor {
  // serial
  final String serial;

  // name
  final String name;

  FlwSensor(this.serial, this.name);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'name': name,
    };
  }

  factory FlwSensor.fromMap(Map<String, dynamic> map) {
    return FlwSensor(
      map['serial'],
      map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSensor.fromJson(String source) =>
      FlwSensor.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSensor(serial: $serial)';
}
