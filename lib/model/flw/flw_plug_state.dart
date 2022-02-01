part of plugs;

class FlwPlugState {
  final Plug plug;

  final Socket socket;

  final Flw flw;

  FlwPlugState(this.plug, this.socket, this.flw);

  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
      'flw': flw.toMap(),
    };
  }

  factory FlwPlugState.fromMap(Map<String, dynamic> map) {
    return FlwPlugState(
      Plug.fromMap(map['plug']),
      Socket.fromMap(map['socket']),
      Flw.fromMap(map['flw']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwPlugState.fromJson(String source) =>
      FlwPlugState.fromMap(json.decode(source));

  @override
  String toString() => 'FlwPlugState(plug: $plug, socket: $socket, flw: $flw)';
}
