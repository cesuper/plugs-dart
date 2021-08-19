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

  group('DS28EC20', () {
    test('DS28EC20 - Basic R/W', () async {
      // remove the socket
      await socket.remove();

      // create simulated device
      var connectData = <SocketDeviceConnectData>[
        SocketDeviceConnectData('43F4704001000008', 'MyOriginalData'),
        SocketDeviceConnectData('43F4704001000009', '123'),
        SocketDeviceConnectData('43F4704001000010', '12312321321'),
      ];

      // connect simulated devices
      expect(await socket.connect(connectData), 200);

      // get all ds28ec20 addresses
      var devices = await socket.addresses(family: '43');

      // read back the data
      var content = await socket.h43Data(devices);

      expect(content.map((e) => e.content),
          equals(connectData.map((e) => e.data)));

      // remove socket
      await socket.remove();
    });
  });
}
