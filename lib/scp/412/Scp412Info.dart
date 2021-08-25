import 'dart:convert';

class Scp412Info {
  //
  int counter;

  Scp412Info(this.counter);

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
    };
  }

  factory Scp412Info.fromMap(Map<String, dynamic> map) {
    return Scp412Info(
      map['counter'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Scp412Info.fromJson(String source) =>
      Scp412Info.fromMap(json.decode(source));

  @override
  String toString() => 'Scp412Info(counter: $counter)';
}
