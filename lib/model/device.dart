part of plugs;

class Device {
  //
  final Plug plug;

  //
  final Socket socket;

  Device(this.plug, this.socket);

  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
    };
  }

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      Plug.fromMap(map['plug']),
      Socket.fromMap(map['socket']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Device.fromJson(String source) => Device.fromMap(json.decode(source));

  @override
  String toString() => 'Device(plug: $plug, socket: $socket)';
}
