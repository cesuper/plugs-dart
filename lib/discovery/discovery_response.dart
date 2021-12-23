/// Class with plug info extracted from discovery response
///
class DiscoveryResponse {
  // size of the discovery response in bytes
  static const size = 128;

  // device ipv4 address
  final String address;

  // device mac address in form of AA-AA-AA-AA-AA-AA
  final String mac;

  // device code
  final int code;

  // device serial number
  final String serial;

  // device fw version in form of x.y.z
  final String firmware;

  DiscoveryResponse(
    this.address,
    this.mac,
    this.code,
    this.serial,
    this.firmware,
  );

  @override
  String toString() {
    return 'DiscoveryResponse(address: $address, mac: $mac, code: $code, serial: $serial, firmware: $firmware)';
  }
}
