import 'package:plugs/plugs.dart';
import 'package:plugs/scp/Scp412.dart';

void main() async {
  var plug = Scp412('192.168.100.111:8080');
  var group = await plug.readGroup();
  var socket = plug.socket;

  print(await socket.addresses());
  print(await socket.h28());
  print(await socket.h43());

  var awesome = Awesome();
  print('awesome: ${awesome.isAwesome}');
}
