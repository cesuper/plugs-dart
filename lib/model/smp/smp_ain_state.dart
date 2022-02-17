part of plugs;

class SmpAinState {
  final int freq;
  final int time;
  final int ts;
  final List<SmpAinSensorState> sensors;

  SmpAinState(this.freq, this.time, this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'freq': freq,
      'time': time,
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SmpAinState.fromMap(Map<String, dynamic> map) {
    return SmpAinState(
      map['freq']?.toInt() ?? 0,
      map['time']?.toInt() ?? 0,
      map['ts']?.toInt() ?? 0,
      List<SmpAinSensorState>.from(
          map['sensors']?.map((x) => SmpAinSensorState.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpAinState.fromJson(String source) =>
      SmpAinState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmpAinState(freq: $freq, time: $time, ts: $ts, sensors: $sensors)';
  }
}
