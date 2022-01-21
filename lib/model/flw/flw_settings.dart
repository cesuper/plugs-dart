part of plugs;

class FlwSettings {
  final int delay;

  final List<FlwSensorParam> sensors;

  FlwSettings(this.delay, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'delay': delay,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwSettings.fromMap(Map<String, dynamic> map) {
    return FlwSettings(
      map['delay']?.toInt() ?? 0,
      List<FlwSensorParam>.from(
          map['sensors']?.map((x) => FlwSensorParam.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSettings.fromJson(String source) =>
      FlwSettings.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSettings(delay: $delay, sensors: $sensors)';
}
