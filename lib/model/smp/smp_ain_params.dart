part of plugs;

class SmpAinParams extends AinParams {
  final int freq;
  final int time;

  SmpAinParams(this.freq, this.time);

  Map<String, dynamic> toMap() {
    return {
      'freq': freq,
      'time': time,
    };
  }

  factory SmpAinParams.fromMap(Map<String, dynamic> map) {
    return SmpAinParams(
      map['freq']?.toInt() ?? 0,
      map['time']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpAinParams.fromJson(String source) =>
      SmpAinParams.fromMap(json.decode(source));

  @override
  String toString() => 'SmpAinParams(freq: $freq, time: $time)';
}
