import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/service/event_service.dart';
import 'package:test/scaffolding.dart';

//
final localAddress = InternetAddress(
  '192.168.100.118',
  type: InternetAddressType.IPv4,
);

//
final logger = Logger();

//
const period = Duration(seconds: 2);

void main() async {
  test('', () async {
    // create and start service
    var service = EventService(localAddress, period: period)..start();

    service.eventStream.stream.listen((event) {
      print(event);
    });

    //
    await Future.delayed(const Duration(seconds: 45));
  }, timeout: const Timeout(Duration(seconds: 50)));
}
