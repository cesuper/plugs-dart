part of plugs;

class SmpPlugState extends PlugState {
  final SmpAinState ain;

  SmpPlugState(Plug plug, Socket socket, this.ain) : super(plug, socket);

  @override
  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
      'ain': ain.toMap(),
    };
  }

  factory SmpPlugState.fromMap(Map<String, dynamic> map) {
    return SmpPlugState(
      Plug.fromMap(map['plug']),
      Socket.fromMap(map['socket']),
      SmpAinState.fromMap(map['ain']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SmpPlugState.fromJson(String source) =>
      SmpPlugState.fromMap(json.decode(source));

  @override
  String toString() => 'SmpPlugState(plug: $plug, socket: $socket, ain: $ain)';
}
