import 'dart:convert';

import 'package:plugs/socket/memory.dart';

class Socket {
  //
  final List<String> addresses;

  //
  Memory? memory;

  Socket(this.addresses, {this.memory});

  Map<String, dynamic> toMap() {
    return {
      'addresses': addresses,
      'memory': memory?.toMap(),
    };
  }

  factory Socket.fromMap(Map<String, dynamic> map) {
    return Socket(
      List<String>.from(map['addresses']),
      memory: map['memory'] != null ? Memory.fromMap(map['memory']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Socket.fromJson(String source) => Socket.fromMap(json.decode(source));

  @override
  String toString() => 'Socket(addresses: $addresses, memory: $memory)';
}
