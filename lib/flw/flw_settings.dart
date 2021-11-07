import 'dart:convert';

import '../ain/ain_settings.dart';

class FlwSettings extends AinSettings {
  //
  final int delay;

  //
  FlwSettings(this.delay);

  @override
  Map<String, dynamic> toMap() {
    return {'delay': delay};
  }

  factory FlwSettings.fromMap(Map<String, dynamic> map) {
    return FlwSettings(map['delay']);
  }

  ///
  factory FlwSettings.fromJson(String source) =>
      FlwSettings.fromMap(json.decode(source));

  @override
  String toString() => 'FlwSettings(delay: $delay)';
}
