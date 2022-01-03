// ignore_for_file: avoid_print

import 'dart:io';
import 'package:plugs/discovery/discovery.dart';
import 'package:test/scaffolding.dart';

final localAddress = InternetAddress(
  '192.168.100.118',
  type: InternetAddressType.IPv4,
);

void main() async {
  test('discovery', () async {
    //
    final result = await Discovery.discover(localAddress);

    for (var device in result) {
      //
      print(device.toString());
    }
  });
}
