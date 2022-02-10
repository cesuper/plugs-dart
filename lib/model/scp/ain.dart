part of plugs;

class Ain {
  final bool auto;

  final int freq;

  final int time;

  final int ts;

  final List<AinSensorState> sensors;

  Ain(this.auto, this.freq, this.time, this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'auto': auto,
      'freq': freq,
      'time': time,
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory Ain.fromMap(Map<String, dynamic> map) {
    return Ain(
      map['auto'] ?? false,
      map['freq']?.toInt() ?? 0,
      map['time']?.toInt() ?? 0,
      map['ts']?.toInt() ?? 0,
      List<AinSensorState>.from(
          map['sensors']?.map((x) => AinSensorState.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ain.fromJson(String source) => Ain.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ain(auto: $auto, freq: $freq, time: $time, ts: $ts, sensors: $sensors)';
  }
}
