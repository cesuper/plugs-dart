import 'dart:convert';

import 'flw_sensor.dart';

class FlwSocketContent {
  //
  final List<FlwSensor> channels;

  FlwSocketContent(this.channels);

  factory FlwSocketContent.fromList(List<dynamic> list) {
    return FlwSocketContent(
        List<FlwSensor>.from(list.map((e) => FlwSensor.fromMap(e))).toList());
  }

  String toJson() => json.encode(channels.map((x) => x.toMap()).toList());

  factory FlwSocketContent.fromJson(String source) =>
      FlwSocketContent.fromList(json.decode(source));
}
