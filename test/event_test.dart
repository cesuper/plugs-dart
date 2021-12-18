// ignore_for_file: avoid_print

import 'package:plugs/plugs/plug/plug.dart';
import 'package:test/test.dart';

void main() async {
  //
  var plug = Plug('192.168.100.101:80');

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
