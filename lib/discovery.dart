import 'dart:convert';
import 'dart:io';

import 'plugs/plug/info.dart';

///
/// Class for discovering plugs under [localAddress].
/// [Discovery.request] udp data is sent to plugs [Discovery.port] in a direct
/// broadcast way and expecting reply from plugs within [timeout].
/// The discovery response equals to the response of the /api/plug.cgi http req.
///
/// [port] Binds a socket for a given port. 0 = random port
class Discovery {
  /// Port used by plugs to recieve discovery request
  static const int port = 6060;

  /// Discovery request
  static final request = <int>[0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];

  /// Starts the discovery process
  /// [localAddress] local interface address where the plugs being searched
  /// [timeout] time to wait for discovery response
  /// [port] port number to bind, 0 = random port
  ///
  static Future<List<Info>> discover(
    InternetAddress localAddress, {
    Duration timeout = const Duration(seconds: 1),
    int port = 0,
  }) async {
    //
    var infos = <Info>[];

    // todo handle error
    // bind to any port
    var socket = await RawDatagramSocket.bind(localAddress, port);

    // enable broadcast
    socket.broadcastEnabled = true;

    //
    socket.listen(
      (e) {
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
    socket.send(
      Discovery.request,
      destinationAddress,
      Discovery.port,
    );

    // wait for reply
    await Future.delayed(timeout);

    //
    socket.close();

    // return the discovery result
    return infos;
  }
}
