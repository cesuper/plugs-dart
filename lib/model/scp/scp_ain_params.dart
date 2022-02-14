part of plugs;

class ScpAinParams {
  final int freq;
  final int time;

  ScpAinParams(this.freq, this.time);

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

  String toJson() => json.encode(toMap());

  factory ScpAinParams.fromJson(String source) =>
      ScpAinParams.fromMap(json.decode(source));
}
