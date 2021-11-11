// ignore_for_file: avoid_print

import 'dart:io';

const address = '192.168.100.110:80';
const port = 6069;

void main() async {
  //
  var notifier = await Socket.connect(address.split(':').first, port);

  notifier.listen((event) {
    print(event.first);
  }, onError: (error) {
    print(error);
    notifier.destroy();
  }, onDone: () {
    print('Server left.');
    notifier.destroy();
  }, cancelOnError: true);

  //
  await Future.delayed(const Duration(seconds: 60));
  print('end');
}
