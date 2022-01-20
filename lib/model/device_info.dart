import 'dart:convert';

import 'package:plugs/model/plug_info.dart';
import 'package:plugs/socket/socket.dart';

class DeviceInfo {
  //
  final PlugInfo plug;

  //
  final Socket socket;

  DeviceInfo(this.plug, this.socket);

  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
    };
  }

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      PlugInfo.fromMap(map['plug']),
      Socket.fromMap(map['socket']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInfo.fromJson(String source) =>
      DeviceInfo.fromMap(json.decode(source));

  @override
  String toString() => 'Device(plug: $plug, socket: $socket)';
}
