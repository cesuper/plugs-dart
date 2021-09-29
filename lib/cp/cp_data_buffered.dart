import 'dart:convert';

class CpDataBuffered {
  // status of the sampling, 0 = no error
  final int status;

  // identify value
  final String serial;

  // pressure curve
  final List<double> p;

  CpDataBuffered(
    this.status,
    this.serial,
    this.p,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'p': p,
    };
  }

  factory CpDataBuffered.fromMap(Map<String, dynamic> map) {
    return CpDataBuffered(
      map['status'],
      map['serial'],
      List<double>.from(map['p']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpDataBuffered.fromJson(String source) =>
      CpDataBuffered.fromMap(json.decode(source));
}
