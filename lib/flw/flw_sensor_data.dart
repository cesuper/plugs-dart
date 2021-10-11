import 'dart:convert';

class FlwSensorData {
  //
  final bool inited;

  //
  final int status;

  //
  final String serial;

  //
  final double p;

  //
  final double t;

  //
  final double v;

  FlwSensorData(this.inited, this.status, this.serial, this.p, this.t, this.v);

  Map<String, dynamic> toMap() {
    return {
      'inited': inited,
      'status': status,
      'serial': serial,
      'p': p,
      't': t,
      'v': v,
    };
  }

  factory FlwSensorData.fromMap(Map<String, dynamic> map) {
    return FlwSensorData(
      map['inited'],
      map['status'],
      map['serial'],
      map['p'],
      map['t'],
      map['v'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlwSensorData.fromJson(String source) =>
      FlwSensorData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlwSensorData(inited: $inited, status: $status, serial: $serial, p: $p, t: $t, v: $v)';
  }
}
