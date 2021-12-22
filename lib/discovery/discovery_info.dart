/// Class with plug info extracted from discovery response
///
class DiscoveryInfo {
  // device Ipv4 address
  final String address;

  // device mac address in form of AA-AA-AA-AA-AA-AA
  final String mac;

  // device code
  final int code;

  // device serial number
  final String serial;

  // device fw version in form of x.y.z
  final String firmware;

  // device fw build number
  final String build;

  DiscoveryInfo(
    this.address,
    this.mac,
    this.code,
    this.serial,
    this.firmware,
    this.build,
  );

  @override
  String toString() {
    return 'DiscoveryInfo(address: $address, mac: $mac, code: $code, serial: $serial, firmware: $firmware, build: $build)';
  }
}
