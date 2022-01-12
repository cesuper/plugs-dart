import 'dart:convert';

import '../ain/ain_snapshot.dart';
import 'sfp_sensor_data.dart';

class SfpSnapshot extends AinSnapshot {
  //
  List<SfpSensorData> sensors;

  ///
  SfpSnapshot(int ts, this.sensors) : super(ts);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SfpSnapshot.fromMap(Map<String, dynamic> map) {
    return SfpSnapshot(
      map['ts'],
      List<SfpSensorData>.from(
          map['sensors']._map((x) => SfpSensorData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SfpSnapshot.fromJson(String source) =>
      SfpSnapshot.fromMap(json.decode(source));
}
