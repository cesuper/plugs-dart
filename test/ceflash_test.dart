// ignore_for_file: avoid_print

import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/ceflash/bootp_server.dart';
import 'package:plugs/ceflash/ceflash.dart';
import 'package:plugs/ceflash/magic_packet.dart';
import 'package:plugs/discovery.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// system local address
final localAddress = InternetAddress('192.168.100.118');

// firmware path
const path = 'assets/sfp9-r2-1.7.1.bin';

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

  test('Magic packet', () async {
    // Target is expected to be in App mode and ready to accept the magic
    // packet. No response is expected, but the device must restart itself
    // in bootloader mode
    //
    // To see device in bootloader mode use wireshark with filter: 'bootp'
    //
    // Test pass when bootp request arrived and verified from the device selected

    // target mac address to run the test on
    const targetMac = '08-00-28-5a-8f-a1';

    // get available devices
    final devices = await Discovery.discover(localAddress);

    // find device
    final device =
        devices.entries.firstWhere((element) => element.value.mac == targetMac);

    // target address
    final targetAddress = InternetAddress(device.key);

    // send magic packet to the target
    await MagicPacket.send(localAddress, targetAddress, logLevel: Level.debug);

    // device in bootloader mode sends information about itself, that is verified
    final result = await BootpServer.waitForBootpPacket(
      localAddress,
      targetAddress,
      targetMac,
    );

    // test pass when bootp request arrived and verified
    expect(result, true);

    //
    print('Power cycle the $targetAddress plug to return in App mode');
  });

  test('Bootloader mode', () async {
    // target mac address to be flashed
    const targetMac = '94-fb-a7-51-00-8c';

    // ip address to assign to the target for the duration of flashing
    const targetAddress = '192.168.100.109';

    // Target is expected to be in Bootloader mode and periodically
    // sendins BOOTP requests indicating the device is ready to update itself
    // with the new firmware
    var result = await CeFlash.update(
      localAddress,
      InternetAddress(targetAddress),
      targetMac,
      firmware,
      magicPacket: false,
      timeout: const Duration(seconds: 5),
      logLevel: Level.debug,
    );

    //
    print(result);
  });

  test('App mode', () async {
    // Target is expected to be in App mode, waiting for magic packet to
    // boot in bootloader mode to accept the firmware.

    // target mac address to run the test on
    const targetMac = '08-00-28-5a-8f-a1';

    // get available devices
    final devices = await Discovery.discover(localAddress);

    // find device
    final device =
        devices.entries.firstWhere((element) => element.value.mac == targetMac);

    // target address
    final targetAddress = InternetAddress(device.key);

    var result = await CeFlash.update(
      localAddress,
      targetAddress,
      targetMac,
      firmware,
      magicPacket: true,
      timeout: const Duration(seconds: 5),
      logLevel: Level.debug,
    );

    //
    print(result);
  });
}
