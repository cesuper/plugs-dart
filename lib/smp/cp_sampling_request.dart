import 'dart:convert';

import 'cp_sensor.dart';

class CpSamplingRequest {
  // request id
  final int ts;

  // sampling freq
  final int freq;

  // sampling time
  final int time;

  // sensors to sample
  final List<CpSensor> sensors;

  CpSamplingRequest(this.ts, this.freq, this.time, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'freq': freq,
      'time': time,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory CpSamplingRequest.fromMap(Map<String, dynamic> map) {
    return CpSamplingRequest(
      map['ts'],
      map['freq'],
      map['time'],
      List<CpSensor>.from(map['sensors']?.map((x) => CpSensor.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSamplingRequest.fromJson(String source) =>
      CpSamplingRequest.fromMap(json.decode(source));
}
