import 'dart:io';

//
typedef ListenerConnectionStateChangedCallback = void Function(String address);

//
typedef PlugConnectedCallback = void Function(String address);

//
typedef ConnectionErrorCallback = void Function(String address, dynamic error);

//
typedef PlugEventCallback = void Function(String address, int code);

class Listener {
  ///
  /// Plug
  ///

  /// Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  // this event is ignored by the API by default
  static const eventPing = 20;

  // fired when no 1-Wire device found
  // @data: NONE
  static const eventBusOpened = 21;

  // fired when at least one 1-Wire device found
  // @data: NONE
  static const eventBusClosed = 22;

  // fired when ANY edge condition is true on input pins
  // @data: {ts: 1234, pins: [0, 0, 1, 1]}
  static const eventTriggered = 23;

  // fired when sampling started
  // @data: NONE
  static const eventBufferStarted = 24;

  // fired when sampling finished with preset time
  // @data: {ts: 1234}
  static const eventBufferFinished = 25;

  // fired when Ain state changed (settings or sensors)
  static const eventAinChanged = 26;

  // fired when Vfield state changed
  static const eventVFieldChanged = 27;

  /// decode event to String
  static String getName(int code) {
    switch (code) {
      case eventPing:
        return 'eventPing';
      case eventBusOpened:
        return 'eventBusOpened';
      case eventBusClosed:
        return 'eventBusClosed';
      case eventTriggered:
        return 'eventTriggered';
      case eventBufferStarted:
        return 'eventBufferStarted';
      case eventBufferFinished:
        return 'eventBufferFinished';
      case eventAinChanged:
        return 'eventAinChanged';
      case eventVFieldChanged:
        return 'eventVFieldChanged';
      default:
        return 'UNDEFINED';
    }
  }

  // size of the tcp packet
  static const packetSize = 128;

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
            int code = event.first;

            // handle events
            switch (code) {
              case eventPing:
                // ignore ping event
                break;
              default:
                // call event
                onEvent?.call(address, code);
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
