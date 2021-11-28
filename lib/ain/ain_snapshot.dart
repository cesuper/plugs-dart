import 'ain_sensor_data.dart';

abstract class AinSnapshot {
  // timestamp of the snapshot, when data is created
  final int ts;

  //
  final String plug;

  //
  final List<AinSensorData> sensors;

  //
  AinSnapshot(this.ts, this.plug, this.sensors);

  @override
  String toString() => 'AinSnapshot(ts: $ts, plug:$plug)';
}
