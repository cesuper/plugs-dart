import 'dart:convert';

import 'cp_curve.dart';

class CpData {
  // cycle timestamp
  int ts;

  // curves generated
  final List<CpCurve> curves;

  CpData(this.ts, this.curves);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'curves': curves.map((x) => x.toMap()).toList(),
    };
  }

  factory CpData.fromMap(Map<String, dynamic> map) {
    return CpData(
      map['ts'],
      List<CpCurve>.from(map['curves']?.map((x) => CpCurve.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpData.fromJson(String source) => CpData.fromMap(json.decode(source));
}
