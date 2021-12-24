// ignore_for_file: avoid_print

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
  final result = await Discovery.discover(localAddress);

  test('listen test', () async {
    // fire discovered event for all devices found
    for (var address in result.keys) {
      print('$address - PLUG_DISCOVERED');
    }

    // create listener for all devices discovered
    final listeners = result.keys.map((e) => Listener(e));

    // start listening
    for (var listener in listeners) {
      //
      listener.connect(
        localAddress,
        onEvent: (address, code, name) =>
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
