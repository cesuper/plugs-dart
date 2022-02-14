part of plugs;

class ScpDio {
  final bool field;

  final List<bool> input;

  final List<bool> output;

  ScpDio(this.field, this.input, this.output);

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'input': input,
      'output': output,
    };
  }

  factory ScpDio.fromMap(Map<String, dynamic> map) {
    return ScpDio(
      map['field'],
      List<bool>.from(map['input']),
      List<bool>.from(map['output']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScpDio.fromJson(String source) => ScpDio.fromMap(json.decode(source));

  @override
  String toString() => 'ScpDio(field: $field, input: $input, output: $output)';
}
