part of plugs;

class Dio {
  final bool field;

  final List<bool> input;

  final List<bool> output;

  Dio(this.field, this.input, this.output);

  Map<String, dynamic> toMap() {
    return {
      'field': field,
      'in': input,
      'out': output,
    };
  }

  factory Dio.fromMap(Map<String, dynamic> map) {
    return Dio(
      map['field'] == 1,
      List<int>.from(map['in']).map((e) => e == 1).toList(),
      List<int>.from(map['out']).map((e) => e == 1).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dio.fromJson(String source) => Dio.fromMap(json.decode(source));

  @override
  String toString() => 'Dio(field: $field, in: $input, out: $output)';
}
