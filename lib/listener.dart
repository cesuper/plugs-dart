import 'dart:convert';
import 'package:universal_io/io.dart' as io;

import 'api.dart';

typedef StateChangedCb = void Function(String address, int event);

typedef ValueChangedDioCb = void Function(
  String address,
  int event,
  ScpDio io,
);
typedef ValueChangedInputTriggeredCb = void Function(
  String address,
  int code,
  int ts,
  List<bool> pins,
);

typedef ValueChangedSampledCb = void Function(
  String address,
  int code,
);

typedef ValueChangedBufferedCb = void Function(
  String address,
  int code,
  int id,
);
typedef ConnectionErrorCb = void Function(String address, dynamic error);

class Listener {
  /// Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  // this event is ignored by the API by default
  static const eventPlugPing = 255;

  //
  static const eventPlugConnected = 1;
  static const eventPlugDisconnected = 2;
  static const eventPlugDiscovered = 3;

  // State changed events

  // fired when http post performed
  // no data
  static const eventStateChangedHttp = 20;

  // fired when no 1-Wire device found
  // no data
  static const eventStateChangedOwBusOpen = 21;

  // fired when at least one 1-Wire device found
  // no data
  static const eventStateChangedOwBusClosed = 22;

  // fired when sampling has started
  // no data
  static const eventStateChangedBuffering = 23;

  /// Value changed events

  // state of the dio (field, in, out) changed
  // has data
  static const eventValueChangedDio = 40;

  // fired when ANY edge condition is true
  // has data
  static const eventValueChangedInputTriggered = 41;

  // fired when plug performed a simple
  // no data
  static const eventValueChangedSampled = 42;

  // fired when buffered sampling has finished
  // no data
  static const eventValueChangedBuffered = 43;

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
    StateChangedCb? onConnected,
    StateChangedCb? onDisconnected,
    StateChangedCb? onChangedHttp,
    StateChangedCb? onOwBusOpened,
    StateChangedCb? onOwBusClosed,
    StateChangedCb? onBuffering,
    ValueChangedDioCb? onDioChanged,
    ValueChangedInputTriggeredCb? onInputTriggered,
    ValueChangedSampledCb? onSampled,
    ValueChangedBufferedCb? onBuffered,
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
              case eventStateChangedHttp:
                onChangedHttp?.call(address, code);
                break;
              case eventStateChangedOwBusOpen:
                onOwBusOpened?.call(address, code);
                break;
              case eventStateChangedOwBusClosed:
                onOwBusClosed?.call(address, code);
                break;
              case eventStateChangedBuffering:
                onBuffering?.call(address, code);
                break;
              case eventValueChangedDio:
                final map = jsonDecode(String.fromCharCodes(data));
                onDioChanged?.call(address, code, ScpDio.fromMap(map));
                break;
              case eventValueChangedInputTriggered:
                final map = jsonDecode(String.fromCharCodes(data));
                final ints = List<int>.from(map['pins']);
                onInputTriggered?.call(
                  address,
                  code,
                  map['ts'] ?? 0,
                  ints.map((e) => e == 1).toList(),
                );
                break;
              case eventValueChangedBuffered:
                onBuffered?.call(address, code, 0);
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
