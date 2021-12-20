// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:plugs/plugs/plug/plug.dart';
import 'package:plugs/service/event.dart';
import 'package:test/test.dart';

// test timeout
const duration = Duration(seconds: 45);

const delay = Duration(seconds: 40);

void main() async {
  //
  final plug = Plug('192.168.100.101');

  final sourceAddress = InternetAddress('192.168.100.118');
  //
  StreamController<Event> ctrl = StreamController();

  ctrl.stream.listen((event) {
    print(event);
  });

  test('', () async {
    //
    plug.connect(
      sourceAddress,
      onDisconnected: (plug, code) => print('${plug.address} disconnected'),
      onEvent: (plug, code) => print('${plug.address} event: $code'),
      onError: (plug, e, trace) => print(e),
    );

    //
    await Future.delayed(const Duration(seconds: 5));
    print('closing');

    //
    plug.close();

    await Future.delayed(delay);
  }, timeout: const Timeout(duration));
}
