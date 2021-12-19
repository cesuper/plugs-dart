class Event {
  //
  static const ping = 255;

  //
  static const online = 1;

  //
  static const offline = 2;

  //
  static const networkError = 3;

  //
  final String host;

  //
  final int code;

  //
  final DateTime ts;

  const Event(this.ts, this.host, this.code);
}
