// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:plugs/plug/info.dart';

void main() async {
  var destinationAddress = InternetAddress("192.168.100.255");

  //
  var socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

  //
  socket.broadcastEnabled = true;

  RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
      .then((RawDatagramSocket udpSocket) {
    udpSocket.broadcastEnabled = true;
    udpSocket.listen((e) {
      if (e == RawSocketEvent.read) {
        // read a chunk
        Datagram? dg = udpSocket.receive();

        //
        var data = dg!.data;

        //
        var sub = data.takeWhile((value) => value != 0).toList();

        //
        var str = utf8.decode(sub, allowMalformed: true);

        //
        var info = Info.fromJson(str);

        //
        print(info);
      }
    });
    List<int> data = [0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
    udpSocket.send(data, destinationAddress, 6060);
  });

  await Future.delayed(const Duration(seconds: 5));
}
