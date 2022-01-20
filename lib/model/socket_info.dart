import 'dart:convert';

import 'package:plugs/socket/memory.dart';

class SocketInfo {
  //
  final List<String> addresses;

  //
  Memory? memory;

  SocketInfo(this.addresses, {this.memory});

  Map<String, dynamic> toMap() {
    return {
      'addresses': addresses,
      'memory': memory?.toMap(),
    };
  }

  factory SocketInfo.fromMap(Map<String, dynamic> map) {
    return SocketInfo(
      List<String>.from(map['addresses']),
      memory: map['memory'] != null ? Memory.fromMap(map['memory']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketInfo.fromJson(String source) =>
      SocketInfo.fromMap(json.decode(source));

  @override
  String toString() => 'Socket(addresses: $addresses, memory: $memory)';
}
