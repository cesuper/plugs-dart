import 'dart:convert';

class SmpSensorCfg {
  int status;
  String serial;
  String name;
  int index;
  double area;
  int cavity;
  int position;
  int hrn;

  // tFill value pressure parameter
  int pFill = 100;

  SmpSensorCfg.disabled(int index) : this(-1, '', '', index, 1.0, 0, 0, 0, 100);

  SmpSensorCfg(
    this.status,
    this.serial,
    this.name,
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
