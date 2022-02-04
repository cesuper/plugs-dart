part of plugs;

class Ain {
  final int value;

  Ain(this.value);

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory Ain.fromMap(Map<String, dynamic> map) {
    return Ain(
      map['value']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ain.fromJson(String source) => Ain.fromMap(json.decode(source));

  @override
  String toString() => 'Ain(value: $value)';
}
