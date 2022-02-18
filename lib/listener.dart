import 'dart:convert';
import 'package:universal_io/io.dart' as io;

import 'api.dart';

typedef ConnectionChangedCb = void Function(String address, int event);
typedef OwBusChangedCb = void Function(String address, int event);
typedef DioStateChangedCb = void Function(String address, int event, ScpDio io);
typedef InputPinTriggeredCb = void Function(
    String address, int code, int ts, List<bool> pins);
typedef SamplingStartedCb = void Function(String address, int code, int id);
typedef SamplingFinishedCb = void Function(String address, int code, int id);
typedef ConnectionErrorCb = void Function(String address, dynamic error);

class Listener {
  //
  static const eventPlugConnected = 1;

  //
  static const eventPlugDisconnected = 2;

  //
  static const eventPlugDiscovered = 3;

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
  static const packetSize = 128;

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
    DioStateChangedCb? onIoStateChanged,
    InputPinTriggeredCb? onInputPinTriggered,
    SamplingStartedCb? onSamplingStarted,
    SamplingFinishedCb? onSamplingFinished,
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
      onConnected?.call(address, eventPlugConnected);

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
            final data =
                event.skip(1).takeWhile((value) => value != 0).toList();

            // handle events
            switch (code) {
              case eventPlugPing:
                // ignore ping event
                break;
              case eventOwBusOpen:
                onOwBusOpened?.call(address, code);
                break;
              case eventOwBusClosed:
                onOwBusClosed?.call(address, code);
                break;
              case eventOwBusChanged:
                onOwBusChanged?.call(address, code);
                break;
              case eventIoStateChanged:
                final map = jsonDecode(String.fromCharCodes(data));
                onIoStateChanged?.call(address, code, ScpDio.fromMap(map));
                break;
              case eventInputTriggered:
                final map = jsonDecode(String.fromCharCodes(data));
                final ints = List<int>.from(map['pins']);
                onInputPinTriggered?.call(
                  address,
                  code,
                  map['ts'] ?? 0,
                  ints.map((e) => e == 1).toList(),
                );
                break;
              case eventSamplingStarted:
                onSamplingStarted?.call(address, code, 0);
                break;
              case eventSamplingFinished:
                onSamplingFinished?.call(address, code, 0);
                break;
              default:
                print('$address - ${(code)} - ${String.fromCharCodes(data)}');
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
          onDisconnected?.call(address, eventPlugDisconnected);
        },
      );
    });
  }

  ///
  void close() {
    _socket?.destroy();
  }

  /// decode event to String
  // static String _eventName(int code) {
  //   switch (code) {
  //     case eventPlugConnected:
  //       return 'PLUG_CONNECTED';
  //     case eventPlugDisconnected:
  //       return 'PLUG_DISCONNECTED';
  //     case eventPlugDiscovered:
  //       return 'PLUG_DISCOVERED';
  //     case eventPlugPing:
  //       return 'PLUG_PING';
  //     case eventPlugUpdate:
  //       return 'PLUG_UPDATE';
  //     case eventOwBusOpen:
  //       return 'OW_BUS_OPEN';
  //     case eventOwBusClosed:
  //       return 'OW_BUS_CLOSE';
  //     case eventOwBusChanged:
  //       return 'OW_BUS_CHANGED';
  //     case eventIoStateChanged:
  //       return 'IO_CHANGED';
  //     case eventInputTriggered:
  //       return 'IO_TRIGGERED';
  //     case eventSamplingStarted:
  //       return 'SAMPLING_STARTED';
  //     case eventSamplingFinished:
  //       return 'SAMPLING_FINISHED';
  //     default:
  //       return 'UNDEFINED';
  //   }
  // }
}
