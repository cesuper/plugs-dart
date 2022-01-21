part of plugs;

class FlwSnapshot {
  // timestamp of the snapshot, when data is created
  final int ts;
  //
  final List<FlwSensorData> sensors;

  FlwSnapshot(this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory FlwSnapshot.fromMap(Map<String, dynamic> map) {
    return FlwSnapshot(
      map['ts']?.toInt() ?? 0,
      List<FlwSensorData>.from(
          map['sensors']?.map((x) => FlwSensorData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSnapshot.fromJson(String source) =>
      FlwSnapshot.fromMap(json.decode(source));

  @override
  String toString() => 'SfpSnapshot(ts: $ts, sensors: $sensors)';
}
