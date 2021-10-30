import 'dart:convert';

import 'hardware.dart';
import 'network.dart';
import 'software.dart';

class Info {
  // product
  final Hardware hardware;

  // firmware
  final Software software;

  // network
  final Network network;

  Info(
    this.hardware,
    this.software,
    this.network,
  );

  Map<String, dynamic> toMap() {
    return {
      'hardware': hardware.toMap(),
      'software': software.toMap(),
      'network': network.toMap(),
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      Hardware.fromMap(map['hardware']),
      Software.fromMap(map['software']),
      Network.fromMap(map['network']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source));

  @override
  String toString() =>
      'Info(hardware: $hardware, software: $software, network: $network)';
}
