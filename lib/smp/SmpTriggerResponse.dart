import 'dart:convert';

import 'CpDataBuffered.dart';

class SmpTriggerResponse {
  //
  final int session;

  // timestamp of the trigger event
  final int ts;

  // lsit of buffered sensor data
  final List<CpDataBuffered> sensors;

  SmpTriggerResponse.empty(int noSensors)
      : this(
            0,
            0,
            List.generate(
              noSensors,
              (index) => CpDataBuffered(-1, '', 0.0, <double>[]),
            ));

  SmpTriggerResponse(this.session, this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'session': session,
      'ts': ts,
      'sensors': sensors.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory SmpTriggerResponse.fromMap(Map<String, dynamic> map) {
    return SmpTriggerResponse(
      map['session'],
      map['ts'],
      List<CpDataBuffered>.from(
          map['sensors']?.map((x) => CpDataBuffered.fromMap(x))),
    );
  }

  factory SmpTriggerResponse.fromJson(String source) =>
      SmpTriggerResponse.fromMap(json.decode(source));
}
