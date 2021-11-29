import 'dart:convert';

import '../ain/ain_snapshot.dart';
import 'flw_sensor_data.dart';

class FlwSnapshot extends AinSnapshot {
  //
  List<FlwSensorData> sensors;

  ///
  FlwSnapshot(int ts, String plug, this.sensors) : super(ts, plug);

  ///
  factory FlwSnapshot.fromMap(Map<String, dynamic> map) {
    return FlwSnapshot(
      map['ts'],
      map['plug'],
      List<FlwSensorData>.from(
          map['sensors'].map((x) => FlwSensorData.fromMap(x))),
    );
  }

  ///
  factory FlwSnapshot.fromJson(String source) =>
      FlwSnapshot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlwSnapshot(ts: $ts, plug:$plug, sensors: $sensors)';
  }
}
