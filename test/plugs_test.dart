import 'package:plugs/smp/Smp.dart';

void main() async {
  var plug = Smp('192.168.100.111:8080');
  print(await plug.readPlug());

  ///
  print(await plug.readSnapshot());
  print(await plug.readSmpInfo());
  print(await plug.readBuffer());
  print(await plug.readBufferStatus());
  print(await plug.readTrigger());

  //
  await plug.writeTrigger(1000);

  await Future.delayed(Duration(seconds: 2));

  print(await plug.readBuffer());
}
