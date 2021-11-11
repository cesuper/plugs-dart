// ignore_for_file: avoid_print

import 'package:plugs/flw/flw.dart';
import 'package:plugs/flw/flw_const.dart';

import 'package:plugs/flw/flw_socket_content.dart';
import 'package:test/test.dart';

void main() async {
  var plug = Flw('192.168.100.107:80');

  test('Read Sensors', () async {
    var sensors = await plug.sensors;
    print(sensors);
  });

  test('Write Sensors', () async {
    await plug.setSensors(flwSensors);
  });

  test('Snapshot', () async {
    var snapshot = await plug.snapshot;
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

  // test('Write Content', () async {
  //   // get first address
  //   var addresses = await plug.socket.addresses();

  //   // create content
  //   var content = flwSocketContent;

  //   // write
  //   var result = await plug.socket
  //       .writeH43(FlwSocketContent(defaultSensors).toJson(), addresses.first);

  //   print(result);
  // });
}
