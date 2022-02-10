part of plugs;

class FlwSensorState extends SensorState {
  ///
  final String group;

  ///
  final String dir;

  /// Flowrate value in l/min
  final num flowrate;

  /// Temperature value in Celsius
  final num temperature;

  /// Pressure value in Bar
  final num pressure;

  ///
  FlwSensorState(
    String plug,
    String serial,
    String name,
    int status,
    this.group,
    this.dir,
    this.flowrate,
    this.temperature,
    this.pressure,
  ) : super(plug, serial, name, status);

  Map<String, dynamic> toMap() {
    return {
      'plug': plug,
      'serial': serial,
      'name': name,
      'status': status,
      'group': group,
      'dir': dir,
      'flowrate': flowrate,
      'temperature': temperature,
      'pressure': pressure,
    };
  }

  factory FlwSensorState.fromMap(Map<String, dynamic> map) {
    return FlwSensorState(
      map['plug'] ?? '',
      map['serial'] ?? '',
      map['name'] ?? '',
      map['status'] ?? 0,
      map['group'] ?? '',
      map['dir'] ?? '',
      map['flowrate'] ?? 0,
      map['temperature'] ?? 0,
      map['pressure'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSensorState.fromJson(String source) =>
      FlwSensorState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlwSensorState(serial: $serial, name: $name, status: $status, group: $group, dir: $dir, flowrate: $flowrate, temperature: $temperature, pressure: $pressure)';
  }
}
