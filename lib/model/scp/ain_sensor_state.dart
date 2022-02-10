part of plugs;

class AinSensorState extends SensorState {
  final num min;

  final num max;

  final num range;

  final List<num> value;

  AinSensorState(
    String serial,
    String name,
    int status,
    this.min,
    this.max,
    this.range,
    this.value,
  ) : super(serial, name, status);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'name': name,
      'status': status,
      'min': min,
      'max': max,
      'range': range,
      'value': value,
    };
  }

  factory AinSensorState.fromMap(Map<String, dynamic> map) {
    return AinSensorState(
      map['serial'] ?? '',
      map['name'] ?? '',
      map['status'] ?? 0,
      map['min'] ?? 0,
      map['max'] ?? 0,
      map['range'] ?? 0,
      List<num>.from(map['value']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AinSensorState.fromJson(String source) =>
      AinSensorState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AinSensorState(serial: $serial, name: $name, status: $status, min: $min, max: $max, range: $range, value: $value)';
  }
}
