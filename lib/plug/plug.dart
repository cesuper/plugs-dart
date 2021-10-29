import 'dart:convert';
import 'dart:io' as io;

import 'package:http/http.dart' as http;
import 'package:plugs/socket/socket.dart';

import 'info.dart';

const apiPlug = '/api/plug.cgi';
const apiPlugRestart = '/api/plug/restart.cgi';
const apiPlugEeprom = '/api/plug/eeprom.cgi';

class Plug {
  // plug network address with port
  final String address;

  //
  final Socket socket;

  Plug(this.address) : socket = Socket(address);

  /// Read Info
  Future<Info> info(
      {Duration timeout = const Duration(milliseconds: 3000)}) async {
    var uri = Uri.http(address, apiPlug);
    var r = await http.get(uri).timeout(timeout);
    return Info.fromJson(r.body);
  }

  Future<io.Socket> connect({int port = 6069}) {
    return io.Socket.connect(address.split(':').first, port);
  }

  /// Restarts the plug
  Future<int> restart({bool bootloader = false}) async {
    var body = bootloader ? {'bootloader': true} : {};

    var uri = Uri.http(address, apiPlugRestart);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return r.statusCode;
  }

  /// Read EEPROM
  Future<String> readEEPROM() async {
    var uri = Uri.http(address, apiPlugEeprom);
    var r = await http.get(uri);
    return r.body;
  }

  /// Write EEPROM
  Future<int> writeEEPROM(String content) async {
    var uri = Uri.http(address, apiPlugEeprom);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: content,
    );
    return r.statusCode;
  }
}
