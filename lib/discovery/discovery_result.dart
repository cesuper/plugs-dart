import 'dart:convert';

class DiscoveryResult {
  final String address;

  final int code;

  final String serial;

  final String mac;

  final String fw;

  DiscoveryResult(
    this.address,
    this.code,
    this.serial,
    this.mac,
    this.fw,
  );

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'code': code,
      'serial': serial,
      'mac': mac,
      'fw': fw,
    };
  }

  factory DiscoveryResult.fromMap(Map<String, dynamic> map) {
    return DiscoveryResult(
      map['address'] ?? '',
      map['code']?.toInt() ?? 0,
      map['serial'] ?? '',
      map['mac'] ?? '',
      map['fw'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscoveryResult.fromJson(String source) =>
      DiscoveryResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiscoveryResult(address: $address, code: $code, serial: $serial, mac: $mac, fw: $fw)';
  }
}
