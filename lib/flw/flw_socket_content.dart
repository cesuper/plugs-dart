import 'dart:convert';

import 'flw_sensor_param.dart';

class FlwSocketContent {
  //
  final List<FlwSensorParam> sensors;

  FlwSocketContent(this.sensors);

  factory FlwSocketContent.fromList(List<dynamic> list) {
    return FlwSocketContent(
        List<FlwSensorParam>.from(list.map((e) => FlwSensorParam.fromMap(e)))
            .toList());
  }

  String toJson() => json.encode(sensors.map((x) => x.toMap()).toList());

  factory FlwSocketContent.fromJson(String source) =>
      FlwSocketContent.fromList(json.decode(source));

  @override
  String toString() => 'FlwSocketContent(sensors: $sensors)';
}
