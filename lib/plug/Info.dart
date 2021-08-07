import 'dart:convert';

import 'Diagnostic.dart';
import 'Firmware.dart';
import 'GroupMember.dart';
import 'Product.dart';

class Info {
  // elapsed time since boot
  final int uptime;

  // product
  final Product product;

  // firmware
  final Firmware firmware;

  // diagnostic
  final Diagnostic diagnostic;

  // group
  final GroupMember group;

  // socket
  final List<String> socket;

  Info(
    this.uptime,
    this.product,
    this.firmware,
    this.diagnostic,
    this.group,
    this.socket,
  );

  Map<String, dynamic> toMap() {
    return {
      'uptime': uptime,
      'product': product.toMap(),
      'firmware': firmware.toMap(),
      'diagnostic': diagnostic.toMap(),
      'group': group.toMap(),
      'socket': socket,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
        map['uptime'],
        Product.fromMap(map['product']),
        Firmware.fromMap(map['firmware']),
        Diagnostic.fromMap(map['diagnostic']),
        GroupMember.fromMap(map['group']),
        List<String>.from(map['socket']));
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) => Info.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Info(uptime: $uptime, product: $product, firmware: $firmware, diagnostic: $diagnostic, group: $group, socket: $socket)';
  }
}
