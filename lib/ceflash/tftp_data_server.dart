import 'dart:io';
import 'dart:typed_data';
import 'package:logger/logger.dart';
import 'tftp_server.dart';

final log = Logger(printer: PrettyPrinter(methodCount: 0));

/// Tftp data server is used to provide firmware chunks
/// encapsulated into bootp data in multiple blocks
///
class TftpDataServer {
  // target port, this should be originated from TFTP RRQ
  static const targetPort = 13633;

  // size of the tftp data packet in bytes
  static const blockSize = 512;

  static Future<bool> transfer(
    InternetAddress localAddress,
    InternetAddress remoteAddress,
    Duration timeout,
    Uint8List file, {
    Level logLevel = Level.error,
  }) async {
    //
    final log = Logger(
        printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5),
        level: logLevel);

    log.d('Starting TFTP Data server');

    // result flag
    bool isSuccess = false;

    // try to bind to ANY port
    await RawDatagramSocket.bind(localAddress, 0).then(
      (socket) async {
        try {
          // set block number
          int blockNumber = 1;

          log.d('Building TFTP Data packet (Block: $blockNumber)');
          var packet = _createDataPacket(file, blockNumber);

          // send the first tftp data packet
          log.d('Sending block: $blockNumber, size: ${packet.length}');
          socket.send(packet, remoteAddress, targetPort);

          // expect more request from clients to fetch the rest of the file
          await socket.timeout(timeout).forEach((e) {
            if (e == RawSocketEvent.read) {
              // read
              Datagram? dg = socket.receive();

              // check for null
              if (dg != null) {
                //
                log.d('Verify TFTP data packet for ACK');

                // verify
                if (_isBlockAccepted(
                    dg.data.buffer.asByteData(), blockNumber)) {
                  // check if all chunks sent
                  if (file.length < (blockNumber * blockSize)) {
                    // set success flag
                    isSuccess = true;

                    // close socket
                    socket.close();
                  } else {
                    // goto next file chunk
                    blockNumber++;

                    //
                    log.d('Building TFTP Data packet (Block: $blockNumber)');
                    packet = _createDataPacket(file, blockNumber);

                    // send the first tftp data packet
                    log.d(
                        'Sending block: $blockNumber, size: ${packet.length}');
                    socket.send(packet, remoteAddress, targetPort);
                  }
                } else {
                  //
                  // ignore: todo
                  // TODO: implement trials to limit the number of resend actions
                  //
                  log.d('Rebuilding TFTP Data packet (Block: $blockNumber)');
                  packet = _createDataPacket(file, blockNumber);

                  // send the first tftp data packet
                  log.d(
                      'Resending block: $blockNumber, size: ${packet.length}');
                  socket.send(packet, remoteAddress, targetPort);
                }
              }
            }
          });
        } catch (e) {
          log.e(e.toString());
        } finally {
          // close socket
          socket.close();
        }
      },
      onError: (e) {
        // log error, here we expect port in use
        log.e('Socket bind failed: $e');
      },
    );

    return isSuccess;
  }

  ///
  static bool _isBlockAccepted(ByteData data, int blockNumber) {
    return data.getUint8(0) == 0x00 &&
        data.getUint8(1) == TftpServer.ack &&
        data.getUint8(2) == ((blockNumber >> 8) & 0xff) &&
        data.getUint8(3) == (blockNumber & 0xFF);
  }

  /// Retuns the packet size in bytes
  static Uint8List _createDataPacket(Uint8List file, int blockNumber) {
    // temporary workspace for packet data
    var data = Uint8List(700);

    // size of the file chunk to set into packet
    int len = 0;

    // most recent blockLen
    int blockLen = blockNumber * blockSize;

    // if the current block overlaps the file whole length we send only the remaining size
    len = file.length < blockLen
        ? (blockSize - (blockLen - file.length))
        : blockSize;

    // fill packet header
    data.buffer.asByteData().setUint8(0, 0x00);
    data.buffer.asByteData().setUint8(1, TftpServer.data);
    data.buffer.asByteData().setUint16(2, blockNumber);

    // start position, from where the file chunk is copied from
    var start = (blockNumber - 1) * blockSize;

    // end position
    var end = start + len;

    // get a chunk from file
    var blockData = file.getRange(start, end);

    // set into the packet
    data.buffer.asUint8List().setAll(4, blockData);
    //data.setRange(4, len, blockData);

    // file chunk size with header bytes
    return Uint8List.sublistView(data, start = 0, end = len + 4);
  }
}
