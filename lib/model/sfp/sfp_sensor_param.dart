part of plugs;

class SfpSensorParam {
  final String serial;

  final String name;

  final String group;

  final String dir;

  SfpSensorParam(this.serial, this.name, this.group, this.dir);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'name': name,
      'group': group,
      'dir': dir,
    };
  }

  factory SfpSensorParam.fromMap(Map<String, dynamic> map) {
    return SfpSensorParam(
      map['serial'] ?? '',
      map['name'] ?? '',
      map['group'] ?? '',
      map['dir'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SfpSensorParam.fromJson(String source) =>
      SfpSensorParam.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SfpSensorParam(serial: $serial, name: $name, group: $group, dir: $dir)';
  }
}
