part of plugs;

class Dio {
  final bool field;

  final List<bool> input;

  final List<bool> output;

  Dio(this.field, this.input, this.output);

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'input': input,
      'output': output,
    };
  }

  factory Dio.fromMap(Map<String, dynamic> map) {
    return Dio(
      map['field'] ?? false,
      List<bool>.from(map['input']),
      List<bool>.from(map['output']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dio.fromJson(String source) => Dio.fromMap(json.decode(source));

  @override
  String toString() => 'Dio(field: $field, input: $input, output: $output)';
}
