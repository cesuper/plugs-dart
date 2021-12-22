// ignore_for_file: avoid_print

import 'dart:io';
import 'package:plugs/discovery/discovery.dart';
import 'package:test/scaffolding.dart';

final localAddress = InternetAddress(
  '192.168.100.118',
  type: InternetAddressType.IPv4,
);

void main() async {
  //
  final discovery = Discovery(localAddress);

  test('Simple', () async {
    //
    final result = await discovery.discover();

    // print found
    for (var info in result) {
      print(info.address);
    }
  });

  test('Continuous', () async {
    //
    const int sec = 15;
    print('Service Started for $sec seconds');

    //
    discovery.start((info, isConnected) =>
        print(info.address + (isConnected ? ' Connected' : ' Removed')));

    // wait for device changes
    await Future.delayed(const Duration(seconds: sec));

    //
    print('Service Stopped');

    //
    discovery.stop();

    //
  }, timeout: const Timeout(Duration(seconds: 25)));
}
