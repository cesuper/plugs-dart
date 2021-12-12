// ignore_for_file: avoid_print

import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/ceflash/bootp_server.dart';
import 'package:plugs/ceflash/ceflash.dart';
import 'package:plugs/plug/plug.dart';
import 'package:test/scaffolding.dart';

// local address
final localAddress =
    InternetAddress('192.168.100.118', type: InternetAddressType.IPv4);

// target ip address
final remoteAddress =
    InternetAddress('192.168.100.100', type: InternetAddressType.IPv4);

// target mac address
//final remoteMac = <int>[0x94, 0xFB, 0xA7, 0x51, 0x00, 0x8C];
final remoteMac = <int>[0x08, 0x00, 0x28, 0x5A, 0x8F, 0xCB];

// firmware path
//const path = 'assets/sfp9-r2-1.0.0.bin';
const path = 'assets/tcpEcho_EK_TM4C129EXL_TI.bin';

const bootpRequestTimeout = Duration(seconds: 25);
const tftpRequestTimmeout = Duration(seconds: 10);
const tftpDataRequestTimeout = Duration(seconds: 10);

void main() async {
  test('ceflash test', () async {
    //
    //var plug = Plug('192.168.100.100');

    //
    //plug.restart(bootloader: true);

    //
    var firmware = File(Directory.current.path + '/' + path);

    //
    var result = await CeFlash.update(
      localAddress,
      remoteAddress,
      remoteMac,
      firmware,
      bootpServerPort: BootpServer.serverPort + 1000,
      bootpClientPort: BootpServer.clientPort + 1000,
      timeout: const Duration(seconds: 5),
      logLevel: Level.debug,
    );

    //
    print(result);
  });
}
