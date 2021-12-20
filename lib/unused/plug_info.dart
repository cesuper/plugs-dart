import 'dart:convert';

class PlugInfo {
  //
  final String ip;

  //
  final String mac;

  //
  final String serial;

  //
  final String fw;

  //
  final String release;

  //
  final String build;

  PlugInfo(this.ip, this.mac, this.serial, this.fw, this.release, this.build);

  Map<String, dynamic> toMap() {
    return {
      'ip': ip,
      'mac': mac,
      'serial': serial,
      'fw': fw,
      'release': release,
      'build': build,
    };
  }

  factory PlugInfo.fromMap(Map<String, dynamic> map) {
    return PlugInfo(
      map['ip'] ?? '',
      map['mac'] ?? '',
      map['serial'] ?? '',
      map['fw'] ?? '',
      map['release'] ?? '',
      map['build'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlugInfo.fromJson(String source) =>
      PlugInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DeviceInfo(ip: $ip, mac: $mac, serial: $serial, fw: $fw, release: $release, build: $build)';
  }
}
