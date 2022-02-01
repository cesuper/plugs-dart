part of plugs;

class FlwSensorState {
  /// plug serial number from where the adata is originated
  final String plug;

  /// Status of the sensor from measurement point of view
  final int status;

  /// Sensor serial number
  final String serial;

  /// Sensor name
  final String name;

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
    this.plug,
    this.status,
    this.serial,
    this.name,
    this.group,
    this.dir,
    this.flowrate,
    this.temperature,
    this.pressure,
  );

  Map<String, dynamic> toMap() {
    return {
      'plug': plug,
      'status': status,
      'serial': serial,
      'name': name,
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
      map['status']?.toInt() ?? 0,
      map['serial'] ?? '',
      map['name'] ?? '',
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
    return 'FlwSensorState(plug: $plug, status: $status, serial: $serial, name: $name, group: $group, dir: $dir, flowrate: $flowrate, temperature: $temperature, pressure: $pressure)';
  }
}
