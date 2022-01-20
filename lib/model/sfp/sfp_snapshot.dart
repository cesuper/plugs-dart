part of plugs;

class SfpSnapshot {
  // timestamp of the snapshot, when data is created
  final int ts;
  //
  final List<SfpSensorData> sensors;

  SfpSnapshot(this.ts, this.sensors);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sensors': sensors.map((x) => x.toMap()).toList(),
    };
  }

  factory SfpSnapshot.fromMap(Map<String, dynamic> map) {
    return SfpSnapshot(
      map['ts']?.toInt() ?? 0,
      List<SfpSensorData>.from(
          map['sensors']?.map((x) => SfpSensorData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SfpSnapshot.fromJson(String source) =>
      SfpSnapshot.fromMap(json.decode(source));

  @override
  String toString() => 'SfpSnapshot(ts: $ts, sensors: $sensors)';
}
