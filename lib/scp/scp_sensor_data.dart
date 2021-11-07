import '../ain/ain_sensor_data.dart';

class ScpSensorData extends AinSensorData {
  ///
  final List<num> value;

  ///
  ScpSensorData(int status, String code, String name, this.value)
      : super(status, code, name);

  ///
  factory ScpSensorData.fromMap(Map<String, dynamic> map) {
    return ScpSensorData(
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
