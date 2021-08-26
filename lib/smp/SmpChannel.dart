import 'dart:convert';

class SmpChannel {
  final String serial;

  final double area;

  final String name;

  SmpChannel(this.serial, this.area, this.name);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'area': area,
      'name': name,
    };
  }

  factory SmpChannel.fromMap(Map<String, dynamic> map) {
    return SmpChannel(
      map['serial'],
      map['area'],
      map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpChannel.fromJson(String source) =>
      SmpChannel.fromMap(json.decode(source));

  @override
  String toString() => 'SmpChannel(serial: $serial, area: $area, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SmpChannel &&
        other.serial == serial &&
        other.area == area &&
        other.name == name;
  }

  @override
  int get hashCode => serial.hashCode ^ area.hashCode ^ name.hashCode;
}
