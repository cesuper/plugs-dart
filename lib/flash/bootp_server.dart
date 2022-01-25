import 'dart:async';
import 'dart:io';
import 'package:logger/logger.dart';
import 'bootp_packet.dart';
import 'package:collection/collection.dart';
import 'dart:typed_data';

/// Source: After installing the TivaWare toolkit the C source files can be found:
/// C:\ti\TivaWare_C_Series-2.1.3.156\tools\eflash\///
///
/// BOOTP server is responsible for the following
/// - listen for BOOTP requests from devices running in bootloader mode
/// - validate incoming requests by checking the sender mac address
/// - reply is sent to the allowed mac address with ip address and tftp info
///   from where the firmware can be downloaded
///
/// BOOTPData contains the local and remote (target) addresses. Remote target
/// address is set as local address on the target.
///
/// @author D60
///
class BootpServer {
  // bootp server port
  static const serverPort = 67;

  // bootp client port
  static const clientPort = 68;

  ///
  /// Returns true when the packet is valid, otherwise false returned.
  /// Param [deviceMac] is the device hardware address where the packet
  /// expected to arrive from.
  static bool _isValidRequest(BootpPacket request, String targetMac) {
    // convert targetMac string to array of digits
    final mac =
        targetMac.split('-').map((e) => int.parse(e, radix: 16)).toList();

    // get client mac address from packet
    var packetMac = request.clientHardwareAddress.sublist(0, 6);
    var isClientValid = const ListEquality().equals(mac, packetMac);

    // check if server name from client request is tiva or stellaris
    var nameBytes = request.serverName.takeWhile((value) => value != 0);
    var name = String.fromCharCodes(nameBytes);
    var isServerNameValid = name == 'tiva' || name == 'stellaris';

    //
    return request.operation == BootpPacket.request && // read operation
        request.hardwareType == 1 && // ethernet interface
        request.hardwareLength == 6 && // mac address length
        isClientValid && // mac address match
        isServerNameValid; // server name
  }

  ///
  /// Function returns true when a bootp request is detected and a reply sent
  /// back to a target specified by [remoteMac]. At this point the target doesn't
  /// have ip address, therefore the bootp reply encapsulates the [remoteAddress] for the
  /// target.
  /// [localAddress] host address, where the bootp server is running
  /// [remoteAddress] ip address assigned to the target for the duration of the update
  /// [remoteMac] target mac address from where the bootp request packet expected. mac address
  /// expect to be in hypen-hexadecimal notation format
  /// [timeout] time to wait for bootp request
  static Future<bool> waitForBootpPacket(
    InternetAddress localAddress,
    InternetAddress remoteAddress,
    String remoteMac, {
    Duration timeout = const Duration(seconds: 5),
    int serverPort = BootpServer.serverPort,
    int clientPort = BootpServer.clientPort,
    Logger? logger,
    Level logLevel = Level.error,
  }) async {
    //
    //final log = Logger(printer: PrettyPrinter(methodCount: 0), level: logLevel);

    logger?.d('Starting BOOTP server');

    // result flag
    bool isBootpResponseSent = false;

    //
    await RawDatagramSocket.bind(localAddress, serverPort).then((socket) async {
      // enable broadcast
      socket.broadcastEnabled = true;

      try {
        // wait for bootp request for timeout
        await socket.timeout(timeout).forEach((e) {
          if (e == RawSocketEvent.read) {
            // read
            Datagram? dg = socket.receive();

            // check for null
            if (dg != null) {
              //
              logger
                  ?.d('Reading BOOTP packet from: ${dg.address}}: ${dg.port}');

              // get bootp request
              var request = BootpPacket.fromBytes(dg.data);

              //
              logger?.d('Verifying BOOTP packet');

              //
              if (_isValidRequest(request, remoteMac)) {
                //
                logger?.d('Generating BOOTP response');

                // create reply from request
                var reply =
                    _createBootpReply(request, localAddress, remoteAddress);

                // create direct broadcast address to send reply back the target
                var destinationAddress = InternetAddress.fromRawAddress(
                  localAddress.rawAddress..[3] = 0xFF, // set to 255
                  type: InternetAddressType.IPv4,
                );

                //
                logger?.d(
                    'Broadcast address for BOOTP reply: $destinationAddress');

                // Send the reply back to the client using broadcast
                logger?.d('Sending BOOTP response');

                // send response back to target with extra info
                socket.send(reply.datagram, destinationAddress, dg.port);

                // set flag
                isBootpResponseSent = true;

                // close socket, done
                socket.close();

                //
                logger?.i('BOOTP operation completed');
              } else {
                //
                logger?.e('Invalid BOOTP request, close');

                // close socket for invalid requests
                socket.close();
              }
            }
          }
        });
      } on TimeoutException {
        //
        logger?.d('BOOTP request not arrived: $timeout');
      } catch (e) {
        logger?.e(e);
      } finally {
        // close socket
        socket.close();
        //
        logger?.d('Stopping BOOTP server');
      }
    });

    //
    return isBootpResponseSent;
  }

  ///
  /// Creates a bootp reply based on request. This reply is sent back to
  /// the target from where the request came with some modifications.
  /// [request] original bootp request
  /// [localAddress] host address where the bootpserver and tftp server hosted
  /// [remoteAddress] ip address to assign to the target
  static BootpPacket _createBootpReply(
    BootpPacket request,
    InternetAddress localAddress,
    InternetAddress remoteAddress,
  ) {
    // make a copy from the request
    var replyDatagram = Uint8List.fromList(request.datagram);

    // helper
    var bytes = replyDatagram.buffer.asByteData();

    // Change request operation to response
    bytes.setUint8(0, BootpPacket.reply);

    // set the client's address -> this addess is used by the target during the update
    bytes.setUint32(16, BootpPacket.getAddressInt(remoteAddress));

    // set local address as the TFTP server address used by the target
    bytes.setUint32(20, BootpPacket.getAddressInt(localAddress));

    // Provide an image filename to the client.  This is
    // ignored by our TFTP server, but some string is required.
    var fileNameBytes = 'firmware.bin'.codeUnits;
    replyDatagram.buffer.asUint8List().setAll(108, fileNameBytes);

    // return a new bootpacket
    return BootpPacket.fromBytes(replyDatagram.buffer.asUint8List());
  }
}
