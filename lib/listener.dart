import 'dart:async';
import 'dart:io';

//
typedef ListenerConnectionStateChangedCallback = void Function(String address);

//
typedef PlugConnectedCallback = void Function(String address);

//
typedef ConnectionErrorCallback = void Function(String address, dynamic error);

//
typedef PlugEventCallback = void Function(String address, int code);

// TODO: make this singleton for each plug
class Listener {
  ///
  /// static
  ///

  // Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  // this event is ignored by the API by default
  static const ping = 255;

  // request for fw update detected
  static const update = 11;

  /// Socket

  // plug removed from socket
  static const socketRemoved = 20;

  // plug process socket content
  static const socketConnecting = 21;

  // plug removed from socket
  static const socketConnected = 22;

  // plug performed write event to socket
  static const socketH43Changed = 23;

  /// Dio

  // state of the field pin changed
  static const fieldChanged = 40;

  // state of the input pin changed
  // todo: add pin index, and new value for event data
  static const inputChanged = 41;

  // state of the output pin changed
  // todo: add pin index, and new value for event data
  static const outputChanged = 42;

  /// Ain

  //
  static const samplingStarted = 60;

  //
  static const samplingFinished = 61;

  /// decode event to String
  static String getName(int code) {
    switch (code) {
      case ping:
        return 'PLUG_PING';
      case update:
        return 'PLUG_UPDATE';
      case socketRemoved:
        return 'SOCKET_REMOVED';
      case socketConnecting:
        return 'SOCKET_CONNECTING';
      case socketConnected:
        return 'SOCKET_CONNECTED';
      case socketH43Changed:
        return 'SOCKET_H43_CHANGED';
      default:
        return 'UNDEFINED';
    }
  }

  // size of the tcp packet
  static const packetSize = 64;

  // remote tcp port from where events originated
  static const eventPort = 6069;

  ///
  /// fields
  ///

  //
  final String address;

  //
  Socket? _socket;

  // streamController
  final StreamController<String> controller = StreamController<String>();

  //
  Listener(this.address);

  ///
  Stream<String> connect(
    InternetAddress localAddress, {
    ListenerConnectionStateChangedCallback? onConnected,
    ListenerConnectionStateChangedCallback? onDisconnected,
    PlugEventCallback? onEvent,
    ConnectionErrorCallback? onError,
    Duration timeout = const Duration(seconds: 2),
    int port = 0,
  }) {
    Socket.connect(
      InternetAddress(address, type: InternetAddressType.IPv4),
      eventPort,
      sourceAddress: localAddress,
      timeout: timeout,
    ).then((socket) {
      // fire connected event
      onConnected?.call(address);

      //
      controller.add('Connected');

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
              case ping:
                // ignore ping event
                break;
              default:
                controller.add(getName(code));
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

          controller.add('disconnected');
        },
      );
    });

    //
    return controller.stream;
  }

  ///
  void close() {
    _socket?.destroy();
  }
}
