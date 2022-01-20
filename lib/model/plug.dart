part of plugs;

class Plug {
  // plug device code that identifies the family and model with a single number
  final int code;

  // plug serial with format: '${family}${model}-r${rev}-${sn}'
  final String serial;

  // plug mac address with format: 94-fb-a7-51-00-8c
  final String mac;

  // plug firmware version with format: '$major.$minor.$fix'
  final String fw;

  // plug firmware build value. This value is automatically generated when
  // the firmware is compiled
  final String build;

  //
  final int uptime;

  //
  final num temp;

  //
  final int sysTotal;

  //
  final int sysFree;

  //
  final int epiTotal;

  //
  final int epiFree;

  Plug(
    this.code,
    this.serial,
    this.mac,
    this.fw,
    this.build,
    this.uptime,
    this.temp,
    this.sysTotal,
    this.sysFree,
    this.epiTotal,
    this.epiFree,
  );

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'serial': serial,
      'mac': mac,
      'fw': fw,
      'build': build,
      'uptime': uptime,
      'temp': temp,
      'sysTotal': sysTotal,
      'sysFree': sysFree,
      'epiTotal': epiTotal,
      'epiFree': epiFree,
    };
  }

  factory Plug.fromMap(Map<String, dynamic> map) {
    return Plug(
      map['code']?.toInt() ?? 0,
      map['serial'] ?? '',
      map['mac'] ?? '',
      map['fw'] ?? '',
      map['build'] ?? '',
      map['uptime'] ?? 0,
      map['temp'] ?? 0,
      map['sysTotal'] ?? 0,
      map['sysFree'] ?? 0,
      map['epiTotal'] ?? 0,
      map['epiFree'] ?? 0,
    );
  }

  //
  String toJson() => json.encode(toMap());

  factory Plug.fromJson(String source) => Plug.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Plug(code: $code, serial: $serial, mac: $mac, fw: $fw)';
  }
}
