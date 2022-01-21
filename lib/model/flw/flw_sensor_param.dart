part of plugs;

class FlwSensorParam {
  final String serial;

  final String name;

  final String group;

  final String dir;

  FlwSensorParam(this.serial, this.name, this.group, this.dir);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'name': name,
      'group': group,
      'dir': dir,
    };
  }

  factory FlwSensorParam.fromMap(Map<String, dynamic> map) {
    return FlwSensorParam(
      map['serial'] ?? '',
      map['name'] ?? '',
      map['group'] ?? '',
      map['dir'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSensorParam.fromJson(String source) =>
      FlwSensorParam.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlwSensorParam(serial: $serial, name: $name, group: $group, dir: $dir)';
  }
}
