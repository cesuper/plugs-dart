// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  final client = PlugClient('http://192.168.1.184');
  final plugApi = client.getPlugApi();

  test('PlugState', () async {
    final state = await plugApi.getState();
    print(state);
  });

  test('Reboot', () async {
    await plugApi.restart(bootloader: false);
  }, skip: true);

  test('Bootloader', () async {
    await plugApi.restart(bootloader: true);
  }, skip: true);
}
