import 'dart:convert';

class SpcStateResponse {
  final bool field;
  final List<bool> input;
  final List<bool> output;

  SpcStateResponse(this.field, this.input, this.output);

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'input': input,
      'output': output,
    };
  }

  factory SpcStateResponse.fromMap(Map<String, dynamic> map) {
    return SpcStateResponse(
      map['field'],
      List<bool>.from(map['input']),
      List<bool>.from(map['output']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SpcStateResponse.fromJson(String source) =>
      SpcStateResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'SpcStateResponse(field: $field, input: $input, output: $output)';
}
