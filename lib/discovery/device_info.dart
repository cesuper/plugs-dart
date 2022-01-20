import 'dart:convert';

import 'package:plugs/model/info.dart';

class DeviceInfo extends Info {
  ///
  final String address;

  DeviceInfo(
    this.address,
    int code,
    String serial,
    String mac,
    String fw,
    String build,
  ) : super(code, serial, mac, fw, build);

  @override
  Map<String, dynamic> toMap() {
    return {
      'address': address,
    }..addAll(super.toMap());
  }

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      map['address'] ?? '',
      map['code']?.toInt() ?? 0,
      map['serial'] ?? '',
      map['mac'] ?? '',
      map['fw'] ?? '',
      map['build'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory DeviceInfo.fromJson(String source) =>
      DeviceInfo.fromMap(json.decode(source));

  @override
  String toString() => 'DeviceInfo(address: $address, ${super.toString()})';
}
