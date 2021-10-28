import 'package:plugs/cp/cp_plug.dart';

import 'package:test/test.dart';

void main() async {
  //
  var plug = CpPlug('192.168.100.106:80', 8);

  test('event test', () async {
    var socket = await plug.connect();

    socket.listen((event) {
      int code = event.first;

      if (code != 255) {
        print(code);
      }
    });

    //await Future.delayed(const Duration(seconds: 3));

    //socket.close();
    //socket.destroy();
    //print('close sent');

    await Future.delayed(const Duration(seconds: 25));
  });

  //
}
