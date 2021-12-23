import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:plugs/discovery/discovery_response.dart';
import 'package:plugs/plugs/plug/info.dart';

class Discovery {
  /// Port used by plugs to recieve discovery request
  static const int remotePort = 6060;

  /// Port used by plugs to recieve discovery request (ucq)
  static const int remotePortLegacy = 1001;

  //
  static Future<List<DiscoveryResponse>> discover(
    InternetAddress localAddress, {
    Duration timeout = const Duration(seconds: 1),
    bool legacy = false,
  }) async {
    //
    var socket = await RawDatagramSocket.bind(localAddress, 0);

    // enable broadcast
    socket.broadcastEnabled = true;

    // todo use unified request code
    // create reqest
    final request = List.generate(DiscoveryResponse.size, (index) => 0x00)
      ..[0] = legacy ? 0xC9 : 0x01;

    // set port
    final port = legacy ? remotePortLegacy : remotePort;

    // create result array
    final result = <DiscoveryResponse>[];

    //
    socket.listen(
      (e) {
        if (e == RawSocketEvent.read) {
          // read a chunk
          Datagram? dg = socket.receive();

          // check if dg available
          if (dg != null) {
            // todo wait for DiscoveryResponse.size

            //
            if (legacy == false) {
              // get the string content from the datagram
              final sub = dg.data.takeWhile((value) => value != 0).toList();
              final str = utf8.decode(sub, allowMalformed: true);
              final info = Info.fromJson(str);

              //
              result.add(DiscoveryResponse(
                dg.address.address,
                info.hardware.mac,
                info.hardware.code,
                info.hardware.serial,
                '${info.software.major}.${info.software.minor}.${info.software.fix}',
              ));
            } else {
              result.add(_fromLegacy(dg));
            }
          }
        }
      },
    );
    // construct direct broadcast address from local address
    var targetRawAddress = localAddress.rawAddress..[3] = 0xFF;

    // create destination address from direct broadcast address
    var destinationAddress = InternetAddress.fromRawAddress(
      targetRawAddress,
      type: InternetAddressType.IPv4,
    );

    // send discovery request
    socket.send(request, destinationAddress, port);

    // wait for reply
    await Future.delayed(timeout);

    //
    socket.close();

    // return result
    return result;
  }

  ///
  static DiscoveryResponse _fromLegacy(Datagram dg) {
    //
    // mac
    // convert base10 mac digits to formatted hex chars
    final macDigitsB10 = dg.data.buffer.asUint8List(6, 6);
    final buffer = StringBuffer();
    for (var digit in macDigitsB10) {
      buffer.write(digit.toRadixString(16).padLeft(2, '0'));
      buffer.write('-');
    }
    var mac = buffer.toString();
    // remove trailing '-'
    mac = mac.substring(0, mac.length - 1);

    //
    // serial
    //

    // get name in format 'smp8-00422'
    final name =
        String.fromCharCodes(dg.data.buffer.asUint8List(22, 15)).toLowerCase();

    // get family
    final family = name.substring(0, 3);

    final serial = family;

    return DiscoveryResponse(
      dg.address.address,
      mac,
      dg.data.buffer.asByteData().getUint8(2),
      serial,
      dg.data.buffer.asUint8List(12, 3).join('.'),
    );
  }
}
