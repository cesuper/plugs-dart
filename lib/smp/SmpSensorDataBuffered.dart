import 'dart:convert';

class SmpDeviceBufferedData {
  final int status;

  final String serial;

  final String name;

  // group
  final String group;

  // index
  final int index;

  // cavity
  final int cavity;

  // position
  final int position;

  // hrn
  final int hrn;

  // pressure curve
  final List<double> p;

  // curve peak point
  final double max;

  // curve integral value
  final double integral;

  // curve tFill value
  final double tFill;

  SmpDeviceBufferedData(
    this.status,
    this.serial,
    this.name,
    this.group,
    this.index,
    this.cavity,
    this.position,
    this.hrn,
    this.p,
    this.max,
    this.integral,
    this.tFill,
  );

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'serial': serial,
      'name': name,
      'group': group,
      'index': index,
      'cavity': cavity,
      'position': position,
      'hrn': hrn,
      'p': p,
      'max': max,
      'int': integral,
      'tFill': tFill,
    };
  }

  factory SmpDeviceBufferedData.fromMap(Map<String, dynamic> map) {
    return SmpDeviceBufferedData(
      map['status'],
      map['serial'],
      map['name'],
      map['group'],
      map['index'],
      map['cavity'],
      map['position'],
      map['hrn'],
      List<double>.from(map['p']),
      map['max'],
      map['int'],
      map['tFill'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmpDeviceBufferedData.fromJson(String source) =>
      SmpDeviceBufferedData.fromMap(json.decode(source));
}
