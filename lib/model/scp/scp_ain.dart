part of plugs;

class ScpAin {
  final bool auto;

  final int freq;

  final int time;

  final int ts;

  final List<AinSensorState> sensors;

  ScpAin(this.auto, this.freq, this.time, this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'auto': auto,
      'freq': freq,
      'time': time,
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory ScpAin.fromMap(Map<String, dynamic> map) {
    return ScpAin(
      map['auto'] ?? false,
      map['freq']?.toInt() ?? 0,
      map['time']?.toInt() ?? 0,
      map['ts']?.toInt() ?? 0,
      List<AinSensorState>.from(
        map['sensors']?.map((x) => AinSensorState.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScpAin.fromJson(String source) => ScpAin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScpAin(auto: $auto, freq: $freq, time: $time, ts: $ts, sensors: $sensors)';
  }
}
