// ignore_for_file: avoid_print

import 'dart:io';

import 'package:plugs/discovery/discovery.dart';

void main() async {
  var devices = await Discovery.discover(
    InternetAddress('192.168.100.118', type: InternetAddressType.IPv4),
    timeout: const Duration(seconds: 2),
  );

  for (var item in devices) {
    print(item.network.ip);
  }
}
