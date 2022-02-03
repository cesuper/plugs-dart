import 'dart:io';

//
typedef ListenerConnectionStateChangedCallback = void Function(String address);

//
typedef PlugConnectedCallback = void Function(String address);

//
typedef ConnectionErrorCallback = void Function(String address, dynamic error);

//
typedef PlugEventCallback = void Function(String address, int code, List<int>);

//
typedef IOStateChangedCallback = void Function(
    String address, bool field, List<bool> input, List<bool> output);

//
typedef InputPinTriggeredCallback = void Function(
    String address, List<bool> triggeredPins);

class Listener {
  ///
  /// Plug
  ///

  /// Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  // this event is ignored by the API by default
  static const eventPing = 255;

  // request for fw update detected
  static const eventUpdate = 11;

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

  /// decode event to String
  static String getName(int code) {
    switch (code) {
      case eventPing:
        return 'eventPing';
      case eventUpdate:
        return 'eventUpdate';
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

  // size of the tcp packet
  static const packetSize = 64;

  // remote tcp port from where events originated
  static const eventPort = 6069;

  //
  final String address;

  //
  Socket? _socket;

  Listener(this.address);

  ///
  void connect(
    InternetAddress localAddress, {
    ListenerConnectionStateChangedCallback? onConnected,
    ListenerConnectionStateChangedCallback? onDisconnected,
    PlugEventCallback? onEvent,
    ConnectionErrorCallback? onError,
    Duration timeout = const Duration(seconds: 2),
    int port = 0,
  }) async {
    Socket.connect(
      InternetAddress(address, type: InternetAddressType.IPv4),
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
              case eventPing:
                // ignore ping event
                break;
              default:
                // call event
                onEvent?.call(address, code, msg);
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
}
