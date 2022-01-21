// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  var client = PlugClient('http://192.168.100.101');

  test('Device', () async {
    //
    final deviceApi = client.getDeviceApi();
    final info = await deviceApi.getInfo();
    print(info);

    final socket = info.socket;
    print(socket.memory?.content);
  });

  // test('Diagnostic', () async {
  //   // here we expect only response
  //   print(await plug.diagnostic());
  // });

  // test('Restart', () async {
  //   expect(await plug.restart(), 200);
  // });

  // test('Bootloader', () async {
  //   expect(await plug.restart(bootloader: true), 200);
  // });
}
