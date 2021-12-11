// ignore_for_file: avoid_print

import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/ceflash/bootp_server.dart';
import 'package:plugs/ceflash/tftp_data_server.dart';
import 'package:plugs/ceflash/tftp_server.dart';

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
  //
  var file = await File(Directory.current.path + '/' + path).readAsBytes();
  print(file.length);

  //
  await BootpServer.waitForBootpPacket(
    localAddress,
    remoteAddress,
    remoteMac,
    bootpRequestTimeout,
    logLevel: Level.info,
  ).then((isTargetExists) async {
    await TftpServer.waitForTftpRrq(
      localAddress,
      tftpRequestTimmeout,
      logLevel: Level.info,
    );
  }).then((value) async {
    await TftpDataServer.transfer(
      localAddress,
      remoteAddress,
      tftpDataRequestTimeout,
      file,
      logLevel: Level.debug,
    ).then((value) {
      print(value);
    });
  });
}
