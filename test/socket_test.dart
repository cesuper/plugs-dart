// ignore_for_file: avoid_print

import 'package:plugs/plugs/plug/plug.dart';
import 'package:test/scaffolding.dart';

void main() async {
  var plug = Plug('192.168.100.101');
  var socket = plug.socket;

  test('addresses', () async {
    print(await socket.addresses());
  });

  test('Memory', () async {
    final memory = await socket.getMemory();

    print(memory);
    print(memory.isConnected);
  });

  test('Read Socket Memory', () async {
    final content = await socket.readMemory();
    print(content);
  });
}
