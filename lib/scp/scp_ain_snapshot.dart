import 'dart:convert';

import '../ain/ain_sensor_data.dart';
import '../ain/ain_snapshot.dart';
import 'scp_ain_sensor_data.dart';

class ScpAinSnapshot extends AinSnapshot {
  ScpAinSnapshot(int ts, List<AinSensorData> sensors) : super(ts, sensors);

  ///
  factory ScpAinSnapshot.fromMap(Map<String, dynamic> map) {
    return ScpAinSnapshot(
      map['ts'],
      List<ScpAinSensorData>.from(
          map['sensors'].map((x) => ScpAinSensorData.fromMap(x))),
    );
  }

  ///
  factory ScpAinSnapshot.fromJson(String source) =>
      ScpAinSnapshot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScpAinSnapshot(ts: $ts, sensors: $sensors)';
  }
}
