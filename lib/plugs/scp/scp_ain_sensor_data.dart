import 'package:plugs/plugs/ain/ain_sensor_data.dart';

class ScpAinSensorData extends AinSensorData {
  ///
  final List<num> value;

  ///
  ScpAinSensorData(
      String plug, int status, String code, String name, this.value)
      : super(plug, status, code, name);

  ///
  factory ScpAinSensorData.fromMap(Map<String, dynamic> map) {
    return ScpAinSensorData(
      map['plug'],
      map['status'],
      map['serial'],
      map['name'],
      List<num>.from(map['value']),
    );
  }

  @override
  String toString() =>
      'ScpSensorData(serial: $serial, name: $name, value: $value)';
}
