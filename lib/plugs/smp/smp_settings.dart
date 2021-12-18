import 'dart:convert';

import 'package:plugs/plugs/ain/ain_settings.dart';

class SmpSettings extends AinSettings {
  //
  final num freq;

  //
  final num time;

  //
  SmpSettings(this.freq, this.time);

  @override
  Map<String, dynamic> toMap() {
    return {
      'freq': freq,
      'time': time,
    };
  }

  factory SmpSettings.fromMap(Map<String, dynamic> map) {
    return SmpSettings(
      map['freq'],
      map['time'],
    );
  }

  factory SmpSettings.fromJson(String source) =>
      SmpSettings.fromMap(json.decode(source));

  @override
  String toString() => 'SmpSettings(freq: $freq, time: $time)';
}
