import 'dart:convert';

import 'CpDataBuffered.dart';

class SmpSamplingResponse {
  // timestamp of the trigger event
  final int ts;

  // error code
  final int error;

  // lsit of buffered sensor data
  final List<CpDataBuffered> sensors;

  SmpSamplingResponse(this.ts, this.error, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'error': error,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SmpSamplingResponse.fromMap(Map<String, dynamic> map) {
    return SmpSamplingResponse(
      map['ts'],
      map['error'],
      List<CpDataBuffered>.from(
          map['sensors']?.map((x) => CpDataBuffered.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSamplingResponse.fromJson(String source) =>
      SmpSamplingResponse.fromMap(json.decode(source));
}
