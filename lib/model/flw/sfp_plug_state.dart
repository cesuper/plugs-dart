part of plugs;

class SfpPlugState extends PlugState {
  final Flw flw;

  SfpPlugState(Plug plug, Socket socket, this.flw) : super(plug, socket);

  @override
  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
      'flw': flw.toMap(),
    };
  }

  factory SfpPlugState.fromMap(Map<String, dynamic> map) {
    return SfpPlugState(
      Plug.fromMap(map['plug']),
      Socket.fromMap(map['socket']),
      Flw.fromMap(map['flw']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SfpPlugState.fromJson(String source) =>
      SfpPlugState.fromMap(json.decode(source));

  @override
  String toString() => 'SfpPlugState(plug: $plug, socket: $socket, flw: $flw)';
}
