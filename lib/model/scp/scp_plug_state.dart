part of plugs;

class ScpPlugState extends PlugState {
  final ScpDio dio;
  final ScpAinState ain;

  ScpPlugState(Plug plug, Socket socket, this.dio, this.ain)
      : super(plug, socket);

  @override
  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
      'dio': dio.toMap(),
      'ain': ain.toMap(),
    };
  }

  factory ScpPlugState.fromMap(Map<String, dynamic> map) {
    return ScpPlugState(
      Plug.fromMap(map['plug']),
      Socket.fromMap(map['socket']),
      ScpDio.fromMap(map['dio']),
      ScpAinState.fromMap(map['ain']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ScpPlugState.fromJson(String source) =>
      ScpPlugState.fromMap(json.decode(source));

  @override
  String toString() =>
      'ScpPlugState(plug: $plug, socket: $socket, dio: $dio, ain: $ain)';
}
