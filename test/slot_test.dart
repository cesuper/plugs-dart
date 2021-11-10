import 'dart:io';

import 'package:plugs/slot/slot.dart';
import 'package:test/scaffolding.dart';

final localAddress = InternetAddress(
  '192.168.100.118',
  type: InternetAddressType.IPv4,
);

final remoteAddress =
    InternetAddress('192.168.100.110', type: InternetAddressType.IPv4);

void main() {
  test('', () async {
    // create slot
    var slot = CpSlot(remoteAddress, localAddress);

    // open slot
    slot.open();

    // wait
    await Future.delayed(const Duration(minutes: 5));

    // close
    slot.close();
  }, timeout: const Timeout(Duration(minutes: 10)));
}
