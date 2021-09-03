import 'dart:convert';

import 'CpSensor.dart';

class SmpSamplingRequest {
  // request id
  final int ts;

  // sampling freq
  final int freq;

  // sampling time
  final int time;

  // sensors to sample
  final List<CpSensor> sensors;

  SmpSamplingRequest(this.ts, this.freq, this.time, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'freq': freq,
      'time': time,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SmpSamplingRequest.fromMap(Map<String, dynamic> map) {
    return SmpSamplingRequest(
      map['ts'],
      map['freq'],
      map['time'],
      List<CpSensor>.from(map['sensors']?.map((x) => CpSensor.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSamplingRequest.fromJson(String source) =>
      SmpSamplingRequest.fromMap(json.decode(source));
}
