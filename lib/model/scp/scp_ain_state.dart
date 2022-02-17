part of plugs;

class ScpAinState extends PlugAinState {
  final bool auto;

  final int freq;

  final int time;

  final List<ScpAinSensorState> sensors;

  ScpAinState(int ts, this.auto, this.freq, this.time, this.sensors)
      : super(ts);

  @override
  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'auto': auto,
      'freq': freq,
      'time': time,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory ScpAinState.fromMap(Map<String, dynamic> map) {
    return ScpAinState(
      map['ts']?.toInt() ?? 0,
      map['auto'] ?? false,
      map['freq']?.toInt() ?? 0,
      map['time']?.toInt() ?? 0,
      List<ScpAinSensorState>.from(
        map['sensors']?.map((x) => ScpAinSensorState.fromMap(x)),
      ),
    );
  }

  factory ScpAinState.fromJson(String source) =>
      ScpAinState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScpAin(ts: $ts, auto: $auto, freq: $freq, time: $time, sensors: $sensors)';
  }
}
