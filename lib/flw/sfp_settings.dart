import 'dart:convert';

import '../ain/ain_settings.dart';

class SfpSettings extends AinSettings {
  //
  final int delay;

  //
  SfpSettings(this.delay);

  @override
  Map<String, dynamic> toMap() {
    return {'delay': delay};
  }

  factory SfpSettings.fromMap(Map<String, dynamic> map) {
    return SfpSettings(map['delay']);
  }

  ///
  factory SfpSettings.fromJson(String source) =>
      SfpSettings.fromMap(json.decode(source));

  @override
  String toString() => 'SfpSettings(delay: $delay)';
}
