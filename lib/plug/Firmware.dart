import 'dart:convert';

class Firmware {
  // major
  final int major;

  // minro
  final int minor;

  // fix
  final int fix;

  // build
  final String build;

  const Firmware(this.major, this.minor, this.fix, this.build);

  Map<String, dynamic> toMap() {
    return {
      'major': major,
      'minor': minor,
      'fix': fix,
      'build': build,
    };
  }

  factory Firmware.fromMap(Map<String, dynamic> map) {
    return Firmware(map['major'], map['minor'], map['fix'], map['build']);
  }

  String toJson() => json.encode(toMap());

  factory Firmware.fromJson(String source) =>
      Firmware.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Firmware(major: $major, minor: $minor, fix: $fix, build: $build)';
  }
}
