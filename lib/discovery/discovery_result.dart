import 'dart:convert';

import 'package:plugs/plugs/plug/info.dart';

class DiscoveryResult {
  // plug ipv4 address
  final String address;

  //
  final Info info;

  DiscoveryResult(this.address, this.info);

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'info': info.toMap(),
    };
  }

  factory DiscoveryResult.fromMap(Map<String, dynamic> map) {
    return DiscoveryResult(
      map['address'] ?? '',
      Info.fromMap(map['info']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DiscoveryResult.fromJson(String source) =>
      DiscoveryResult.fromMap(json.decode(source));
}
