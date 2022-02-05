// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  final client = PlugClient('http://192.168.100.100');
  final scpApi = client.getScpApi();

  test('State', () async {
    final state = await scpApi.getState();
    print(state);
  });

  test('Start - Stop pin', () async {
    const index = 0;
    const delay = Duration(seconds: 1);
    const timeout = Duration(seconds: 5);

    //
    await scpApi.startPin(index, timeout, delay: delay);

    //
    await Future.delayed(const Duration(seconds: 2));

    //
    await scpApi.stopPin(index);

    final state = await scpApi.getState();
    print(state);
  });
}
