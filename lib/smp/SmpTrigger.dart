import 'dart:convert';

class SmpTrigger {
  // trigger request id
  final int ts;

  // sampling speed
  final int sps;

  // sampling time
  final int tSampling;

  SmpTrigger(this.ts, this.sps, this.tSampling);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'sps': sps,
      'tSampling': tSampling,
    };
  }

  factory SmpTrigger.fromMap(Map<String, dynamic> map) {
    return SmpTrigger(
      map['ts'],
      map['sps'],
      map['tSampling'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpTrigger.fromJson(String source) =>
      SmpTrigger.fromMap(json.decode(source));

  @override
  String toString() => 'Trigger(ts: $ts, sps: $sps, tSampling: $tSampling)';
}
