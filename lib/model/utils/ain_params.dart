part of plugs;

abstract class AinParams {
  final int freq;
  final int time;

  AinParams(this.freq, this.time);

  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());
}
