part of plugs;

class Plug {
  // plug ipv4 address
  final String address;

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
  final String family;

  //
  final String model;

  //
  final int rev;

  //
  final int sn;

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
    this.address,
    this.code,
    this.serial,
    this.mac,
    this.fw,
    this.build,
    this.family,
    this.model,
    this.rev,
    this.sn,
    this.uptime,
    this.temp,
    this.sysTotal,
    this.sysFree,
    this.epiTotal,
    this.epiFree,
  );

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'code': code,
      'serial': serial,
      'mac': mac,
      'fw': fw,
      'build': build,
      'family': family,
      'model': model,
      'rev': rev,
      'sn': sn,
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
      map['address'] ?? '',
      map['code']?.toInt() ?? 0,
      map['serial'] ?? '',
      map['mac'] ?? '',
      map['fw'] ?? '',
      map['build'] ?? '',
      map['family'] ?? '',
      map['model'] ?? '',
      map['rev']?.toInt() ?? 0,
      map['sn']?.toInt() ?? 0,
      map['uptime']?.toInt() ?? 0,
      map['temp'] ?? 0,
      map['sysTotal']?.toInt() ?? 0,
      map['sysFree']?.toInt() ?? 0,
      map['epiTotal']?.toInt() ?? 0,
      map['epiFree']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plug.fromJson(String source) => Plug.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Plug(address: $address, code: $code, serial: $serial, mac: $mac, fw: $fw, build: $build, family: $family, model: $model, rev: $rev, sn: $sn, uptime: $uptime, temp: $temp, sysTotal: $sysTotal, sysFree: $sysFree, epiTotal: $epiTotal, epiFree: $epiFree)';
  }
}
