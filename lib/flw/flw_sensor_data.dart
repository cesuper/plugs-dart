import 'dart:convert';

class FlwSensorData {
  //
  final int status;

  //
  final String serial;

  //
  final String name;

  //
  final double p;

  //
  final double t;

  //
  final double v;

  FlwSensorData(this.status, this.serial, this.name, this.p, this.t, this.v);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'name': name,
      'p': p,
      't': t,
      'v': v,
    };
  }

  factory FlwSensorData.fromMap(Map<String, dynamic> map) {
    return FlwSensorData(
      map['status'],
      map['serial'],
      map['name'],
      double.parse(map['p'].toString()),
      double.parse(map['t'].toString()),
      double.parse(map['v'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSensorData.fromJson(String source) =>
      FlwSensorData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlwSensorData(status: $status, serial: $serial, name: $name, p: $p, t: $t, v: $v)';
  }
}
