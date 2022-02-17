part of plugs;

class ScpAinSensorState extends SensorState {
  final num min;

  final num max;

  final num range;

  final List<num> value;

  ScpAinSensorState(
    String plug,
    String serial,
    String name,
    int status,
    this.min,
    this.max,
    this.range,
    this.value,
  ) : super(plug, serial, name, status);

  Map<String, dynamic> toMap() {
    return {
      'plug': plug,
      'serial': serial,
      'name': name,
      'status': status,
      'min': min,
      'max': max,
      'range': range,
      'value': value,
    };
  }

  factory ScpAinSensorState.fromMap(Map<String, dynamic> map) {
    return ScpAinSensorState(
      map['plug'] ?? '',
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

  factory ScpAinSensorState.fromJson(String source) =>
      ScpAinSensorState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScpAinSensorState(plug: $plug, serial: $serial, name: $name, status: $status, min: $min, max: $max, range: $range, value: $value)';
  }
}
