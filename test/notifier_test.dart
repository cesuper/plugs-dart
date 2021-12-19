import 'package:logger/logger.dart';
import 'package:plugs/plugs/plug/plug.dart';
import 'package:test/scaffolding.dart';

final log = Logger(printer: PrettyPrinter(methodCount: 0));

void main() async {
  //
  const port = 6069;

  //
  const address = '192.168.100.100';
  //
  final plug = Plug(address);

  test('description', () async {
    var n1 = await plug.connect(
      onEvent: (address, event) => print('$address - $event'),
    );
    //var n2 = await plug.connect();
    //var n3 = await plug.connect();
    //var n4 = await plug.connect();

    await Future.delayed(const Duration(seconds: 40));
  }, timeout: const Timeout(Duration(seconds: 50)));

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
