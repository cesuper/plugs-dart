import 'dart:io';
import 'package:logger/logger.dart';

final log = Logger(printer: PrettyPrinter(methodCount: 0));

void main() async {
  //
  const port = 6069;

  //
  const address = '192.168.100.101';

  //
  while (true) {
    try {
      var notifier = await Socket.connect(address.split(':').first, port)
          .timeout(const Duration(seconds: 2));
      log.i('Connected');
      notifier.destroy();
      break;
    } catch (e) {
      log.e(e);
    }
  }

  //
  //var plug = Smp('192.168.100.110:80', 8);

  // test('event test', () async {
  //   var _notifier = await plug.connect();

  //   const int msgSize = 16;

  //   // listen for event with as 16 bytes
  //   _notifier.listen((packet) {
  //     // get the number of messages
  //     var noMsg = packet.length ~/ msgSize;

  //     var offset = 0;

  //     for (var i = 0; i < noMsg; i++) {
  //       // get msg and shift offset
  //       var msg = packet.skip(offset).take(msgSize);

  //       // get event from msg
  //       int event = msg.first;

  //       if (event != 255) {
  //         print(event);
  //       }

  //       offset += msgSize;
  //     }
  //   });

  //   //socket.close();
  //   //socket.destroy();
  //   //print('close sent');

  //   await Future.delayed(const Duration(seconds: 15));
  // }, timeout: const Timeout(Duration(seconds: 60)));

  //
}
