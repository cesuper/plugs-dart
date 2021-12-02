// ignore_for_file: avoid_print

import 'dart:io';

import 'package:plugs/discovery.dart';

void main() async {
  //
  var destinationAddress = InternetAddress("192.168.100.255");

  var devices = await Discovery.discover(
    InternetAddress('192.168.100.118', type: InternetAddressType.IPv4),
    const Duration(seconds: 2),
  );

  for (var device in devices) {
    print(device);
  }

  // //
  // var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

  // //
  // socket.broadcastEnabled = true;

  // //
  // socket.listen((event) {});

  // RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
  //     .then((RawDatagramSocket udpSocket) {
  //   udpSocket.broadcastEnabled = true;
  //   udpSocket.listen((e) {
  //     if (e == RawSocketEvent.read) {
  //       // read a chunk
  //       Datagram? dg = udpSocket.receive();

  //       //
  //       var data = dg!.data;

  //       //
  //       var sub = data.takeWhile((value) => value != 0).toList();

  //       //
  //       var str = utf8.decode(sub, allowMalformed: true);

  //       //
  //       var info = Info.fromJson(str);

  //       //
  //       print(info);
  //     }
  //   });
  //   List<int> data = [0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
  //   udpSocket.send(data, destinationAddress, 6060);
  // });

  // await Future.delayed(const Duration(seconds: 5));
}
