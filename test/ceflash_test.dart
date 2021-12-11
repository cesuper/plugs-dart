// ignore_for_file: avoid_print

import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/ceflash/bootp_server.dart';
import 'package:plugs/ceflash/ceflash.dart';
import 'package:plugs/ceflash/tftp_data_server.dart';
import 'package:plugs/ceflash/tftp_server.dart';
import 'package:test/scaffolding.dart';

// local address
final localAddress =
    InternetAddress('192.168.100.118', type: InternetAddressType.IPv4);

// target ip address
final remoteAddress =
    InternetAddress('192.168.100.47', type: InternetAddressType.IPv4);

// target mac address
final remoteMac = <int>[0x08, 0x00, 0x28, 0x5a, 0x8f, 0xcb];

// firmware path
const path = 'assets/tcpEcho_EK_TM4C129EXL_TI.bin';

const bootpRequestTimeout = Duration(seconds: 25);
const tftpRequestTimmeout = Duration(seconds: 10);
const tftpDataRequestTimeout = Duration(seconds: 10);

void main() async {
  test('ceflash test', () async {
    //
    var firmware = File(Directory.current.path + '/' + path);

    //
    var result = await CeFlash.update(
      localAddress,
      remoteAddress,
      remoteMac,
      firmware,
      logLevel: Level.info,
    );

    //
    print(result);
  });
}
