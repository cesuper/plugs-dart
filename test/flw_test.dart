import 'package:plugs/flw/flw_plug.dart';
import 'package:plugs/flw/flw_sensor.dart';
import 'package:plugs/flw/flw_socket_content.dart';
import 'package:test/test.dart';

final defaultSensors = <FlwSensor>[
  FlwSensor('994559880192100081', 'Channel 1'),
  FlwSensor('994559880192100105', 'Channel 2'),
];

void main() async {
  var plug = FlwPlug('192.168.100.107:80');

  test('Read Sensors', () async {
    var sensors = await plug.getSensors();
    print(sensors);
  });

  test('Write Sensors', () async {
    await plug.setSensors(defaultSensors);
  });

  test('Snapshot', () async {
    var snapshot = await plug.snapshot();
    print(snapshot);
  });

  test('Read Content', () async {
    // get first address
    var addresses = await plug.socket.addresses();

    // get h43
    var h43 = await plug.socket.readH43(addresses.first);

    //
    var content = FlwSocketContent.fromJson(h43.content);

    print(content);
  });

  test('Write Content', () async {
    // get first address
    var addresses = await plug.socket.addresses();

    // create content
    var content = FlwSocketContent(defaultSensors);

    // write
    var result = await plug.socket
        .writeH43(FlwSocketContent(defaultSensors).toJson(), addresses.first);

    print(result);
  });
}
