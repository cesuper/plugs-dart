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
    Duration timeout = const Duration(seconds: 5),
    Level logLevel = Level.error,
  }) async {
    //
    bool isCompleted = false;

    var fw = await firmware.readAsBytes();

    //
    await BootpServer.waitForBootpPacket(
      localAddress,
      remoteAddress,
      remoteMac,
      timeout,
      logLevel: logLevel,
    ).then((isTargetExists) async {
      if (isTargetExists) {
        await TftpServer.waitForTftpRrq(
          localAddress,
          timeout,
          logLevel: logLevel,
        );
      } else {
        isCompleted = false;
      }
    }).then((value) async {
      await TftpDataServer.transfer(
        localAddress,
        remoteAddress,
        timeout,
        fw,
        logLevel: logLevel,
      ).then((value) {
        isCompleted = value;
      });
    });

    //
    return isCompleted;
  }
}
