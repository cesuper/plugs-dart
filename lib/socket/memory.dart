import 'dart:convert';

import 'header.dart';

class Memory {
  ///
  final String address;

  ///
  final int total;

  //
  final int free;

  //
  final Header header;

  // content
  dynamic jContent;

  Memory(this.address, this.total, this.free, this.header, {this.jContent});

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'total': total,
      'free': free,
      'header': header.toMap(),
      'jContent': jContent,
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      map['address'] ?? '',
      map['total']?.toInt() ?? 0,
      map['free']?.toInt() ?? 0,
      Header.fromMap(map['header']),
      jContent: map['jContent'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Memory.fromJson(String source) => Memory.fromMap(json.decode(source));
}
