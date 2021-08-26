import 'dart:convert';

/// Use this class to serialize [CpChannel] into socket memory
class CpChannelSocketData {
  // sensor serial
  final String serial;

  // sensor code
  final double area;

  // sensor name
  final String name;

  // cavity
  final int cavity;

  // position
  final int position;

  CpChannelSocketData(
      this.serial, this.area, this.name, this.cavity, this.position);

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'area': area,
      'name': name,
      'cavity': cavity,
      'position': position,
    };
  }

  factory CpChannelSocketData.fromMap(Map<String, dynamic> map) {
    return CpChannelSocketData(
      map['serial'],
      map['area'],
      map['name'],
      map['cavity'],
      map['position'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CpChannelSocketData.fromJson(String source) =>
      CpChannelSocketData.fromMap(json.decode(source));
}
