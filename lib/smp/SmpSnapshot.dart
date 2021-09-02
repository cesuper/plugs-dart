import 'dart:convert';

import 'CpData.dart';

class SmpSnapshot {
  //
  final List<String> socket;

  //
  final List<CpData> sensors;

  SmpSnapshot(this.socket, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'socket': socket,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SmpSnapshot.fromMap(Map<String, dynamic> map) {
    return SmpSnapshot(
      List<String>.from(map['socket']),
      List<CpData>.from(map['sensors']?.map((x) => CpData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSnapshot.fromJson(String source) =>
      SmpSnapshot.fromMap(json.decode(source));

  @override
  String toString() => 'SmpSnapshot(socket: $socket, sensors: $sensors)';
}
