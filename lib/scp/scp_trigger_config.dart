import 'dart:convert';

class ScpTriggerConfig {
  // module status
  bool enabled;

  // host where the POST request is sent
  String host;

  // path where the POST request is sent
  String path;

  // duration of the triggering
  int duration;

  ScpTriggerConfig(this.enabled, this.host, this.path, this.duration);

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'host': host,
      'path': path,
      'duration': duration,
    };
  }

  factory ScpTriggerConfig.fromMap(Map<String, dynamic> map) {
    return ScpTriggerConfig(
      map['enabled'],
      map['host'],
      map['path'],
      map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScpTriggerConfig.fromJson(String source) =>
      ScpTriggerConfig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScpTriggerConfig(enabled: $enabled, host: $host, path: $path, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScpTriggerConfig &&
        other.enabled == enabled &&
        other.host == host &&
        other.path == path &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return enabled.hashCode ^ host.hashCode ^ path.hashCode ^ duration.hashCode;
  }
}
