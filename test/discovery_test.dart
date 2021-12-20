// ignore_for_file: avoid_print

import 'dart:io';
import 'package:plugs/discovery/discovery.dart';
import 'package:plugs/discovery/discovery_service.dart';
import 'package:test/scaffolding.dart';

final localAddress =
    InternetAddress('192.168.100.118', type: InternetAddressType.IPv4);

void main() async {
  test('Function', () async {
    //
    var devices = await Discovery.discover(localAddress);

    // print found
    for (var device in devices) {
      print(device.network.ip);
    }
  });

  test('Service', () async {
    //
    var service = DiscoveryService(
      localAddress,
      onStateChanged: (info, isConnected) =>
          print('${info.network.ip} $isConnected'),
    );

    // start service
    service.start();

    await Future.delayed(const Duration(seconds: 25));
  });
}
