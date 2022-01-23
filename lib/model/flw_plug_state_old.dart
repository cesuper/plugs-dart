part of plugs;

class FlwPlugStateOld {
  //
  final int delay;
  //
  final List<FlwSensorState> sensors;

  FlwPlugStateOld(this.delay, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'delay': delay,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwPlugStateOld.fromMap(Map<String, dynamic> map) {
    return FlwPlugStateOld(
      map['delay']?.toInt() ?? 0,
      List<FlwSensorState>.from(
          map['sensors']?.map((x) => FlwSensorState.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwPlugStateOld.fromJson(String source) =>
      FlwPlugStateOld.fromMap(json.decode(source));

  @override
  String toString() => 'FlwPlugState(delay: $delay, sensors: $sensors)';
}
