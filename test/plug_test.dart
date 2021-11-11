// ignore_for_file: avoid_print

import 'package:plugs/plug/plug.dart';
import 'package:test/test.dart';

void main() async {
  var plug = Plug('192.168.100.110:80');

  test('Info', () async {
    // here we expect only response
    print(await plug.info());
  });

  test('Diagnostic', () async {
    // here we expect only response
    print(await plug.diagnostic());
  });

//   group('Restart', () {
//     test('Restart', () async {
//       expect(await plug.restart(), 200);
//     });

//     test('Bootloader', () async {
//       expect(await plug.restart(bootloader: true), 200);
//     });
//   }, skip: true);

//   group('EEPROM', () {
//     test('Invalid json', () async {
//       // dummy string
//       var content = 'ThisIsMyNonJsonString';

//       // here we do not encode our string to json

//       // write eeprom
//       var code = await plug.writeEEPROM(content);

//       // expect error code
//       expect(code, 403);
//     }, skip: true);

//     test('Invalid json - String', () async {
//       // dummy string
//       var content = 'ThisIsMyNonJsonString';

//       // encode to json string
//       var jContent = jsonEncode(content);

//       // write eeprom
//       var code = await plug.writeEEPROM(jContent);

//       // expect success
//       expect(code, 200);
//     }, skip: true);
//     test('Valid json - object', () async {
//       // get the actual network values
//       var info = await plug.info();

//       // encode to json string
//       var content = info.network.toJson();

//       // write eeprom
//       var code = await plug.writeEEPROM(content);

//       // expect success
//       expect(code, 200);

//       // read it back
//       expect(await plug.readEEPROM(), content);
//     }, skip: true);
//   });
}
