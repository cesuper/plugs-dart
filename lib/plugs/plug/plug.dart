import 'dart:convert';
import 'dart:io' as io;

import 'package:http/http.dart' as http;
import 'package:plugs/socket/socket.dart';

import 'diagnostic.dart';
import 'info.dart';

//
typedef EventCallback = void Function(Plug plug, int code);

class Plug {
  // remote tcp port from where events originated
  static const eventPort = 6069;

  // size of the tcp packet in bytes
  static const eventSize = 16;

  // Ping event is used to get life-signal from plugs. These events
  // are not handled by the api, but the loss if the ping event results
  // device disconnect event. Plug sends ping events in 1 sec period.
  static const eventCodePing = 255;

  // timeout for http calls
  final Duration timeout;

  // plug network address with port
  final String address;

  //
  final Socket socket;

  //
  io.Socket? _socket;

  //
  Plug(
    this.address, {
    this.timeout = const Duration(seconds: 2),
  }) : socket = Socket(address);

  ///
  Future<Info> info() async {
    var uri = Uri.http(address, '/api/plug.cgi');
    var r = await http.get(uri).timeout(timeout);
    return Info.fromJson(r.body);
  }

  ///
  Future<Diagnostic> diagnostic() async {
    var uri = Uri.http(address, '/api/plug/diagnostic.cgi');
    var r = await http.get(uri);
    return Diagnostic.fromJson(r.body);
  }

  /// Restarts the plug
  Future<int> restart({bool bootloader = false}) async {
    var body = bootloader ? {'bootloader': true} : {};

    var uri = Uri.http(address, '/api/plug/restart.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return r.statusCode;
  }

  /// Read EEPROM
  Future<String> readEEPROM() async {
    var uri = Uri.http(address, '/api/plug/eeprom.cgi');
    var r = await http.get(uri);
    return r.body;
  }

  /// Write EEPROM
  Future<int> writeEEPROM(String content) async {
    var uri = Uri.http(address, '/api/plug/eeprom.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: content,
    );
    return r.statusCode;
  }

  ///
  void connect(
    io.InternetAddress sourceAddress, {
    EventCallback? onDisconnected,
    EventCallback? onEvent,
    Function? onError,
    Duration timeout = const Duration(seconds: 2),
    int port = 0,
  }) async {
    io.Socket.connect(
      io.InternetAddress(address, type: io.InternetAddressType.IPv4),
      eventPort,
      sourceAddress: sourceAddress,
      timeout: timeout,
    ).then((socket) {
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
                onEvent?.call(this, code);
            }

            //
            offset += eventSize;
          }
        },
        onError: (e, trace) {
          // close the socket
          socket.destroy();

          // create network error event
          onError?.call(this, e, trace);
        },
        onDone: () {
          // create disconnected
          onDisconnected?.call(this, 0);
        },
      );
    });
  }

  ///
  void close() {
    _socket?.destroy();
  }
}
