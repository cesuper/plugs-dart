import 'dart:convert';

import 'cp_channel.dart';

class CpCurve {
  // sensor serial
  final CpChannel channel;

  // sampling result
  final List<double> p;

  //
  CpCurve(this.channel, this.p);

  Map<String, dynamic> toMap() {
    return {
      'channel': channel.toMap(),
      'p': p,
    };
  }

  factory CpCurve.fromMap(Map<String, dynamic> map) {
    return CpCurve(
      CpChannel.fromMap(map['channel']),
      List<double>.from(map['p']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CpCurve.fromJson(String source) =>
      CpCurve.fromMap(json.decode(source));

  @override
  String toString() => 'CpCurve(channel: $channel, p: $p)';
}
