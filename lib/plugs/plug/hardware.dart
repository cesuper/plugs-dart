import 'dart:convert';

class Hardware {
  // product name numerical value name <-> code
  final int code;

  // device family like: sfp, smp, etc
  final String family;

  // device model like: 9,32
  final String model;

  // device revision like: r1, r2,
  final String rev;

  // device serial number
  final int sn;

  // device serial combined from family, model, rev and sn
  final String serial;

  // device mac address
  final String mac;

  Hardware(
    this.code,
    this.family,
    this.model,
    this.rev,
    this.sn,
    this.serial,
    this.mac,
  );

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'family': family,
      'model': model,
      'rev': rev,
      'sn': sn,
      'serial': serial,
      'mac': mac,
    };
  }

  factory Hardware.fromMap(Map<String, dynamic> map) {
    return Hardware(
      map['code'],
      map['family'],
      map['model'],
      map['rev'],
      map['sn'],
      map['serial'],
      map['mac'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Hardware.fromJson(String source) =>
      Hardware.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hardware(code: $code, family: $family, model: $model, rev: $rev, sn: $sn, serial: $serial, mac: $mac)';
  }
}
