import 'dart:convert';

class Hardware {
  // product name numerical value name <-> code
  final int code;

  //
  final String family;

  //
  final String model;

  //
  final String rev;

  //
  final String serial;

  // mac
  final String mac;

  Hardware(
    this.code,
    this.family,
    this.model,
    this.rev,
    this.serial,
    this.mac,
  );

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'family': family,
      'model': model,
      'rev': rev,
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
      map['serial'],
      map['mac'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Hardware.fromJson(String source) =>
      Hardware.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hardware(code: $code, family: $family, model: $model, rev: $rev, serial: $serial, mac: $mac)';
  }
}
