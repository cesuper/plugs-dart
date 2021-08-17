import 'dart:convert';

import 'SmpSensorCfg.dart';

class SmpCfg {
  // list of sensors
  final List<SmpSensorCfg> sensors;

  SmpCfg(this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SmpCfg.fromMap(Map<String, dynamic> map) {
    return SmpCfg(
      List<SmpSensorCfg>.from(
          map['sensors']?.map((x) => SmpSensorCfg.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpCfg.fromJson(String source) => SmpCfg.fromMap(json.decode(source));
}
