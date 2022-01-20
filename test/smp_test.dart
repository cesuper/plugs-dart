// import 'package:logger/logger.dart';
// import 'package:plugs/plugs/smp/smp.dart';
// import 'package:plugs/plugs/smp/smp_const.dart';

// import 'package:test/test.dart';

// final log = Logger(printer: PrettyPrinter(methodCount: 0));

// void main() async {
//   //
//   var plug = Smp('192.168.100.110:80', 8);

//   // test('Socket', () async {
//   //   var notifer = await plug.connect();

//   //   log.i(
//   //       'Connected to: ${notifer.remoteAddress.address}:${notifer.remotePort}');

//   //   const int msgSize = 16;
//   //   notifer.listen((packet) {
//   //     // get the number of messages
//   //     var noMsg = packet.length ~/ msgSize;
//   //     var offset = 0;

//   //     for (var i = 0; i < noMsg; i++) {
//   //       // get msg and shift offset
//   //       var msg = packet.skip(offset).take(msgSize);

//   //       // get event from msg
//   //       int event = msg.first;

//   //       if (event != 255) {
//   //         log.i(event);
//   //       }

//   //       offset += msgSize;
//   //     }
//   //   });
//   // });

//   test('getSensors', () async {
//     var sensors = await plug.sensors;
//     log.i(sensors);
//   });

//   test('getSettings', () async {
//     var settings = await plug.settings;
//     log.i(settings);
//   });

//   test('Snapshot', () async {
//     var snapshot = await plug.snapshot;
//     log.i(snapshot);
//   });

//   test('getbufferedSnapshot', () async {
//     var bufferedSnapshot = await plug.bufferedSnapshot;
//     log.i(bufferedSnapshot);
//   });

//   test('setSensors', () async {
//     await plug.setSensors(smpSensors);
//   });

//   test('buffer', () async {
//     var time = 1000;
//     log.i(await plug.buffer(time));
//   });
// }
