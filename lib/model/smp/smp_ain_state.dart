part of plugs;

class SmpAinState extends AinState {
  final int freq;
  final int time;
  final List<SmpAinSensorState> sensors;

  SmpAinState(int ts, this.freq, this.time, this.sensors) : super(ts);

  @override
  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'freq': freq,
      'time': time,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SmpAinState.fromMap(Map<String, dynamic> map) {
    return SmpAinState(
      map['ts']?.toInt() ?? 0,
      map['freq']?.toInt() ?? 0,
      map['time']?.toInt() ?? 0,
      List<SmpAinSensorState>.from(
          map['sensors']?.map((x) => SmpAinSensorState.fromMap(x))),
    );
  }

  factory SmpAinState.fromJson(String source) =>
      SmpAinState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmpAinState(ts: $ts, freq: $freq, time: $time, sensors: $sensors)';
  }
}
