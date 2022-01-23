part of plugs;

class FlwPlugState {
  //
  final int delay;
  //
  final List<FlwSensorState> sensors;

  FlwPlugState(this.delay, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'delay': delay,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwPlugState.fromMap(Map<String, dynamic> map) {
    return FlwPlugState(
      map['delay']?.toInt() ?? 0,
      List<FlwSensorState>.from(
          map['sensors']?.map((x) => FlwSensorState.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwPlugState.fromJson(String source) =>
      FlwPlugState.fromMap(json.decode(source));

  @override
  String toString() => 'FlwPlugState(delay: $delay, sensors: $sensors)';
}
