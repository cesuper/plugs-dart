import 'dart:convert';

class ScpData {
  final bool field;
  final List<bool> input;
  final List<bool> output;

  ScpData(this.field, this.input, this.output);

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'input': input,
      'output': output,
    };
  }

  factory ScpData.fromMap(Map<String, dynamic> map) {
    return ScpData(
      map['field'],
      List<bool>.from(map['input']),
      List<bool>.from(map['output']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScpData.fromJson(String source) =>
      ScpData.fromMap(json.decode(source));

  @override
  String toString() =>
      'SpcStateResponse(field: $field, input: $input, output: $output)';
}
