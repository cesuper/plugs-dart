import 'dart:convert';

import '../ain/ain_snapshot.dart';
import 'scp_ain_sensor_data.dart';

class ScpAinSnapshot extends AinSnapshot {
  //
  final List<ScpAinSensorData> sensors;

  ScpAinSnapshot(int ts, String plug, this.sensors) : super(ts, plug);

  ///
  factory ScpAinSnapshot.fromMap(Map<String, dynamic> map) {
    return ScpAinSnapshot(
      map['ts'],
      map['plug'],
      List<ScpAinSensorData>.from(
          map['sensors'].map((x) => ScpAinSensorData.fromMap(x))),
    );
  }

  ///
  factory ScpAinSnapshot.fromJson(String source) =>
      ScpAinSnapshot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScpAinSnapshot(ts: $ts, plug: $plug, sensors: $sensors)';
  }
}
