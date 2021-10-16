import 'package:plugs/cp/cp_plug.dart';

import 'package:test/test.dart';

void main() async {
  //
  var plug = CpPlug('192.168.100.105:80', 8);

  test('event test', () async {
    var socket = await plug.connect();

    socket.listen((event) {
      print(event);
    });

    await Future.delayed(const Duration(seconds: 20));
  });

  //
}
