// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  var client = PlugClient('http://192.168.100.101');

  test('Device', () async {
    //
    final sfpApi = client.getSfpApi();
    final settings = await sfpApi.getSettings();

    print(settings);
  });
}
// // ignore_for_file: avoid_print

// import 'package:logger/logger.dart';
// import 'package:plugs/plugs/sfp/sfp.dart';
// import 'package:plugs/plugs/sfp/sfp_const.dart';
// import 'package:test/test.dart';

// final logger = Logger(printer: PrettyPrinter(methodCount: 0));

// void main() async {
//   var plug = Sfp('192.168.100.108');

//   test('Snapshot', () async {
//     //
//     final snapshot = await plug.snapshot;

//     logger.i(snapshot.ts);
//     logger.i(snapshot.sensors);
//   });

//   test('Get Sensors', () async {
//     logger.i(await plug.sensors);
//   });

//   test('Get Settings', () async {
//     logger.i(await plug.settings);
//   });

//   test('Set Sensors', () async {
//     await plug.setSensors(flwSensors);
//   }, skip: true);

//   // test('Read Content', () async {
//   //   // get first address
//   //   var addresses = await plug.socket.addresses();

//   //   // get h43
//   //   var h43 = await plug.socket.readH43(addresses.first);

//   //   //
//   //   var content = FlwSocketContent.fromJson(h43.content);

//   //   print(content);
//   // });

//   // test('Write Content', () async {
//   //   // get first address
//   //   var addresses = await plug.socket.addresses();

//   //   // create content
//   //   var content = flwSocketContent;

//   //   // write
//   //   var result = await plug.socket
//   //       .writeH43(FlwSocketContent(defaultSensors).toJson(), addresses.first);

//   //   print(result);
//   // });
// }
