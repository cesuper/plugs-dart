part of plugs;

class FlwPlugState extends PlugState {
  final Flw flw;

  FlwPlugState(Plug plug, Sck socket, this.flw) : super(plug, socket);

  @override
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
      Sck.fromMap(map['socket']),
      Flw.fromMap(map['flw']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory FlwPlugState.fromJson(String source) =>
      FlwPlugState.fromMap(json.decode(source));

  @override
  String toString() => 'FlwPlugState(plug: $plug, socket: $socket, flw: $flw)';
}
