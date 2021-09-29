// ignore_for_file: file_names
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

  //
  final String sntp;

  Network(this.dhcp, this.ip, this.mask, this.gateway, this.dns, this.sntp);

  Map<String, dynamic> toMap() {
    return {
      'dhcp': dhcp,
      'ip': ip,
      'mask': mask,
      'gateway': gateway,
      'dns': dns,
      'sntp': sntp,
    };
  }

  factory Network.fromMap(Map<String, dynamic> map) {
    return Network(
      map['dhcp'],
      map['ip'],
      map['mask'],
      map['gateway'],
      map['dns'],
      map['sntp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Network.fromJson(String source) =>
      Network.fromMap(json.decode(source));
}
