import 'dart:io';

import 'package:logger/logger.dart';

import 'bootp_server.dart';
import 'tftp_data_server.dart';
import 'tftp_server.dart';

class CeFlash {
  ///
  /// [localAddress] interface address where devices expected to be
  /// [remoteAddress] target ip address
  /// [remoteMac] target mac address
  /// [firmware] firmware file
  /// [timeout] operation timeout, default 5 sec
  static Future<bool> update(
    InternetAddress localAddress,
    InternetAddress remoteAddress,
    List<int> remoteMac,
    File firmware, {
    int bootpServerPort = BootpServer.serverPort,
    int bootpClientPort = BootpServer.clientPort,
    Duration timeout = const Duration(seconds: 5),
    Level logLevel = Level.error,
  }) async {
    //
    var fw = await firmware.readAsBytes();

    // check if client exists
    if (await BootpServer.waitForBootpPacket(
        localAddress, remoteAddress, remoteMac, timeout,
        serverPort: bootpServerPort,
        clientPort: bootpClientPort,
        logLevel: logLevel)) {
      // check if valid RRQ arrived
      if (await TftpServer.waitForTftpRrq(
        localAddress,
        timeout,
        logLevel: logLevel,
      )) {
        // check if transfer completed
        if (await TftpDataServer.transfer(
          localAddress,
          remoteAddress,
          timeout,
          fw,
          logLevel: logLevel,
        )) {
          return true;
        }
      }
    }

    return false;
  }
}
