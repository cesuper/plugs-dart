part of plugs;

class ScpPlugState extends PlugState {
  final Dio dio;

  ScpPlugState(Plug plug, Sck socket, this.dio) : super(plug, socket);

  @override
  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
      'dio': dio.toMap(),
    };
  }

  factory ScpPlugState.fromMap(Map<String, dynamic> map) {
    return ScpPlugState(
      Plug.fromMap(map['plug']),
      Sck.fromMap(map['socket']),
      Dio.fromMap(map['dio']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ScpPlugState.fromJson(String source) =>
      ScpPlugState.fromMap(json.decode(source));

  @override
  String toString() => 'ScpPlugState(plug: $plug, socket: $socket, dio: $dio)';
}
