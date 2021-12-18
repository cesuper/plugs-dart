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
    var service = PlugService(localAddress)..start();

    //
  });
}
