import 'dart:convert';

class SmpSensorCfg {
  // enables or disables to use sensor
  bool enabled;

  // sensor serial
  String serial;

  // ejector pin diameter
  double area;

  SmpSensorCfg.disabled(int index) : this(false, '', 1.0);

  SmpSensorCfg(
    this.enabled,
    this.serial,
    this.area,
  );

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'serial': serial,
      'area': area,
    };
  }

  factory SmpSensorCfg.fromMap(Map<String, dynamic> map) {
    return SmpSensorCfg(
      map['enabled'],
      map['serial'],
      map['area'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSensorCfg.fromJson(String source) =>
      SmpSensorCfg.fromMap(json.decode(source));
}
