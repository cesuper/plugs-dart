import 'dart:convert';
import 'dart:io';

import 'package:plugs/plug/info.dart';

/// Utility class for discovering plugs in the subnet
/// same as [localAddress]. A directed broadcast udp
/// frame is sent and waits for reply until [timeout]
/// elapsed.
class Discovery {
  ///
  static Future<List<Info>> discover(
    InternetAddress localAddress,
    Duration timeout,
  ) async {
    //
    var infos = <Info>[];

    // todo handle error
    // bind to any port
    var socket = await RawDatagramSocket.bind(localAddress, 0);

    // enable broadcast
    socket.broadcastEnabled = true;

    //
    socket.listen((e) {
      if (e == RawSocketEvent.read) {
        // read a chunk
        Datagram? dg = socket.receive();

        // check if dg available
        if (dg != null) {
          // get the string content from the datagram
          var sub = dg.data.takeWhile((value) => value != 0).toList();

          //
          var str = utf8.decode(sub, allowMalformed: true);

          //
          infos.add(Info.fromJson(str));
        }
      }
    });
    //
    var targetRawAddress = localAddress.rawAddress..[3] = 0xFF;

    var destinationAddress = InternetAddress.fromRawAddress(
      targetRawAddress,
      type: InternetAddressType.IPv4,
    );

    // send request
    List<int> data = [0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
    socket.send(data, destinationAddress, 6060);

    // wait
    await Future.delayed(timeout);

    //
    socket.close();

    return infos;
  }
}
