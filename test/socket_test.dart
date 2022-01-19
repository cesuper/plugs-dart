// ignore_for_file: avoid_print

import 'package:plugs/plugs/plug/plug.dart';
import 'package:test/scaffolding.dart';

void main() async {
  var plug = Plug('192.168.100.101');
  var socket = plug.socket;

  test('Socket', () async {
    print(await socket.getSocket());
  });

  test('Read Socket Memory', () async {
    final content = await socket.readMemory();
    print(content);
  });

  test('Write Socket Memory', () async {
    final map = <String, dynamic>{
      "sensors": [
        {
          "serial": "994559880194600012",
          "name": "Channel 1",
          "group": "",
          "dir": ""
        },
        {
          "serial": "994559880192100003",
          "name": "Channel 2",
          "group": "",
          "dir": ""
        },
        {
          "serial": "994559880185000035",
          "name": "Channel 3",
          "group": "",
          "dir": ""
        },
        {
          "serial": "994559880192100021",
          "name": "Channel 4",
          "group": "",
          "dir": ""
        }
      ]
    };

    final content = await socket.writeMemory(map);
  });
}
