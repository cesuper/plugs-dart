import 'dart:convert';

import 'package:http/http.dart' as http;

import 'H28Data.dart';
import 'H43Data.dart';

const CONST_SOCKET_API = '/api/socket.cgi';
// h28
const CONST_SOCKET_API_28 = '/api/socket/28.cgi';
const CONST_SOCKET_API_28_READ = '/api/socket/28/read.cgi';
// h43
const CONST_SOCKET_API_43 = '/api/socket/43.cgi';
const CONST_SOCKET_API_43_READ = '/api/socket/43/read.cgi';
const CONST_SOCKET_API_43_WRITE = '/api/socket/43/write.cgi';

class Socket {
  // network address
  final String _address;

  Socket(String address) : _address = address;

  /// Returns all connected 1Wire device addresses
  Future<List<String>> addresses() async {
    var uri = Uri.http('$_address', CONST_SOCKET_API);
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  /// Returns all connected h28 devices
  Future<List<String>> h28() async {
    var uri = Uri.http('$_address', CONST_SOCKET_API_28);
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  Future<List<H28Data>> h28Data(String addresses) async {
    var uri =
        Uri.http('$_address', CONST_SOCKET_API_28_READ, {'address': addresses});
    var r = await http.get(uri);
    return List<H28Data>.from(
        (jsonDecode(r.body) as List).map((e) => H28Data.fromMap(e)).toList());
  }

  /// Returns all connected h43 devices connected
  Future<List<String>> h43() async {
    var uri = Uri.http('$_address', CONST_SOCKET_API_43);
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  Future<List<H43Data>> h43Data(String addresses) async {
    var uri =
        Uri.http('$_address', CONST_SOCKET_API_43_READ, {'address': addresses});
    var r = await http.get(uri);
    return List<H43Data>.from(
        (jsonDecode(r.body) as List).map((e) => H43Data.fromMap(e)).toList());
  }

  Future<int> h43WriteData(String address, String data) async {
    var uri = Uri.http('$_address', CONST_SOCKET_API_43_WRITE);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'address': address, 'data': data}),
    );
    return r.statusCode;
  }
}
