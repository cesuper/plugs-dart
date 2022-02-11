part of plugs;

/// Base class for PlugState.
/// See plug specific child implementation like [SfpPlugState] or [ScpPlugState]
abstract class PlugState {
  final Plug plug;

  final Socket socket;

  PlugState(this.plug, this.socket);

  Map<String, dynamic> toMap() {
    return {
      'plug': plug.toMap(),
      'socket': socket.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
