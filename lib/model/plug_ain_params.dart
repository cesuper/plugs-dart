part of plugs;

abstract class PlugAinParams {
  final int freq;
  final int time;

  PlugAinParams(this.freq, this.time);

  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlugAinParams && other.freq == freq && other.time == time;
  }

  @override
  int get hashCode => freq.hashCode ^ time.hashCode;
}
