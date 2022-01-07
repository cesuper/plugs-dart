import '../ain/ain_sensor_data.dart';

class SfpSensorData extends AinSensorData {
  ///
  final String group;

  ///
  final String dir;

  /// Flowrate value in l/min
  final num v;

  /// Temperature value in Celsius
  final num t;

  /// Pressure value in Bar
  final num p;

  ///
  SfpSensorData(
    String plug,
    int status,
    String serial,
    String name,
    this.group,
    this.dir,
    this.v,
    this.t,
    this.p,
  ) : super(plug, status, serial, name);

  ///
  factory SfpSensorData.fromMap(Map<String, dynamic> map) {
    return SfpSensorData(
      map['plug'],
      map['status'],
      map['serial'],
      map['name'],
      map['group'],
      map['dir'],
      map['v'],
      map['t'],
      map['p'],
    );
  }

  @override
  String toString() {
    return 'SfpSensorData(group: $group, dir: $dir, v: $v, t: $t, p: $p)';
  }
}
