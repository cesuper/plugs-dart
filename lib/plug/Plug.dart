// ignore_for_file: file_names
import 'dart:convert';

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
  Future<Info> info() async {
    var uri = Uri.http(address, apiPlug);
    var r = await http.get(uri);
    return Info.fromJson(r.body);
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
