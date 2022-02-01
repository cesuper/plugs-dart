part of plugs;

class PlugState {
  //
  final Plug plug;

  //
  final Socket socket;

  PlugState(this.plug, this.socket);

  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
    };
  }

  factory PlugState.fromMap(Map<String, dynamic> map) {
    return PlugState(
      Plug.fromMap(map['plug']),
      Socket.fromMap(map['socket']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlugState.fromJson(String source) =>
      PlugState.fromMap(json.decode(source));

  @override
  String toString() => 'PlugState(plug: $plug, socket: $socket)';
}
