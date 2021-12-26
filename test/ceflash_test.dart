// ignore_for_file: avoid_print

import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/ceflash/bootp_server.dart';
import 'package:plugs/ceflash/ceflash.dart';
import 'package:plugs/ceflash/magic_packet.dart';
import 'package:test/scaffolding.dart';

// local address
final localAddress =
    InternetAddress('192.168.100.118', type: InternetAddressType.IPv4);

// target ip address
final remoteAddress =
    InternetAddress('192.168.100.101', type: InternetAddressType.IPv4);

// launchpad
//final remoteMac = <int>[0x94, 0xFB, 0xA7, 0x51, 0x00, 0x8C];

// 94-FB-A7-51-00-3B
final remoteMac = <int>[0x94, 0xFB, 0xA7, 0x51, 0x00, 0x3B];

// 94-FB-A7-51-00-8C
//final remoteMac = <int>[0x94, 0xFB, 0xA7, 0x51, 0x00, 0x8C];

// firmware path
const path = 'assets/sfp9-r2-1.4.1.bin';

const bootpRequestTimeout = Duration(seconds: 25);
const tftpRequestTimmeout = Duration(seconds: 10);
const tftpDataRequestTimeout = Duration(seconds: 10);

void main() async {
  final file = File(Directory.current.path + '/' + path);
  final filename = file.uri.pathSegments.last;
  final firmware = await file.readAsBytes();

  test('file check', () {
    //
    final result = CeFlash.checkFilenameFormat(filename);
    print(result);
  });

  test('magic packet', () async {
    //
    await MagicPacket.send(
      localAddress,
      remoteAddress,
      logLevel: Level.debug,
    );
  });

  test('update by mac', () async {
    //
    var result = await CeFlash.update(
      localAddress,
      remoteAddress,
      remoteMac,
      firmware,
      timeout: const Duration(seconds: 5),
      logLevel: Level.debug,
    );

    //
    print(result);
  });
}
