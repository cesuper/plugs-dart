import 'dart:convert';

import '../ain/ain_snapshot.dart';
import 'smp_sensor_data.dart';

class SmpSnapshot extends AinSnapshot {
  //
  final List<SmpSensorData> sensors;

  SmpSnapshot(int ts, this.sensors) : super(ts);

  ///
  factory SmpSnapshot.fromMap(Map<String, dynamic> map) {
    return SmpSnapshot(
      map['ts'],
      List<SmpSensorData>.from(
          map['sensors']._map((x) => SmpSensorData.fromMap(x))),
    );
  }

  ///
  factory SmpSnapshot.fromJson(String source) =>
      SmpSnapshot.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmpSnapshot(ts: $ts, sensors: $sensors)';
  }
}
