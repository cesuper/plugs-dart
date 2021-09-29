import 'dart:convert';

import 'cp_data_buffered.dart';

class CpSamplingResponse {
  // timestamp of the trigger event
  final int ts;

  // error code
  final int error;

  // lsit of buffered sensor data
  final List<CpDataBuffered> sensors;

  CpSamplingResponse(this.ts, this.error, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'error': error,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory CpSamplingResponse.fromMap(Map<String, dynamic> map) {
    return CpSamplingResponse(
      map['ts'],
      map['error'],
      List<CpDataBuffered>.from(
          map['sensors']?.map((x) => CpDataBuffered.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpSamplingResponse.fromJson(String source) =>
      CpSamplingResponse.fromMap(json.decode(source));
}
