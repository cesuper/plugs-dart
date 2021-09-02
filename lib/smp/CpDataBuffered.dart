import 'dart:convert';

class CpDataBuffered {
  //
  final int status;

  // identify value
  final String serial;

  final double area;

  // pressure curve
  final List<double> p;

  CpDataBuffered(
    this.status,
    this.serial,
    this.area,
    this.p,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'area': area,
      'p': p,
    };
  }

  factory CpDataBuffered.fromMap(Map<String, dynamic> map) {
    return CpDataBuffered(
      map['status'],
      map['serial'],
      map['area'],
      List<double>.from(map['p']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpDataBuffered.fromJson(String source) =>
      CpDataBuffered.fromMap(json.decode(source));
}
