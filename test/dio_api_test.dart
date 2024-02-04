// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  final client = PlugClient('http://192.168.1.184');
  final plugApi = client.getPlugApi();
  final dioApi = client.getDioApi();

  test('Inputs', () async {
    await plugApi.restart(bootloader: true);
  });

  test('Start - Stop pin', () async {
    //
    const index = 3;
    const delay = Duration(seconds: 0);
    const timeout = Duration(seconds: 5);

    //
    await dioApi.startPin(index, timeout, delay: delay);

    //
    await Future.delayed(const Duration(seconds: 2));

    //
    //await dioApi.stopPin(index);

    final state = await plugApi.getState();
    print(state);
  });
}
