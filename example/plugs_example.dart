import 'package:plugs/plugs.dart';
import 'package:plugs/scp/Scp412.dart';

void main() async {
  var plug = Scp412('192.168.100.111:8080');
  var group = await plug.readGroup();
  var socket = plug.socket;

  // read all addressess
  print(await socket.addresses());

  // h28
  var h28Addresses = await socket.h28();
  print(await socket.h28Data(h28Addresses.join(',')));

  // h43
  var h43Addresses = await socket.h43();

  // h43.write
  print(await socket.h43WriteData(h43Addresses.first, 'myData'));

  // h43.read
  print(await socket.h43Data(h43Addresses.join(',')));

  var awesome = Awesome();
  print('awesome: ${awesome.isAwesome}');
}
