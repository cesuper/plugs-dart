import 'dart:convert';

abstract class AinSensor {
  /// Indentifies the sensor serial number
  final String serial;

  /// Sensor name
  final String name;

  ///
  AinSensor(this.serial, this.name);

  ///
  @override
  String toString();

  ///
  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'name': name,
    };
  }

  ///
  String toJson() => json.encode(toMap());

  ///
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AinSensor && other.serial == serial;
  }

  ///
  @override
  int get hashCode => serial.hashCode ^ name.hashCode;
}
