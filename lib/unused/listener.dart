import 'dart:async';
import 'dart:io';

typedef EventListenerCallaback = void Function(
  Listener listener,
  int code,
);

class Listener {
  // remote tcp port from where events originated
  static const port = 6069;

  // size of the tcp packet in bytes
  static const eventSize = 16;

  // Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  static const eventCodePing = 255;

  // plug host address
  final InternetAddress host;

  // Local address to bind when making connection
  final InternetAddress? sourceAddress;

  //
  final EventListenerCallaback onConnect;

  //
  final EventListenerCallaback onDisconnect;

  //
  final EventListenerCallaback onEvent;

  //
  final EventListenerCallaback onError;

  //
  Socket? _socket;

  ///
  /// TCP socket client connection between [host] and [sourceAddress]
  ///
  /// [host] plug address
  /// [stream] streamcontroller as source of plug events
  /// [sourceAddress] can be used to specify the local address to bind when making the connection.
  Listener(
    this.host,
    this.onConnect,
    this.onDisconnect,
    this.onEvent,
    this.onError, {
    this.sourceAddress,
  });

  ///
  /// Function to open TCP socket client to the [host] and listen for incoming
  /// events within
  ///
  /// The argument [timeout] is used to specify the maximum allowed time to wait
  /// for a connection to be established. If [timeout] is longer than the system
  /// level timeout duration, a timeout may occur sooner than specified in
  /// [timeout]. On timeout, a [SocketException] is thrown and all ongoing
  /// connection attempts to [host] are cancelled.
  ///
  /// [timeout] is used to detect device loss. Plug provides periodic ping
  /// events in every seconds. If no event occurres in [timeout] the connection
  /// considered as broken.
  Future<void> connect({Duration timeout = const Duration(seconds: 2)}) async {
    Socket.connect(
      host,
      port,
      sourceAddress: sourceAddress,
      timeout: timeout,
    ).then((socket) {
      // call provided callback
      onConnect(this, 0);

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
                onEvent(this, code);
              // create general event
              //eventStream.add(Event(DateTime.now(), host.address, code));
            }

            //
            offset += eventSize;
          }
        },
        onError: (e, trace) {
          // close the socket
          socket.destroy();

          // create network error event
          onError(this, 0);
          // eventStream.add(Event(DateTime.now(), host.address, Event.error));
        },
        onDone: () {
          // create offline event
          onDisconnect(this, 0);
          //eventStream.add(Event(DateTime.now(), host.address, Event.offline));
        },
      );
    });
  }

  ///
  void close() {
    // destroy socket
    _socket?.destroy();
  }
}
