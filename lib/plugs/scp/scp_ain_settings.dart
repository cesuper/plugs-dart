import 'dart:convert';

import '../ain/ain_settings.dart';

class ScpAinSettings extends AinSettings {
  //
  final bool isAuto;

  //
  final num freq;

  //
  final num time;

  ///
  ScpAinSettings(this.isAuto, this.freq, this.time);

  @override
  Map<String, dynamic> toMap() {
    return {
      'isAuto': isAuto,
      'freq': freq,
      'time': time,
    };
  }

  factory ScpAinSettings.fromMap(Map<String, dynamic> map) {
    return ScpAinSettings(
      map['isAuto'],
      map['freq'],
      map['time'],
    );
  }

  factory ScpAinSettings.fromJson(String source) =>
      ScpAinSettings.fromMap(json.decode(source));

  @override
  String toString() =>
      'ScpAinSettings(isAuto: $isAuto, freq: $freq, time: $time)';
}
