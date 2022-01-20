import 'dart:io';

import 'package:plugs/api.dart';
import 'package:plugs/discovery/discovery_result.dart';

import 'legacy.dart';

/// Class for discovering devices within a subnet.
/// Host sends [size]-byte UDP-based discovery request to the direct broadcast
/// address specified by [localAddress] to the port based on [legacy] mode, then
/// [timeout] is waited to get responses from all available plugs.
///
/// For request, a fixed-size UDP frame is sent with leading [requestCodeDiscovery] byte.
/// Plugs checks the [requestCodeDiscovery] and responds with their device information
/// in order to construct [PlugInfo].
///
/// Set [legacy] flag to expect response from devices with ucq protocol where
/// the device properties are placed into the udp frame as index-based format.
///
/// With non-legacy mode, the [remotePort] port is used and the response for
/// the discovery requests is in json format.
///
class Discovery {
  // size of the discovery response in bytes
  static const size = 128;

  /// Port used by plugs to recieve discovery request (recent)
  //static const int remotePort = 6060;

  /// Port used by plugs to recieve discovery request (ucq)
  static const int remotePort = 1001;

  /// request code to be answered with response
  static const int requestCodeDiscovery = 0xc9;

  /// Starts a new discovery and returns the result.
  static Future<List<DiscoveryResult>> discover(
    InternetAddress localAddress, {
    Duration timeout = const Duration(seconds: 1),
  }) async {
    // empty result
    final result = <DiscoveryResult>[];

    //
    await RawDatagramSocket.bind(localAddress, 0).then((socket) async {
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
              // add new map entry

              // add address to info and create result
              result.add(_fromResponse(dg));

              // Use code below to extract Info from udp frame
              // get the string content from the datagram
              // final sub = dg.data.takeWhile((value) => value != 0).toList();
              // final str = utf8.decode(sub, allowMalformed: true);
              // result[dg.address.address] = Info.fromJson(str);
            }
          }
        },
      );

      // create reqest
      final request = List.generate(size, (index) => 0x00)
        ..[0] = requestCodeDiscovery;

      // set port
      const port = remotePort;

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
    });

    // return result
    return result;
  }

  /// Returns the Info instance from discovery response.
  /// The response is 128-byte length UDP frame with (little-endian) encoding.
  ///
  /// Goal:
  /// Extracting valid revision value from legacy response is the most needed in
  /// order to select the supported firmware for this device.
  ///
  /// Intro:
  /// Early devices doesn't have well defined serial format, therfore extracting
  /// family, model, rev, sn is not trivial. These devices revision number reflects
  /// to the hardware changes instead of firmware compatibility, so the rev value
  /// has different meaning compared to the new devices.
  /// To overcome this issue we need to detect legacy devices from new releases
  /// and use a different method to reconstruct the revision number. The family,
  /// model fields can be reconstructed from the code as well.
  ///
  /// Detecting legacy devices:
  /// Legacy devices can be identified by checking the response.revision fields.
  /// When the rev.major, rev.minor, rev.fix values are not equals to each other
  /// then the device considered as legacy, otherwise the device is a new release
  ///
  /// Obtaining revision value:
  /// For new releases the revision number equals to any of the response frame
  /// rev field, because thery are all the same.
  /// For legacy products, when the rev value doesn't provide valid information
  /// we need to use the sn field to estimate the valid revision value. For each
  /// family, each model (code) a serial number value is checked to get the real
  /// rev. value.
  ///

  static DiscoveryResult _fromResponse(Datagram dg) {
    /// The structure of the response is the following:
    ///
    /// index | value | desc
    ///  0      0xc9    request code
    ///  1      0x00    error code
    /// --------------
    ///  2      0x01    device code as uint8_t but serialized as int, lsb
    ///  3      0x00
    ///  4      0x00
    ///  5      0x00    msb
    /// --------------
    ///  6      0x08    mac address first digit in base10
    ///  7      0x00
    ///  8      0x28
    ///  9      0x5a
    /// 10      0x8f
    /// 11      0xa0    mac address last digit in base10
    /// --------------
    /// 12      0x05    firmware major version
    /// 13      0x01    firmware minor version
    /// 14      0x02    firmware fix version
    /// --------------
    /// 15      0x01    device code as uint8_t but serialized as int, lsb
    /// 16      0x00
    /// 17      0x00
    /// 18      0x00    msb
    /// --------------
    /// 19      0x05  Revision major value as uint8_t
    /// 20      0x00  Revision minor value with value of 0x00 or equals to [19]
    /// 21      0x00  Revision fix value with value of 0x00 or equals to [19]
    /// --------------
    /// 22      0x53  'S', ASCII encoded char, the first char of serial
    /// 23      0x4d  'M', ASCII encoded char, the sencond char of serial
    /// ...

    //
    // Software
    //

    //
    final major = dg.data.buffer.asByteData().getUint8(12);
    final minor = dg.data.buffer.asByteData().getUint8(13);
    final fix = dg.data.buffer.asByteData().getUint8(14);

    final fw = '$major.$minor.$fix';

    //
    // Hardware
    //

    // convert base10 mac digits to formatted hex chars
    final macDigitsB10 = dg.data.buffer.asUint8List(6, 6);
    final buffer = StringBuffer();
    for (var digit in macDigitsB10) {
      buffer.write(digit.toRadixString(16).padLeft(2, '0'));
      buffer.write('-');
    }

    // convert to string
    var mac = buffer.toString();

    // remove trailing '-'
    mac = mac.substring(0, mac.length - 1);

    // code
    final code = dg.data.buffer.asByteData().getUint8(2);

    // get name in format 'smp8-00422' or 'smp8-R5-00422'
    final name = String.fromCharCodes(
            dg.data.buffer.asUint8List(22, 15).takeWhile((value) => value != 0))
        .toLowerCase();

    // get family from code
    final family = Code.getFamily(code);

    // get model from code
    final model = Code.getModel(code);

    // get sn, always the last segment of the serial both legacy and new releases
    final sn = int.parse(name.split('-').last);

    // get rev major, minor and fix and check their values
    final revMajor = dg.data.buffer.asByteData().getUint8(19);
    final revMinor = dg.data.buffer.asByteData().getUint8(20);
    final revFix = dg.data.buffer.asByteData().getUint8(21);

    // check if device is leacy or not
    final isLegacy = _isLegacy(revMajor, revMinor, revFix);

    // get rev based on legacy flag
    final rev = isLegacy ? Legacy.getRevision(code, sn) : revMajor;

    // reconstruct the serial number
    final serial = family + model + '-' + 'r$rev' + '-' + sn.toString();

    // return info, without build value. UDP based discovery does not
    // provide info about the firmware build value
    return DiscoveryResult(
        dg.address.address, code, serial, mac, fw, family, model, rev);
  }

  /// Function returns ture when device is considered as legacy based rev values
  static bool _isLegacy(int revMajor, int revMinor, int revFix) =>
      ![revMinor, revFix].every((element) => element == revMajor);
}
