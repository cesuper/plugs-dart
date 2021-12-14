import 'dart:convert';

class Software {
  // major
  final int major;

  // minro
  final int minor;

  // fix
  final int fix;

  // release
  final String release;

  // build
  final String build;

  const Software(this.major, this.minor, this.fix, this.release, this.build);

  Map<String, dynamic> toMap() {
    return {
      'major': major,
      'minor': minor,
      'fix': fix,
      'release': release,
      'build': build,
    };
  }

  factory Software.fromMap(Map<String, dynamic> map) {
    return Software(
      map['major'],
      map['minor'],
      map['fix'],
      map['release'],
      map['build'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Software.fromJson(String source) =>
      Software.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Firmware(major: $major, minor: $minor, fix: $fix, release: $release, build: $build)';
  }
}
