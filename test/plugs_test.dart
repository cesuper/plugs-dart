import 'package:plugs/smp/Smp.dart';
import 'package:test/test.dart';

void main() async {
  test('My Test', () async {
    var plug = Smp('192.168.100.111:8080');
    print(await plug.readPlug());
  });

  // var plug = Smp('192.168.100.111:8080');
  // print(await plug.readPlug());

  // ///
  // print(await plug.readSnapshot());
  // print(await plug.readSmpInfo());
  // print(await plug.readBuffer());
  // print(await plug.readBufferStatus());
  // print(await plug.readTrigger());

  // //
  // await plug.writeTrigger(1000);

  // await Future.delayed(Duration(seconds: 2));

  // print(await plug.readBuffer());
}
