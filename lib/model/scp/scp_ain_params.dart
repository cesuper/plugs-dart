part of plugs;

class ScpAinParams extends AinParams {
  ScpAinParams(int freq, int time) : super(freq, time);

  @override
  Map<String, dynamic> toMap() {
    return {
      'freq': freq,
      'time': time,
    };
  }

  factory ScpAinParams.fromMap(Map<String, dynamic> map) {
    return ScpAinParams(
      map['freq']?.toInt() ?? 0,
      map['time']?.toInt() ?? 0,
    );
  }

  factory ScpAinParams.fromJson(String source) =>
      ScpAinParams.fromMap(json.decode(source));

  @override
  String toString() => 'ScpAinParams(freq: $freq, time: $time)';
}
