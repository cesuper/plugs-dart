import 'dart:convert';

import 'Diagnostic.dart';
import 'Firmware.dart';
import 'Network.dart';
import 'Product.dart';

class Info {
  // elapsed time since boot
  final int uptime;

  final int session;

  // product
  final Product product;

  // firmware
  final Firmware firmware;

  // diagnostic
  final Diagnostic diagnostic;

  // network
  final Network network;

  // socket
  //final List<String> socket;

  Info(
    this.uptime,
    this.session,
    this.product,
    this.firmware,
    this.diagnostic,
    this.network,

    // this.socket,
  );

  Map<String, dynamic> toMap() {
    return {
      'uptime': uptime,
      'session': session,
      'product': product.toMap(),
      'firmware': firmware.toMap(),
      'diagnostic': diagnostic.toMap(),
      'network': network.toMap(),
      //'socket': socket,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
        map['uptime'],
        map['session'],
        Product.fromMap(map['product']),
        Firmware.fromMap(map['firmware']),
        Diagnostic.fromMap(map['diagnostic']),
        Network.fromMap(map['network']));
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Info(uptime: $uptime, session: $session, product: $product, firmware: $firmware, diagnostic: $diagnostic, network: $network)';
  }
}
