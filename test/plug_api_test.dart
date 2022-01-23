// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  final client = PlugClient('http://192.168.100.101');
  final plugApi = client.getPlugApi();

  test('Plug', () async {
    final state = await plugApi.getState();
    print(state);
  });

  test('Reboot', () async {
    await plugApi.restart(bootloader: false);
  }, skip: true);

  test('Bootloader', () async {
    await plugApi.restart(bootloader: true);
  }, skip: true);

  // test('Diagnostic', () async {
  //   // here we expect only response
  //   print(await plug.diagnostic());
  // });
}
