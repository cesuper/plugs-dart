import 'package:plugs/plug/Plug.dart';
import 'package:plugs/socket/SocketDeviceConnectData.dart';
import 'package:test/test.dart';

void main() async {
  var plug = Plug('192.168.100.111:8080');
  var socket = plug.socket;

  test('Socket', () async {
    // here we expect only response
    await socket.addresses();
  });

  test('Connect', () {});

  // group('Restart', () {
  //   test('Restart', () async {
  //     expect(await plug.restart(), 200);
  //   });

  //   test('Bootloader', () async {
  //     expect(await plug.bootloader(), 200);
  //   });
  // });
}
