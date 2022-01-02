import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';

/// Class represents the a magic packet that triggers the bootlader mode on plugs.
class MagicPacket {
  /// size of the magic packet request and response in bytes
  static const size = 128;

  /// Port used by plugs to recieve discovery request (recent)
  //static const int remotePort = 6060;

  /// Port used by plugs to recieve discovery request (ucq)
  static const int remotePort = 1001;

  /// request code to be answered with response
  static const int requestCodeUpdate = 0xcd;

  /// Sends a magic packet to the [remoteAddress] and wait [timeout] and
  /// closes the socket.
  /// Some devices may send response for these requests but these responses are ignored
  static Future<void> send(
    InternetAddress localAddress,
    InternetAddress remoteAddress, {
    Duration timeout = const Duration(seconds: 1),
    Level logLevel = Level.error,
  }) async {
    // create logger
    final log = Logger(printer: PrettyPrinter(methodCount: 0), level: logLevel);

    //
    log.d('Bindig socket for Magic Packet');

    //
    await RawDatagramSocket.bind(localAddress, 0).then((socket) async {
      //
      log.d('Sending Update request to $remoteAddress');

      // create request
      final request = List.generate(size, (index) => 0x00)
        ..[0] = requestCodeUpdate;

      // set port
      const port = remotePort;

      // send discovery request
      socket.send(request, remoteAddress, port);

      try {
        // wait for response if there is any
        await socket.timeout(timeout).forEach((e) {
          if (e == RawSocketEvent.read) {
            // read
            Datagram? dg = socket.receive();

            if (dg != null) {
              //
              log.d('Response recieved: ' + String.fromCharCodes(dg.data));
            }
          }
        });
      } on TimeoutException {
        //
      } catch (e) {
        // log error
        log.e(e);
      }

      // close the socket
      socket.close();
    });
  }
}
