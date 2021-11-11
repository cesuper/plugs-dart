// ignore_for_file: avoid_print

import 'package:plugs/plug/plug.dart';
import 'package:test/scaffolding.dart';

void main() async {
  var plug = Plug('192.168.100.105:80');
  var socket = plug.socket;

  test('addresses', () async {
    print(await socket.addresses());
  });

  test('Read all devices', () async {
    // get all addresses and filter for 43 devices
    var addresses = await socket.addresses()
      ..where((element) => element.startsWith('43'));

    for (var address in addresses) {
      var h43 = await socket.readH43(address);
      print(h43);
    }
  });
}
