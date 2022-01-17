import 'dart:convert';

import 'package:plugs/plugs/plug/info.dart';

class DiscoveryResult extends Info {
  ///
  final String address;

  DiscoveryResult(
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

  factory DiscoveryResult.fromMap(Map<String, dynamic> map) {
    return DiscoveryResult(
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

  factory DiscoveryResult.fromJson(String source) =>
      DiscoveryResult.fromMap(json.decode(source));

  @override
  String toString() =>
      'DiscoveryResult(address: $address, ${super.toString()})';
}
