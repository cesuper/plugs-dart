import 'dart:convert';

import 'sfp_sensor_param.dart';

class SfpSocketContent {
  //
  final List<SfpSensorParam> sensors;

  SfpSocketContent(this.sensors);

  factory SfpSocketContent.fromList(List<dynamic> list) {
    return SfpSocketContent(
        List<SfpSensorParam>.from(list.map((e) => SfpSensorParam.fromMap(e)))
            .toList());
  }

  String toJson() => json.encode(sensors.map((x) => x.toMap()).toList());

  factory SfpSocketContent.fromJson(String source) =>
      SfpSocketContent.fromList(json.decode(source));

  @override
  String toString() => 'FlwSocketContent(sensors: $sensors)';
}
