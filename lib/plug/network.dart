import 'dart:convert';

class Network {
  //
  final bool dhcp;

  //
  final String ip;

  //
  final String mask;

  //
  final String gateway;

  //
  final String dns;

  Network(this.dhcp, this.ip, this.mask, this.gateway, this.dns);

  Map<String, dynamic> toMap() {
    return {
      'dhcp': dhcp,
      'ip': ip,
      'mask': mask,
      'gateway': gateway,
      'dns': dns,
    };
  }

  factory Network.fromMap(Map<String, dynamic> map) {
    return Network(
      map['dhcp'],
      map['ip'],
      map['mask'],
      map['gateway'],
      map['dns'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Network.fromJson(String source) =>
      Network.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Network(dhcp: $dhcp, ip: $ip, mask: $mask, gateway: $gateway, dns: $dns)';
  }
}
