/// Class with plug info extracted from discovery response
///
class DiscoveryResponse {
  // device ipv4 address
  final String address;

  // device mac address in form of AA-AA-AA-AA-AA-AA
  final String mac;

  // device serial number
  final String serial;

  // device code
  final int code;

  // device fw version in form of x.y.z
  final String firmware;

  DiscoveryResponse(
    this.address,
    this.mac,
    this.code,
    this.serial,
    this.firmware,
  );
}
