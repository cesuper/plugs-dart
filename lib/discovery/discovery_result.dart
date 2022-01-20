import 'dart:convert';

class DiscoveryResult {
  final String address;

  final int code;

  final String serial;

  final String mac;

  final String fw;

  final String family;

  final String model;

  final int rev;

  DiscoveryResult(
    this.address,
    this.code,
    this.serial,
    this.mac,
    this.fw,
    this.family,
    this.model,
    this.rev,
  );

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'code': code,
      'serial': serial,
      'mac': mac,
      'fw': fw,
      'family': family,
      'model': model,
      'rev': rev,
    };
  }

  factory DiscoveryResult.fromMap(Map<String, dynamic> map) {
    return DiscoveryResult(
      map['address'] ?? '',
      map['code']?.toInt() ?? 0,
      map['serial'] ?? '',
      map['mac'] ?? '',
      map['fw'] ?? '',
      map['family'] ?? '',
      map['model'] ?? '',
      map['rev'] ?? 0,
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
