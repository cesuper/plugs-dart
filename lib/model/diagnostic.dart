import 'dart:convert';

class Diagnostic {
  final int uptime;
  final double temp;
  final int sysTotal;
  final int sysFree;
  final int epiTotal;
  final int epiFree;

  Diagnostic(
    this.uptime,
    this.temp,
    this.sysTotal,
    this.sysFree,
    this.epiTotal,
    this.epiFree,
  );

  Map<String, dynamic> toMap() {
    return {
      'uptime': uptime,
      'temp': temp,
      'sysTotal': sysTotal,
      'sysFree': sysFree,
      'epiTotal': epiTotal,
      'epiFree': epiFree,
    };
  }

  factory Diagnostic.fromMap(Map<String, dynamic> map) {
    return Diagnostic(
      map['uptime'],
      map['temp'],
      map['sysTotal'],
      map['sysFree'],
      map['epiTotal'],
      map['epiFree'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Diagnostic.fromJson(String source) =>
      Diagnostic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Diagnostic(uptime: $uptime, temp: $temp, sysTotal: $sysTotal, sysFree: $sysFree, epiTotal: $epiTotal, epiFree: $epiFree)';
  }
}
