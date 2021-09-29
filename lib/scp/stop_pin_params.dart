import 'dart:convert';

class StopPinParams {
  final int port;
  final int pin;

  StopPinParams(this.port, this.pin);

  Map<String, dynamic> toMap() {
    return {
      'port': port,
      'pin': pin,
    };
  }

  factory StopPinParams.fromMap(Map<String, dynamic> map) {
    return StopPinParams(
      map['port'],
      map['pin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StopPinParams.fromJson(String source) =>
      StopPinParams.fromMap(json.decode(source));

  @override
  String toString() => 'StopPinParams(port: $port, pin: $pin)';
}
