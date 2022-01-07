import 'package:plugs/plugs/ain/ain_sensor_data.dart';

class SmpSensorData extends AinSensorData {
  ///
  final List<num> value;

  ///
  SmpSensorData(String plug, int status, String code, String name, this.value)
      : super(plug, status, code, name);

  ///
  factory SmpSensorData.fromMap(Map<String, dynamic> map) {
    return SmpSensorData(
      map['plug'],
      map['status'],
      map['serial'],
      map['name'],
      List<num>.from(map['value']),
    );
  }

  @override
  String toString() =>
      'SmpSensorData(serial: $serial, name: $name, value: $value)';
}
