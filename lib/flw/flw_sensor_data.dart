import '../ain/ain_sensor_data.dart';

class FlwSensorData extends AinSensorData {
  /// Flowrate value in l/min
  final num v;

  /// Temperature value in Celsius
  final num t;

  /// Pressure value in Bar
  final num p;

  ///
  FlwSensorData(
    int status,
    String serial,
    String name,
    this.v,
    this.t,
    this.p,
  ) : super(status, serial, name);

  ///
  factory FlwSensorData.fromMap(Map<String, dynamic> map) {
    return FlwSensorData(
      map['status'],
      map['serial'],
      map['name'],
      map['v'],
      map['t'],
      map['p'],
    );
  }

  @override
  String toString() =>
      'FlwSensorData(serial: $serial, name: $name, v: $v, t:$t, p:$p)';
}
