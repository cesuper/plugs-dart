import 'dart:convert';

class TimedPinParam {
  final int delay;
  final int timeout;

  TimedPinParam(this.delay, this.timeout);

  Map<String, dynamic> toMap() {
    return {
      'delay': delay,
      'timeout': timeout,
    };
  }

  factory TimedPinParam.fromMap(Map<String, dynamic> map) {
    return TimedPinParam(
      map['delay'],
      map['timeout'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TimedPinParam.fromJson(String source) =>
      TimedPinParam.fromMap(json.decode(source));
}
