// ignore_for_file: avoid_print

import 'dart:io';
import 'package:plugs/discovery/discovery.dart';
import 'package:plugs/listener.dart';

import 'package:test/scaffolding.dart';

//
const timeout = Duration(seconds: 50);

//
final localAddress =
    InternetAddress('192.168.1.59', type: InternetAddressType.IPv4);

void main() async {
  //
  final result = await Discovery.discover(localAddress);

  test('listen test', () async {
    // fire discovered event for all devices found
    for (var address in result) {
      print('$address - PLUG_DISCOVERED');
    }

    // create listener for all devices discovered
    final listeners = result.map((e) => Listener(e.address));

    // start listening
    for (var listener in listeners) {
      //
      listener.connect(
        localAddress,
        onDisconnected: (address) => print('disconnected'),
        onEvent: (address, code) =>
            print('$address - ${Listener.getName(code)}'),
      );
    }

    //
    print('Waiting for events...');

    //
    await Future.delayed(const Duration(seconds: 35));

    // close listeners
    for (var listener in listeners) {
      listener.close();
    }
  }, timeout: const Timeout(timeout));
}
