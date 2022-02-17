part of plugs;

abstract class PlugAinState {
  final int ts;

  PlugAinState(this.ts);

  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlugAinState && other.ts == ts;
  }

  @override
  int get hashCode => ts.hashCode;
}
