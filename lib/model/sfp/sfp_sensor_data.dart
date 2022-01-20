part of plugs;

class SfpSensorData {
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
  final num v;

  /// Temperature value in Celsius
  final num t;

  /// Pressure value in Bar
  final num p;

  ///
  SfpSensorData(
    this.plug,
    this.status,
    this.serial,
    this.name,
    this.group,
    this.dir,
    this.v,
    this.t,
    this.p,
  );

  Map<String, dynamic> toMap() {
    return {
      'plug': plug,
      'status': status,
      'serial': serial,
      'name': name,
      'group': group,
      'dir': dir,
      'v': v,
      't': t,
      'p': p,
    };
  }

  factory SfpSensorData.fromMap(Map<String, dynamic> map) {
    return SfpSensorData(
      map['plug'] ?? '',
      map['status']?.toInt() ?? 0,
      map['serial'] ?? '',
      map['name'] ?? '',
      map['group'] ?? '',
      map['dir'] ?? '',
      map['v'] ?? 0,
      map['t'] ?? 0,
      map['p'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SfpSensorData.fromJson(String source) =>
      SfpSensorData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SfpSensorData(plug: $plug, status: $status, serial: $serial, name: $name, group: $group, dir: $dir, v: $v, t: $t, p: $p)';
  }
}
