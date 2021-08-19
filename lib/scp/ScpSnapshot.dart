import 'dart:convert';

class ScpSnapshot {
  final List<String> socket;
  final bool field;
  final List<bool> input;
  final List<bool> output;

  ScpSnapshot(this.socket, this.field, this.input, this.output);

  Map<String, dynamic> toMap() {
    return {
      'socket': socket,
      'field': field,
      'input': input,
      'output': output,
    };
  }

  factory ScpSnapshot.fromMap(Map<String, dynamic> map) {
    return ScpSnapshot(
      List<String>.from(map['socket']),
      map['field'],
      List<bool>.from(map['input']),
      List<bool>.from(map['output']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScpSnapshot.fromJson(String source) =>
      ScpSnapshot.fromMap(json.decode(source));
}
