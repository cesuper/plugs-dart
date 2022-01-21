// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  final client = PlugClient('http://192.168.100.101');
  final plugApi = client.getPlugApi();

  test('Info', () async {
    final info = await plugApi.getInfo();
    print(info);

    final socket = info.socket;
    print(socket.memory?.content);
  });

  test('Reboot', () async {
    await plugApi.restart(bootloader: false);
  });

  test('Bootloader', () async {
    await plugApi.restart(bootloader: true);
  });

  // test('Diagnostic', () async {
  //   // here we expect only response
  //   print(await plug.diagnostic());
  // });
}
