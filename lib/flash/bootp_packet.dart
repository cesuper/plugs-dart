import 'dart:io';
import 'dart:typed_data';

///
/// BOOTPPacket is used as an abstraction of DatagramPacket byte stream.
/// The BOOTPRequest contains the following data that this class defines.
///
/// BOOTP request is sent by the target, when the target is in bootloader mode.
class BootpPacket {
  // bootp operation request
  static const int request = 1;

  // bootp operation reply
  static const int reply = 2;

  // target endianness, where the data comes from
  static final endianness = Endian.big;

  // original datagram
  final Uint8List datagram;

  // (ui8) The operation; 1 is a request, 2 is a reply.
  final int operation;

  // (ui8) The hardware type; 1 is Ethernet.
  final int hardwareType;

  // (ui9) The hardware address length; for Ethernet this will be 6, the length of the MAC address
  final int hardwareLength;

  // (ui8) Hop count, used by gateways for cross-gateway booting
  final int hops;

  // (ui32) The transaction ID
  final int transactionId;

  // (ui16) The number of seconds elapsed since the client started trying to boot
  final int seconds;

  // (ui16) The BOOTP flags
  final int flags;

  // (ui32) The client's IP address, if it knows it.
  final int clientAddress;

  // (ui32) The client's IP address, as assigned by the BOOTP server
  final int yieldAddress;

  // (ui32) The TFTP server's IP address
  final int serverAddress;

  // (ui32) The gateway IP address, if booting cross-gateway
  final int gatewayAddress;

  // (ui[16]) The hardware address; for Ethernet this is the MAC address
  final List<int> clientHardwareAddress;

  // (ui[64]) The name, or nickname, of the server that should handle this BOOTP request
  final Uint8List serverName;

  // (ui[128]) The name of the boot file to be loaded via TFTP
  final Uint8List file;

  // (ui[64]) Optional vendor-specific area; not used for BOOTP.
  final Uint8List vendor;

  BootpPacket(
      this.datagram,
      this.operation,
      this.hardwareType,
      this.hardwareLength,
      this.hops,
      this.transactionId,
      this.seconds,
      this.flags,
      this.clientAddress,
      this.yieldAddress,
      this.serverAddress,
      this.gatewayAddress,
      this.clientHardwareAddress,
      this.serverName,
      this.file,
      this.vendor);

  factory BootpPacket.fromBytes(Uint8List data) {
    var bytes = data.buffer.asByteData();

    //
    return BootpPacket(
      data,
      bytes.getUint8(0), // operation
      bytes.getUint8(1), // hwType
      bytes.getUint8(2), // hwLen
      bytes.getUint8(3), // hops
      bytes.getUint32(4, endianness), // transactionId
      bytes.getUint16(8, endianness), // seconds
      bytes.getUint16(10, endianness), // flags
      bytes.getUint32(12, endianness), // clientAddress
      bytes.getUint32(16, endianness), // yieldAddress
      bytes.getUint32(20, endianness), // serverAddress
      bytes.getUint32(24, endianness), // gatewayAddress

      // 16 - client hardware address
      bytes.buffer.asUint8List(28, 16),

      // 64 - server name
      bytes.buffer.asUint8List(44, 64),

      // 128 - file name
      bytes.buffer.asUint8List(108, 128),

      // 64 - vendor
      bytes.buffer.asUint8List(236, 64),
    );
  }

  ///
  /// Converts Ipv4 address to integer
  static int getAddressInt(InternetAddress address) {
    return address.rawAddress.buffer.asByteData().getUint32(0);
  }

  @override
  String toString() {
    return 'BootPacket(operation: $operation, hardwareType: $hardwareType, hardwareLength: $hardwareLength, hops: $hops, transactionId: $transactionId, seconds: $seconds, flags: $flags, clientAddress: $clientAddress, yieldAddress: $yieldAddress, serverAddress: $serverAddress, gatewayAddress: $gatewayAddress, clientMacAddress: $clientHardwareAddress, serverName: $serverName, file: $file, vendor: $vendor)';
  }
}
