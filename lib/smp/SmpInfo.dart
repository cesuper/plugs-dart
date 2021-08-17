import 'dart:convert';

class SmpInfo {
  final int ignoredTriggers;

  SmpInfo(this.ignoredTriggers);

  Map<String, dynamic> toMap() {
    return {
      'ignoredTriggers': ignoredTriggers,
    };
  }

  factory SmpInfo.fromMap(Map<String, dynamic> map) {
    return SmpInfo(
      map['ignoredTriggers'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpInfo.fromJson(String source) =>
      SmpInfo.fromMap(json.decode(source));
}
