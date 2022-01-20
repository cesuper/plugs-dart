import 'dart:convert';

import 'package:plugs/model/plug.dart';
import 'package:plugs/model/socket_info.dart';

class Device {
  //
  final Plug plug;

  //
  final SocketInfo socket;

  Device(this.plug, this.socket);

  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
    };
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      PlugInfo.fromMap(map['plug']),
      SocketInfo.fromMap(map['socket']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source));

  @override
  String toString() => 'Device(plug: $plug, socket: $socket)';
}
