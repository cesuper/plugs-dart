part of plugs;

class AinScpPlugState extends ScpPlugState {
  final Ain ain;

  AinScpPlugState(Plug plug, Socket socket, Dio dio, this.ain)
      : super(plug, socket, dio);

  @override
  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
      'dio': dio.toMap(),
      'ain': ain.toMap(),
    };
  }

  factory AinScpPlugState.fromMap(Map<String, dynamic> map) {
    return AinScpPlugState(
      Plug.fromMap(map['plug']),
      Socket.fromMap(map['socket']),
      Dio.fromMap(map['dio']),
      Ain.fromMap(map['ain']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AinScpPlugState.fromJson(String source) =>
      AinScpPlugState.fromMap(json.decode(source));
}
