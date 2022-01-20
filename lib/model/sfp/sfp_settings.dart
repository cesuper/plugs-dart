part of plugs;

class SfpSettings {
  final int delay;

  final List<SfpSensorParam> sensors;

  SfpSettings(this.delay, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'delay': delay,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SfpSettings.fromMap(Map<String, dynamic> map) {
    return SfpSettings(
      map['delay']?.toInt() ?? 0,
      List<SfpSensorParam>.from(
          map['sensors']?.map((x) => SfpSensorParam.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SfpSettings.fromJson(String source) =>
      SfpSettings.fromMap(json.decode(source));

  @override
  String toString() => 'SfpSettings(delay: $delay, sensors: $sensors)';
}
