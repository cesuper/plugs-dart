import 'dart:convert';
import 'dart:io' as io;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:plugs/socket/socket.dart';

import 'diagnostic.dart';
import 'info.dart';

//
typedef EventCallback = void Function(String address, int event);

class Plug {
  // tcp port from where notification packets comes
  static const eventPort = 6069;

  // size of the tcp packet in bytes
  static const eventSize = 16;

  // timeout for http calls
  final Duration timeout;

  // plug network address with port
  final String address;

  //
  final Socket socket;

  //
  Plug(this.address, {this.timeout = const Duration(seconds: 2)})
      : socket = Socket(address);

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

  ///
  Future<void> connect({
    bool ignorePingEvent = true,
    EventCallback? onEvent,
    Function? onError,
    Function? onDone,
  }) async {
    //
    var notifier = await io.Socket.connect(address.split(':').first, eventPort);

    // listen on incoming packets
    notifier.listen(
      (packet) {
        // multipe events may arrive in one packet, so we need
        // search multiple events within one packet by slicing the packet
        // into multiple events
        var noEvents = packet.length ~/ eventSize;

        var offset = 0;
        for (var i = 0; i < noEvents; i++) {
          // get msg and shift offset
          var msg = packet.skip(offset).take(eventSize);

          // get event from msg
          int event = msg.first;

          // handle events
          switch (event) {
            case 255:
              if (!ignorePingEvent) onEvent!(address, event);
              break;
            default:
              onEvent!(address, event);
          }

          //
          offset += eventSize;
        }
      },
      cancelOnError: true,
      onError: onError,
      onDone: () => onDone,
    );
  }

  ///
  /// Handles incoming event from notifier and provides
  /// notifyListeners() call based on [event] value.
  /// Unhandled events must be propagated to the super method
  @protected
  bool handleEventCode(int event) {
    switch (event) {
      case 255:
        return true;
      default:
        return false;
    }
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
}
