import 'dart:convert';

abstract class AinSettings {
  //
  Map<String, dynamic> toMap();

  //
  String toJson() => json.encode(toMap());
}
