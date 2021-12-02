// ignore_for_file: avoid_print

import 'dart:io';

import 'package:plugs/discovery.dart';

void main() async {
  //
  var destinationAddress = InternetAddress("192.168.100.255");

  var devices = await Discovery.discover(
    InternetAddress('192.168.100.118', type: InternetAddressType.IPv4),
    const Duration(seconds: 2),
  );

  print(devices.length);
}
