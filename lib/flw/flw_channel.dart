import 'dart:convert';

import 'package:plugs/flw/flw_sensor.dart';

///
/// This class represents the model to be saved into the socket
///
class FlwChannel extends FlwSensor {
  //
  final String name;

  //
  FlwChannel(String serial, this.name) : super(serial);

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..addAll({'name': name});
  }

  factory FlwChannel.fromMap(Map<String, dynamic> map) {
    return FlwChannel(
      map['serial'],
      map['name'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory FlwChannel.fromJson(String source) =>
      FlwChannel.fromMap(json.decode(source));

  @override
  String toString() => 'FlwChannel(name: $name)';
}
