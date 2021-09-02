import 'dart:convert';

class SmpTrigger {
  // trigger request id
  final int ts;

  // sampling speed
  final int freq;

  // sampling time
  final int time;

  SmpTrigger(this.ts, this.freq, this.time);

  Map<String, dynamic> toMap() {
    return {
      'ts': ts,
      'freq': freq,
      'time': time,
    };
  }

  factory SmpTrigger.fromMap(Map<String, dynamic> map) {
    return SmpTrigger(
      map['ts'],
      map['freq'],
      map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpTrigger.fromJson(String source) =>
      SmpTrigger.fromMap(json.decode(source));

  @override
  String toString() => 'Trigger(ts: $ts, freq: $freq, tSampling: $time)';
}
