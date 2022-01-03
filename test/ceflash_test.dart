// ignore_for_file: avoid_print

import 'dart:io';

import 'package:logger/logger.dart';
import 'package:plugs/ceflash/bootp_server.dart';
import 'package:plugs/ceflash/ceflash.dart';
import 'package:plugs/ceflash/magic_packet.dart';
import 'package:plugs/discovery/discovery.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

// system local address
final localAddress = InternetAddress('192.168.100.118');

// firmware path
const path = 'assets/sfp9-r2-1.7.1.bin';

void main() async {
  final file = File(Directory.current.path + '/' + path);
  final filename = file.uri.pathSegments.last;
  final firmware = await file.readAsBytes();

  test('file check', () {
    //
    final result = CeFlash.isValidFirmware(filename);
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
        devices.firstWhere((element) => element.info.mac == targetMac);

    // target address
    final targetAddress = InternetAddress(device.address);

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
    // Target is expected to be in Bootloader mode and periodically
    // sendins BOOTP requests indicating the device is ready to update itself
    // with the new firmware

    // target mac address to be flashed
    const targetMac = '94-fb-a7-51-00-8c';

    // ip address to assign to the target for the duration of flashing
    const targetAddress = '192.168.100.109';

    //
    var result = await CeFlash.unsafeFlash(
      localAddress,
      InternetAddress(targetAddress),
      targetMac,
      firmware,
      magicPacket: false,
      timeout: const Duration(seconds: 5),
      logLevel: Level.debug,
    );

    // test pass when result is true
    expect(result, true);
  });

  test('Unasafe flash', () async {
    // Target is expected to be in App mode, waiting for magic packet to
    // restart itself in bootloader mode to accept the firmware.
    // Test pass when device is available on the network after the flashing

    // target mac address to run the test on
    const targetMac = '94-fb-a7-51-00-8c';

    // get available devices
    var devices = await Discovery.discover(localAddress);

    // find device
    var device = devices.firstWhere((element) => element.info.mac == targetMac);

    // get the address of the target
    final targetAddress = InternetAddress(device.address);

    // flash
    var result = await CeFlash.unsafeFlash(
      localAddress,
      targetAddress,
      targetMac,
      firmware,
      magicPacket: true,
      timeout: const Duration(seconds: 5),
      logLevel: Level.debug,
    );

    // wait for a target to reboots itelf and receive ip address
    await Future.delayed(const Duration(seconds: 5));

    // run the discovery again and verify the presence of the device updated
    devices = await Discovery.discover(localAddress);

    // find device again
    device = devices.firstWhere((element) => element.info.mac == targetMac);

    // match mac
    expect(targetMac, device.info.mac);

    // TODO: match the firmware version

    //
    print(result);
  });

  test('Flash', () async {
    //
    const mac = '94-fb-a7-51-00-3b';

    //
    await CeFlash.flash(localAddress, mac, path);
  });
}
