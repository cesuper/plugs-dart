import 'dart:convert';

import 'package:http/http.dart' as http;
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
