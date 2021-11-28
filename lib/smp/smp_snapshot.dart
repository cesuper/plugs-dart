import 'dart:convert';

import '../ain/ain_sensor_data.dart';
import '../ain/ain_snapshot.dart';
import 'smp_sensor_data.dart';

class SmpSnapshot extends AinSnapshot {
  SmpSnapshot(int ts, String plug, List<AinSensorData> sensors)
      : super(ts, plug, sensors);

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
