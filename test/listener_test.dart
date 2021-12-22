import 'dart:io';
import 'package:plugs/discovery.dart';
import 'package:plugs/listener.dart';

import 'package:test/scaffolding.dart';

//
const timeout = Duration(seconds: 50);

//
final localAddress = InternetAddress('192.168.100.118');

void main() async {
  //
  final discovery = Discovery(localAddress);

  test('listen test', () async {
    // get devices
    final devices = await discovery.discover();

    //
    for (var device in devices) {
      print(device.software.toString());
    }

    // create listener for all devices discovered
    final listeners = devices.map((e) => Listener(e.network.ip)).toList();

    // listen for changes
    for (var listener in listeners) {
      //

      //
      listener.connect(
        localAddress,
        onStateChanged: (address, isConnected) {
          print(address + (isConnected ? ' Connected' : ' Removed'));
        },
        onEvent: (address, code) {
          print(address + ': $code');
        },
        onError: (address, error) {
          print(address + ': $error');
        },
      );
    }

    //
    print('Waiting for events...');

    //
    await Future.delayed(const Duration(seconds: 35));
  }, timeout: const Timeout(timeout));
}
