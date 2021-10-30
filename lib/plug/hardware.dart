import 'dart:convert';

class Hardware {
  // mac
  final String mac;

  // product name numerical value name <-> code
  final int code;

  //
  final String model;

  // serial number: serial = ['name' + '-' + 'num']
  final String serial;

  // product revision value
  final String rev;

  Hardware(
    this.mac,
    this.code,
    this.model,
    this.serial,
    this.rev,
  );

  Map<String, dynamic> toMap() {
    return {
      'mac': mac,
      'code': code,
      'model': model,
      'serial': serial,
      'rev': rev,
    };
  }

  factory Hardware.fromMap(Map<String, dynamic> map) {
    return Hardware(
      map['mac'],
      map['code'],
      map['model'],
      map['serial'],
      map['rev'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Hardware.fromJson(String source) =>
      Hardware.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hardware(mac: $mac, code: $code, model: $model, serial: $serial, rev: $rev)';
  }
}
