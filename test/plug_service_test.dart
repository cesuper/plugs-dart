import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/service/plug_service.dart';
import 'package:test/scaffolding.dart';

//
final localAddress = InternetAddress(
  '192.168.100.118',
  type: InternetAddressType.IPv4,
);

//
final logger = Logger();

void main() async {
  test('', () async {
    // create and start service
    var service = PlugService(
      localAddress,
      onConnected: (plugs) {
        for (var element in plugs) {
          // ignore: avoid_print
          print(
              'Connected: ${element.hardware.serial} : ${element.network.ip}');
        }
      },
      onDisconnected: (plugs) {
        for (var element in plugs) {
          // ignore: avoid_print
          print(
              'Disconnected: ${element.hardware.serial} : ${element.network.ip}');
        }
      },
    )..start();

    //
    await Future.delayed(const Duration(seconds: 45));
  }, timeout: const Timeout(Duration(seconds: 50)));
}
