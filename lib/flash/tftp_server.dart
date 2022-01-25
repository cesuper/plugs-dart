import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:logger/logger.dart';

///
/// Class represents a basic Tftp server functionality in order
/// detect TFTP RRQ command from a client. Verifired requests
/// can access the firmrware file in a new socket (TFTP Data socket)
class TftpServer {
  // tftp server port
  static const int port = 69;

  // read request command
  static const int rrq = 1;

  // write request command
  static const int wrq = 2;

  // data command
  static const int data = 3;

  // ack command
  static const int ack = 4;

  // error command
  static const int error = 5;

  static Future<bool> waitForTftpRrq(
    InternetAddress localAddress,
    Duration timeout, {
    Logger? logger,
    Level logLevel = Level.error,
  }) async {
    //
    //final log = Logger(printer: PrettyPrinter(methodCount: 0), level: logLevel);

    logger?.d('Starting TFTP server');

    // result flag
    bool isRequestArrived = false;

    // try to bind
    await RawDatagramSocket.bind(localAddress, port).then(
      (socket) async {
        //
        try {
          // wait for incoming TFTP RRQ
          await socket.timeout(timeout).forEach((e) {
            if (e == RawSocketEvent.read) {
              // read
              Datagram? dg = socket.receive();

              // check for null
              if (dg != null) {
                //
                logger?.d('Verifying TFTP RRQ from ${dg.address}}: ${dg.port}');

                // check if tftp request is valid
                if (_isValidTftpRrq(dg.data)) {
                  //
                  logger?.d('Valid TFTP RRQ arrived');

                  if (isRequestArrived == false) {
                    // set flag, to ignore multiple request
                    isRequestArrived = true;

                    // close socket, done
                    socket.close();

                    //
                    logger?.i(
                        'TFTP RRQ operation completed: ${dg.address}}, port: ${dg.port}');
                  } else {
                    //
                    logger?.d('Extra TFTP RRQ arrived');
                  }
                } else {
                  //
                  logger?.e('Invalid TFTP RRQ');

                  // close socket for invalid request
                  socket.close();
                }
              }
            }
          });
        } on TimeoutException {
          //
          logger?.d('TFTP RRQ request not arrived: $timeout');
        } catch (e) {
          logger?.e(e);
        } finally {
          // close socket
          socket.close();
        }
      },
      onError: (e) {
        // log error, here we expect port in use
        logger?.e('Socket bind failed: $e');
      },
    );

    return isRequestArrived;
  }

  /// returns true if
  static bool _isValidTftpRrq(Uint8List data) {
    //
    var bytes = data.buffer.asByteData();
    //
    return bytes.getUint8(0) == 0x00 && bytes.getUint8(1) == TftpServer.rrq;
  }
}
