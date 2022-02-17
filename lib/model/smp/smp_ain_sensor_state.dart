part of plugs;

class SmpAinSensorState extends SensorState {
  final num area;

  final num cavity;

  final num position;

  final num hrn;

  final List<num> value;

  SmpAinSensorState(
    String plug,
    String serial,
    String name,
    int status,
    this.area,
    this.cavity,
    this.position,
    this.hrn,
    this.value,
  ) : super(
          plug,
          serial,
          name,
          status,
        );

  Map<String, dynamic> toMap() {
    return {
      'plug': plug,
      'serial': serial,
      'name': name,
      'status': status,
      'area': area,
      'cavity': cavity,
      'position': position,
      'hrn': hrn,
      'value': value,
    };
  }

  factory SmpAinSensorState.fromMap(Map<String, dynamic> map) {
    return SmpAinSensorState(
      map['plug'] ?? '',
      map['serial'] ?? '',
      map['name'] ?? '',
      map['status'] ?? 0,
      map['area'] ?? 0,
      map['cavity'] ?? 0,
      map['position'] ?? 0,
      map['hrn'] ?? 0,
      List<num>.from(map['value']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpAinSensorState.fromJson(String source) =>
      SmpAinSensorState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmpAinSensorState(area: $area, cavity: $cavity, position: $position, hrn: $hrn, value: $value)';
  }
}
