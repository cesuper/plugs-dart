import 'dart:convert';

import 'SmpSensorDataBuffered.dart';

class SmpBufferedData {
  // timestamp of the trigger event
  final int ts;

  // lsit of buffered sensor data
  final List<SmpDeviceBufferedData> sensors;

  SmpBufferedData(this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory SmpBufferedData.fromMap(Map<String, dynamic> map) {
    return SmpBufferedData(
      map['ts'],
      List<SmpDeviceBufferedData>.from(
          map['sensors']?.map((x) => SmpDeviceBufferedData.fromMap(x))),
    );
  }

  factory SmpBufferedData.fromJson(String source) =>
      SmpBufferedData.fromMap(json.decode(source));
}
