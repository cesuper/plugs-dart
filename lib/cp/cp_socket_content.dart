import 'dart:convert';

import 'cp_sensor.dart';

class CpSocketContent {
  //
  final List<CpSensor> channels;

  CpSocketContent(this.channels);

  factory CpSocketContent.fromList(List<dynamic> list) {
    return CpSocketContent(
        List<CpSensor>.from(list.map((e) => CpSensor.fromMap(e))).toList());
  }

  String toJson() => json.encode(channels.map((x) => x.toMap()).toList());

  factory CpSocketContent.fromJson(String source) =>
      CpSocketContent.fromList(json.decode(source));
}
