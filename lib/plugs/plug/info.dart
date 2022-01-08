import 'dart:convert';

class Info {
  // plug device code
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

  Info(
    this.code,
    this.serial,
    this.mac,
    this.fw,
    this.build,
  );

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'serial': serial,
      'mac': mac,
      'fw': fw,
      'build': build,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      map['code']?.toInt() ?? 0,
      map['serial'] ?? '',
      map['mac'] ?? '',
      map['fw'] ?? '',
      map['build'] ?? '',
    );
  }

  // Returns filename prefix based on device properties
  String get filenamePrefix => '$family$model-r$rev';

  /// Returns true when the firmware specified by [filename] is supported by the device
  bool isFirmwareSupported(String filename) =>
      filename.startsWith(filenamePrefix) && filename.endsWith('.bin');

  /// Returns true when the firmware specified by [filename] matches with the
  /// firmware on the device
  bool isFirmwareMatch(String filename) {
    // construct format
    final format = '$major.$minor.$fix.bin';

    //
    return isFirmwareSupported(filename) && filename.endsWith(format);
  }

  // device family like: sfp, smp, etc
  String get family => serial.substring(0, 3);

  // device model like: 9,32
  String get model => serial.substring(3, serial.indexOf('-'));

  // device revision like: 1, 2,
  int get rev => int.parse(serial.split('-')[1].substring(1));

  // device serial number like: 123
  int get sn => int.parse(serial.split('-').last);

  // fw major version
  int get major => int.parse(fw.split('.').first);

  // fw minor version
  int get minor => int.parse(fw.split('.')[1]);

  // fw fix version
  int get fix => int.parse(fw.split('.').last);

  //
  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Info(code: $code, serial: $serial, mac: $mac, fw: $fw)';
  }
}
