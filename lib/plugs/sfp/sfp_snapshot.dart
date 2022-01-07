import 'dart:convert';

import '../ain/ain_snapshot.dart';
import 'sfp_sensor_data.dart';

class SfpSnapshot extends AinSnapshot {
  //
  List<SfpSensorData> sensors;

  ///
  SfpSnapshot(int ts, this.sensors) : super(ts);

  ///
  factory SfpSnapshot.fromMap(Map<String, dynamic> map) {
    return SfpSnapshot(
      map['ts'],
      List<SfpSensorData>.from(
          map['sensors'].map((x) => SfpSensorData.fromMap(x))),
    );
  }

  ///
  factory SfpSnapshot.fromJson(String source) =>
      SfpSnapshot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SfpSnapshot(ts: $ts, sensors: $sensors)';
  }
}
