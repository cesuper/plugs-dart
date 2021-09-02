import 'dart:convert';

import 'CpData.dart';

class SmpSnapshot {
  final int session;
  final List<String> socket;
  final List<CpData> sensors;

  SmpSnapshot(this.session, this.socket, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'session': session,
      'socket': socket,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SmpSnapshot.fromMap(Map<String, dynamic> map) {
    return SmpSnapshot(
      map['session'],
      List<String>.from(map['socket']),
      List<CpData>.from(map['sensors']?.map((x) => CpData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSnapshot.fromJson(String source) =>
      SmpSnapshot.fromMap(json.decode(source));
}
