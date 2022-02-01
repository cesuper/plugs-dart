part of plugs;

class DioState {
  final bool field;

  final List<bool> input;

  final List<bool> output;

  DioState(this.field, this.input, this.output);

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'input': input,
      'output': output,
    };
  }

  factory DioState.fromMap(Map<String, dynamic> map) {
    return DioState(
      map['field'] ?? false,
      List<bool>.from(map['input']),
      List<bool>.from(map['output']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DioState.fromJson(String source) =>
      DioState.fromMap(json.decode(source));

  @override
  String toString() =>
      'DioState(field: $field, input: $input, output: $output)';
}
