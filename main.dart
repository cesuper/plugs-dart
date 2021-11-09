import 'dart:io';
import 'package:logger/logger.dart';
import 'package:plugs/smp/smp.dart';

final log = Logger(printer: PrettyPrinter(methodCount: 0));

void main(List<String> args) async {
  //
  var plug = Smp('192.168.100.110:80', 8);

  var _notifier = await plug.connect();

  log.i(
      'Connected to: ${_notifier.remoteAddress.address}:${_notifier.remotePort}');

  const int msgSize = 16;

  // listen for event with as 16 bytes
  _notifier.listen((packet) {
    // get the number of messages
    var noMsg = packet.length ~/ msgSize;

    var offset = 0;

    for (var i = 0; i < noMsg; i++) {
      // get msg and shift offset
      var msg = packet.skip(offset).take(msgSize);

      // get event from msg
      int event = msg.first;

      if (event != 255) {
        print(event);
      }

      offset += msgSize;
    }
  });

  // notifer.listen((packet) {
  //   print(packet);

  //   // get the number of messages
  //   var noMsg = packet.length ~/ msgSize;
  //   var offset = 0;

  //   for (var i = 0; i < noMsg; i++) {
  //     // get msg and shift offset
  //     var msg = packet.skip(offset).take(msgSize);

  //     // get event from msg
  //     int event = msg.first;

  //     log.i(event);

  //     offset += msgSize;
  //   }
  // }, onError: (error) {
  //   log.e(error);
  //   notifer.destroy();
  // }, onDone: () {
  //   log.i('Server left');
  //   notifer.destroy();
  // });

  //
  log.i('waiting for exit');
  stdin.readLineSync();
  _notifier.destroy();
  await _notifier.close();
  log.i('EXIT');
}
