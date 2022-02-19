part of plugs;

class ScpDioState {
  final bool field;

  final List<bool> input;

  final List<bool> output;

  ScpDioState(this.field, this.input, this.output);

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'input': input,
      'output': output,
    };
  }

  factory ScpDioState.fromMap(Map<String, dynamic> map) {
    return ScpDioState(
      map['field'],
      List<bool>.from(map['input']),
      List<bool>.from(map['output']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScpDioState.fromJson(String source) =>
      ScpDioState.fromMap(json.decode(source));

  @override
  String toString() =>
      'ScpDioState(field: $field, input: $input, output: $output)';
}
