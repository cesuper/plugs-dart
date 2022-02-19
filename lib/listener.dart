import 'dart:convert';
import 'package:universal_io/io.dart' as io;

//
typedef TriggerCb = void Function(int ts, List<int> pins);

//
typedef SynchronizedCb = void Function(int ts);

typedef ConnectionErrorCb = void Function(String address, dynamic error);

class Listener {
  // plug connected to tcp server
  static const eventConnected = 1;

  // plug disconnected from tcp server
  static const eventDisconnected = 2;

  // plug discovered
  static const eventDiscovered = 3;

  /// Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  // this event is ignored by the API by default
  static const eventPing = 20;

  // fired when no 1-Wire device found
  // data: NA
  static const eventBusOpened = 21;

  // fired when at least one 1-Wire device found
  // data: NA
  static const eventBusClosed = 22;

  // fired when ANY edge condition is true on input pins
  // data: {ts: 1234, pins:[0, 1, 0, 1]}
  static const eventTriggered = 23;

  // fired when sample buffering has started
  // data: NA
  static const eventBufferStarted = 24;

  // fired when sample buffering has finished
  // data: {ts: 1234}
  static const eventBufferFinished = 25;

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
    Function? onConnected,
    Function? onDisconnected,
    Function? onBusOpened,
    Function? onBusClosed,
    TriggerCb? onTriggered,
    Function? onBufferStarted,
    SynchronizedCb? onBufferFinished,
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
      onConnected?.call();

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
              case eventPing:
                // ignore ping event
                break;
              case eventBusOpened:
                onBusOpened?.call();
                break;
              case eventBusClosed:
                onBusClosed?.call();
                break;
              case eventTriggered:
                final map = jsonDecode(String.fromCharCodes(data));
                onTriggered?.call(
                  map['ts'] ?? 0,
                  List<int>.from(map['pins']).toList(),
                );
                break;
              case eventBufferStarted:
                onBufferStarted?.call();
                break;
              case eventBufferFinished:
                final map = jsonDecode(String.fromCharCodes(data));
                onBufferFinished?.call(map['ts'] ?? 0);
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
          onDisconnected?.call();
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
