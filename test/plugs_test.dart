import 'dart:convert';

import 'package:plugs/plug/Plug.dart';
import 'package:test/test.dart';

void main() async {
  var plug = Plug('192.168.100.111:8080');

  test('Info', () async {
    // here we expect only response
    await plug.readPlug();
  });

  group('Restart', () {
    test('Restart', () async {
      expect(await plug.restart(), 200);
    });

    test('Bootloader', () async {
      expect(await plug.bootloader(), 200);
    });
  });

  group('EEPROM', () {
    test('Invalid json', () async {
      // dummy string
      var content = 'ThisIsMyNonJsonString';

      // here we do not encode our string to json

      // write eeprom
      var code = await plug.writeEEPROM(content);

      // expect error code
      expect(code, 403);
    });

    test('Invalid json - String', () async {
      // dummy string
      var content = 'ThisIsMyNonJsonString';

      // encode to json string
      var jContent = jsonEncode(content);

      // write eeprom
      var code = await plug.writeEEPROM(jContent);

      // expect success
      expect(code, 200);
    });
    test('Valid json - object', () async {
      // get the actual network values
      var info = await plug.readPlug();

      // encode to json string
      var content = info.network.toJson();

      // write eeprom
      var code = await plug.writeEEPROM(content);

      // expect success
      expect(code, 200);

      // read it back
      expect(await plug.readEEPROM(), content);
    });
  });
}
