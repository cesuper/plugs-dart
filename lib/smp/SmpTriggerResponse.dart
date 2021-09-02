import 'dart:convert';

import 'CpDataBuffered.dart';

class SmpTriggerResponse {
  // timestamp of the trigger event
  final int ts;

  // lsit of buffered sensor data
  final List<CpDataBuffered> sensors;

  SmpTriggerResponse.empty(int noSensors)
      : this(
            0,
            List.generate(
              noSensors,
              (index) => CpDataBuffered(-1, '', <double>[]),
            ));

  SmpTriggerResponse(this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory SmpTriggerResponse.fromMap(Map<String, dynamic> map) {
    return SmpTriggerResponse(
      map['ts'],
      List<CpDataBuffered>.from(
          map['sensors']?.map((x) => CpDataBuffered.fromMap(x))),
    );
  }

  factory SmpTriggerResponse.fromJson(String source) =>
      SmpTriggerResponse.fromMap(json.decode(source));
}
