import 'dart:convert';
import 'dart:io' as io;

import 'package:http/http.dart' as http;
import 'package:plugs/plug/diagnostic.dart';
import 'package:plugs/socket/socket.dart';

import 'info.dart';

const Duration timeout = Duration(seconds: 2);

class Plug {
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

  //
  Future<io.Socket> connect({int port = 6069}) {
    return io.Socket.connect(address.split(':').first, port);
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
