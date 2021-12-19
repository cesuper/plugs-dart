import 'dart:async';
import 'dart:io';

class EventListener {
  // remote tcp port from where events originated
  static const port = 6069;

  // size of the tcp packet in bytes
  static const eventSize = 16;

  // Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  static const eventCodePing = 255;

  // plug ipv4 address
  final String address;

  //
  final StreamController<String> stream;

  //
  Socket? _socket;

  //
  EventListener(this.address, this.stream);

  ///
  Future<void> listen() async {
    // todo add error handler
    Socket.connect(address.split(':').first, port).then((socket) {
      stream.add('$address connected');

      // set as local variable
      _socket = socket;

      // listen on incoming packets
      socket.timeout(const Duration(seconds: 2)).listen(
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
                stream.add('$address event: $code');
            }

            //
            offset += eventSize;
          }
        },
        onError: (e, trace) {
          // close the socket
          socket.destroy();
          print('$address error');
        },
        onDone: () {
          stream.add('$address disconnected');
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
