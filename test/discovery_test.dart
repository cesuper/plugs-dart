// ignore_for_file: avoid_print

import 'dart:io';
import 'package:plugs/discovery.dart';
import 'package:test/scaffolding.dart';

final localAddress = InternetAddress(
  '192.168.100.118',
  type: InternetAddressType.IPv4,
);

void main() async {
  test('Simple', () async {
    //
    final service = Discovery(localAddress);
    final result = await service.discover();

    // print found
    for (var device in result) {
      print(device.network.ip);
    }
  });

  test('Service', () async {
    //
    final service = Discovery(
      localAddress,
      onStateChanged: (info, isConnected) =>
          print(info.network.ip + (isConnected ? ' Connected' : ' Removed')),
    );
    print('Service Started');
    service.start();
    await Future.delayed(const Duration(seconds: 20));
    print('Service Stopped');
    service.stop();
  }, timeout: const Timeout(Duration(seconds: 25)));
}
