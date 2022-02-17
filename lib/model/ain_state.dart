part of plugs;

abstract class AinState {
  final int ts;

  AinState(this.ts);

  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AinState && other.ts == ts;
  }

  @override
  int get hashCode => ts.hashCode;
}
