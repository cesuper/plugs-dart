import 'dart:async';

import 'package:plugs/plug/plug.dart';

void main() async {
  var plug = Plug('192.168.100.105');

  //
  var socket = await plug.connect();

  socket.listen((event) {
    if (event.first != 0xFF) {
      print(event.first);
    }
  }, onDone: () {
    print('Done');
    socket.destroy();
  });

  await Future.delayed(const Duration(seconds: 30));

  socket.destroy();
}
