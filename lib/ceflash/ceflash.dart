import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:plugs/ceflash/magic_packet.dart';

import 'bootp_server.dart';
import 'tftp_data_server.dart';
import 'tftp_server.dart';

class CeFlash {
  /// Function returns true when the provided filename has valid format
  /// Filename has valid format when the device and firmware version can be
  /// extracted from it.
  static bool checkFilename(String filename) {
    // check extension
    if (filename.split('.').last != 'bin') return false;

    // splist to  segments
    final segments = filename.split('-');

    // check segments length
    if (segments.length != 3) return false;

    // check family+model, must have at least 3 char
    if (segments[0].length < 3) return false;

    // check rev segments, starts with r
    if (!segments[1].startsWith('r')) return false;

    // check fw segment for major, minor, fix and file extension
    if (segments[2].split('.').length != 4) return false;

    return true;
  }

  ///
  /// [localAddress] interface address where devices expected to be
  /// [remoteAddress] target ip address
  /// [remoteMac] target mac address
  /// [firmware] firmware file
  /// [timeout] operation timeout, default 5 sec
  /// [useMagicPacket] sends an upd magic packet to initiate bootloader mode for device
  /// with address [remoteAddress]
  static Future<bool> update(
    InternetAddress localAddress,
    InternetAddress remoteAddress,
    List<int> remoteMac,
    Uint8List firmware, {
    bool useMagicPacket = true,
    int bootpServerPort = BootpServer.serverPort,
    int bootpClientPort = BootpServer.clientPort,
    Duration timeout = const Duration(seconds: 5),
    Level logLevel = Level.error,
  }) async {
    //
    if (useMagicPacket) {
      // Sends a magic packet and wait for response. Not all devices send response
      // for magic packet
      await MagicPacket.send(localAddress, remoteAddress, logLevel: logLevel);
    }

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
          firmware,
          logLevel: logLevel,
        )) {
          return true;
        }
      }
    }

    return false;
  }
}
