import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plugs/socket/socket_api.dart';

class Plug {
  // timeout for http calls
  final Duration timeout;

  // plug network address with port
  final String address;

  //
  final SocketApi socket;

  //
  Plug(
    this.address, {
    this.timeout = const Duration(seconds: 2),
  }) : socket = SocketApi(address);

  ///
  Future<PlugInfo> info() async {
    var uri = Uri.http(address, '/api/plug.cgi');
    var r = await http.get(uri).timeout(timeout);
    return PlugInfo.fromJson(r.body);
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
