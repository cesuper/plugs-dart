import 'dart:convert';

class FlwSensorCfg {
  // serial
  final String serial;

  FlwSensorCfg(this.serial);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
    };
  }

  factory FlwSensorCfg.fromMap(Map<String, dynamic> map) {
    return FlwSensorCfg(
      map['serial'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSensorCfg.fromJson(String source) =>
      FlwSensorCfg.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSensorCfg(serial: $serial)';
}
