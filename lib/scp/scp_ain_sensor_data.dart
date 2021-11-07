import '../ain/ain_sensor_data.dart';

class ScpAinSensorData extends AinSensorData {
  ///
  final List<num> value;

  ///
  ScpAinSensorData(int status, String code, String name, this.value)
      : super(status, code, name);

  ///
  factory ScpAinSensorData.fromMap(Map<String, dynamic> map) {
    return ScpAinSensorData(
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
