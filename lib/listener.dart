import 'dart:io';

//
typedef EventCallback = void Function(String address, int code);

//
typedef ConnectionStateChangedCallback = void Function(
    String address, bool isConnected);

//
typedef ConnectionErrorCallback = void Function(String address, dynamic error);

class Listener {
  // remote tcp port from where events originated
  static const eventPort = 6069;

  // size of the tcp packet in bytes
  static const eventSize = 16;

  // Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  static const eventCodePing = 255;

  //
  final String address;

  //
  Socket? _socket;

  Listener(this.address);

  ///
  void connect(
    InternetAddress sourceAddress, {
    ConnectionStateChangedCallback? onStateChanged,
    EventCallback? onEvent,
    ConnectionErrorCallback? onError,
    Duration timeout = const Duration(seconds: 2),
    int port = 0,
  }) async {
    Socket.connect(
      InternetAddress(address, type: InternetAddressType.IPv4),
      eventPort,
      sourceAddress: sourceAddress,
      timeout: timeout,
    ).then((socket) {
      // fire connected event
      onStateChanged?.call(address, true);

      // set as local variable
      _socket = socket;

      // listen on incoming packets
      socket.timeout(timeout).listen(
        (packet) {
          // multipe events may arrive in one packet, so we need
          // search multiple events within one packet by slicing it
          var noEvents = packet.length ~/ eventSize;
          var offset = 0;
          for (var i = 0; i < noEvents; i++) {
            // get event and shift offset
            var event = packet.skip(offset).take(eventSize);

            // get event from msg
            int code = event.first;

            // handle events
            switch (code) {
              case eventCodePing:
                // ignore ping event
                break;
              default:
                // call event
                onEvent?.call(address, code);
            }

            //
            offset += eventSize;
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
          onStateChanged?.call(address, false);
        },
      );
    });
  }

  ///
  void close() {
    _socket?.destroy();
  }
}
