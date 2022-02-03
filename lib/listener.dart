import 'dart:convert';
import 'package:universal_io/io.dart' as io;

import 'api.dart';

typedef ConnectionChangedCb = void Function(String address);
typedef OwBusChangedCb = void Function(String address);

typedef IoStateChangedCb = void Function(String address, Dio io);
typedef InputPinTriggeredCb = void Function(String address, List<bool> pins);

typedef PlugEventCb = void Function(String address, int code, List<int>);
typedef ConnectionErrorCb = void Function(String address, dynamic error);

class Listener {
  /// Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  // this event is ignored by the API by default
  static const eventPlugPing = 255;

  // request for fw update detected
  static const eventPlugUpdate = 11;

  ///
  /// Socket
  ///

  // fired when no 1-Wire device found
  // no data
  static const eventOwBusOpen = 20;

  // fired when at least one 1-Wire device found
  // no data
  static const eventOwBusClosed = 21;

  // fired when 1-wire bus element changed
  static const eventOwBusChanged = 22;

  /// Dio

  // state of the dio (field, in, out) changed
  // has data
  static const eventIoStateChanged = 40;

  // fired when ANY edge condition is true
  // has data
  static const eventInputTriggered = 41;

  /// Ain

  //
  static const eventSamplingStarted = 60;

  //
  static const eventSamplingFinished = 61;

  // size of the tcp packet
  static const packetSize = 64;

  // remote tcp port from where events originated
  static const eventPort = 6069;

  //
  final String address;

  //
  io.Socket? _socket;

  Listener(this.address);

  ///
  void connect(
    io.InternetAddress localAddress, {
    ConnectionChangedCb? onConnected,
    ConnectionChangedCb? onDisconnected,
    OwBusChangedCb? onOwBusOpened,
    OwBusChangedCb? onOwBusClosed,
    OwBusChangedCb? onOwBusChanged,
    IoStateChangedCb? onIoStateChanged,
    InputPinTriggeredCb? onInputPinTriggered,
    PlugEventCb? onEvent,
    ConnectionErrorCb? onError,
    Duration timeout = const Duration(seconds: 2),
    int port = 0,
  }) async {
    io.Socket.connect(
      io.InternetAddress(address, type: io.InternetAddressType.IPv4),
      eventPort,
      sourceAddress: localAddress,
      timeout: timeout,
    ).then((socket) {
      // fire connected event
      onConnected?.call(address);

      // set as local variable
      _socket = socket;

      // listen on incoming packets
      socket.timeout(timeout).listen(
        (packet) {
          // multipe events may arrive in one packet, so we need
          // search multiple events within one packet by slicing it
          var noEvents = packet.length ~/ packetSize;
          var offset = 0;
          for (var i = 0; i < noEvents; i++) {
            // get event and shift offset
            var event = packet.skip(offset).take(packetSize);

            // get event from msg
            final code = event.first;
            final msg = event.skip(1).takeWhile((value) => value != 0).toList();

            // handle events
            switch (code) {
              case eventPlugPing:
                // ignore ping event
                break;
              case eventOwBusOpen:
                onOwBusOpened?.call(address);
                break;
              case eventOwBusClosed:
                onOwBusClosed?.call(address);
                break;
              case eventOwBusChanged:
                onOwBusChanged?.call(address);
                break;
              case eventIoStateChanged:
                final map = jsonDecode(String.fromCharCodes(msg));
                onIoStateChanged?.call(address, Dio.fromMap(map));
                break;
              case eventInputTriggered:
                final map = jsonDecode(String.fromCharCodes(msg));
                final ints = List<int>.from(map);
                onInputPinTriggered?.call(
                    address, ints.map((e) => e == 1).toList());
                break;
              default:
                print('Unhandled Event: $address - $code');
              //onEvent?.call(address, code, msg);
            }

            //
            offset += packetSize;
          }
        },
        onError: (e, trace) {
          // close the socket
          socket.destroy();

          // create network error event
          onError?.call(address, e);
        },
        onDone: () {
          // create disconnected
          onDisconnected?.call(address);
        },
      );
    });
  }

  ///
  void close() {
    _socket?.destroy();
  }

  /// decode event to String
  static String getName(int code) {
    switch (code) {
      case eventPlugPing:
        return 'eventPlugPing';
      case eventPlugUpdate:
        return 'eventPlugUpdate';
      case eventOwBusOpen:
        return 'eventOwBusOpen';
      case eventOwBusClosed:
        return 'eventOwBusClosed';
      case eventOwBusChanged:
        return 'eventOwBusChanged';
      case eventIoStateChanged:
        return 'eventIoStateChanged';
      case eventInputTriggered:
        return 'eventInputTriggered';
      default:
        return 'UNDEFINED';
    }
  }
}
