import 'ain_sensor_data.dart';

abstract class AinSnapshot {
  // timestamp of the snapshot, when data is created
  final int ts;

  //
  final List<AinSensorData> sensors;

  //
  AinSnapshot(this.ts, this.sensors);

  @override
  String toString() => 'AinSnapshot(ts: $ts)';
}
