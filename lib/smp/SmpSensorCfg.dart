import 'dart:convert';

class SmpSensorCfg {
  int status;
  String serial;
  String name;
  String group;
  int index;
  double area;
  int cavity;
  int position;
  int hrn;

  // tFill value pressure parameter
  int pFill;

  SmpSensorCfg(
    this.status,
    this.serial,
    this.name,
    this.group,
    this.index,
    this.area,
    this.cavity,
    this.position,
    this.hrn,
    this.pFill,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'name': name,
      'group': group,
      'index': index,
      'area': area,
      'cavity': cavity,
      'position': position,
      'hrn': hrn,
      'pFill': pFill,
    };
  }

  factory SmpSensorCfg.fromMap(Map<String, dynamic> map) {
    return SmpSensorCfg(
      map['status'],
      map['serial'],
      map['name'],
      map['group'],
      map['index'],
      map['area'],
      map['cavity'],
      map['position'],
      map['hrn'],
      map['pFill'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpSensorCfg.fromJson(String source) =>
      SmpSensorCfg.fromMap(json.decode(source));
}
