part of plugs;

class Flw {
  //
  final int delay;
  //
  final List<FlwSensorData> sensors;

  Flw(this.delay, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'delay': delay,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory Flw.fromMap(Map<String, dynamic> map) {
    return Flw(
      map['delay']?.toInt() ?? 0,
      List<FlwSensorData>.from(
          map['sensors']?.map((x) => FlwSensorData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Flw.fromJson(String source) => Flw.fromMap(json.decode(source));

  @override
  String toString() => 'Flw(delay: $delay, sensors: $sensors)';
}
