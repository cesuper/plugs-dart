import 'dart:convert';

import '../ain/ain_snapshot.dart';
import 'smp_sensor_data.dart';

class SmpSnapshot extends AinSnapshot {
  //
  final List<SmpSensorData> sensors;

  SmpSnapshot(int ts, String plug, this.sensors) : super(ts, plug);

  ///
  factory SmpSnapshot.fromMap(Map<String, dynamic> map) {
    return SmpSnapshot(
      map['ts'],
      map['plug'],
      List<SmpSensorData>.from(
          map['sensors'].map((x) => SmpSensorData.fromMap(x))),
    );
  }

  ///
  factory SmpSnapshot.fromJson(String source) =>
      SmpSnapshot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmpSnapshot(ts: $ts, plug: $plug, sensors: $sensors)';
  }
}
