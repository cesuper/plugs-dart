import 'dart:io';

//
typedef ListenerConnectionStateChangedCallback = void Function(String address);

//
typedef PlugConnectedCallback = void Function(String address);

//
typedef ConnectionErrorCallback = void Function(String address, dynamic error);

//
typedef PlugEventCallback = void Function(String address, int code, List<int>);

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

  // plug removed from socket
  static const eventSocketRemoved = 20;

  // plug process socket content
  static const eventSocketConnecting = 21;

  // plug removed from socket
  static const eventSocketConnected = 22;

  // plug performed write event to socket
  static const eventSocketContentChanged = 23;

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
        return 'PLUG_PING';
      case eventUpdate:
        return 'PLUG_UPDATE';
      case eventSocketRemoved:
        return 'SOCKET_REMOVED';
      case eventSocketConnecting:
        return 'SOCKET_CONNECTING';
      case eventSocketConnected:
        return 'SOCKET_CONNECTED';
      case eventSocketContentChanged:
        return 'SOCKET_CONTENT_CHANGED';
      case eventIoStateChanged:
        return 'IO_STATE_CHANGED';
      case eventInputTriggered:
        return 'IO_INPUT_TRIGGERED';
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
