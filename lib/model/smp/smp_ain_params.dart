part of plugs;

class SmpAinParams extends PlugAinParams {
  SmpAinParams(int freq, int time) : super(freq, time);

  @override
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

  factory SmpAinParams.fromJson(String source) =>
      SmpAinParams.fromMap(json.decode(source));

  @override
  String toString() => 'SmpAinParams(freq: $freq, time: $time)';
}
