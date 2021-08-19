import 'dart:convert';

class StartPinParams {
  final int port;
  final int pin;
  final int delay;
  final int timeout;

  StartPinParams(this.port, this.pin, this.delay, this.timeout);

  Map<String, dynamic> toMap() {
    return {
      'port': port,
      'pin': pin,
      'delay': delay,
      'timeout': timeout,
    };
  }

  factory StartPinParams.fromMap(Map<String, dynamic> map) {
    return StartPinParams(
      map['port'],
      map['pin'],
      map['delay'],
      map['timeout'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StartPinParams.fromJson(String source) =>
      StartPinParams.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StartPinParams(port: $port, pin: $pin, delay: $delay, timeout: $timeout)';
  }
}
