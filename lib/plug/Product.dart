import 'dart:convert';

class Product {
  // mac
  final String mac;

  // product name numerical value name <-> code
  final int code;

  // product number, number or product created
  final int num;

  // serial number: serial = ['name' + '-' + 'num']
  final String serial;

  // product revision value
  final String rev;

  Product(
    this.mac,
    this.code,
    this.num,
    this.serial,
    this.rev,
  );

  Map<String, dynamic> toMap() {
    return {
      'mac': mac,
      'code': code,
      'num': num,
      'serial': serial,
      'rev': rev,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['mac'],
      map['code'],
      map['num'],
      map['serial'],
      map['rev'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(mac: $mac, code: $code, num: $num, serial: $serial, rev: $rev)';
  }
}
