// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  final client = PlugClient('http://192.168.100.101');
  final socketApi = client.getSocketApi();

  test('Read Memory', () async {
    final content = await socketApi.readMemory();
    print(content == null);
  });

  test('Write Memory - 1', () async {
    final map = {
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

    await socketApi.writeMemory(map);
  });

  test('Write Memory - 2', () async {
    final map = {
      "glossary": {
        "title": "example glossary",
        "GlossDiv": {
          "title": "S",
          "GlossList": {
            "GlossEntry": {
              "ID": "SGML",
              "SortAs": "SGML",
              "GlossTerm": "Standard Generalized Markup Language",
              "Acronym": "SGML",
              "Abbrev": "ISO 8879:1986",
              "GlossDef": {
                "para":
                    "A meta-markup language, used to create markup languages such as DocBook.",
                "GlossSeeAlso": ["GML", "XML"]
              },
              "GlossSee": "markup"
            }
          }
        }
      }
    };

    await socketApi.writeMemory(map);
  });
}
