import 'dart:convert';

import 'package:http/http.dart' as http;

import 'H28Data.dart';
import 'H43Data.dart';
import 'SocketDeviceConnectData.dart';

const SOCKET_API = '/api/socket.cgi';
const SOCKET_API_CONNECT = '/api/socket/connect.cgi';
const SOCKET_API_REMOVE = '/api/socket/remove.cgi';
// h28

const SOCKET_API_28_READ = '/api/socket/28/read.cgi';
// h43

const SOCKET_API_43_READ = '/api/socket/43/read.cgi';
const SOCKET_API_43_WRITE = '/api/socket/43/write.cgi';

class Socket {
  // network address
  final String _address;

  Socket(String address) : _address = address;

  ///
  Future<int> connect(List<SocketDeviceConnectData> devices) async {
    var uri = Uri.http('$_address', SOCKET_API_CONNECT);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(devices.map((e) => e.toMap()).toList()),
    );
    return r.statusCode;
  }

  ///
  Future<int> remove() async {
    var uri = Uri.http('$_address', SOCKET_API_REMOVE);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    return r.statusCode;
  }

  /// Returns all connected 1Wire device addresses
  Future<List<String>> addresses({String family = '*'}) async {
    var uri = Uri.http('$_address', SOCKET_API, {'family': family});
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  Future<List<H28Data>> h28Data(String addresses) async {
    var uri = Uri.http('$_address', SOCKET_API_28_READ, {'address': addresses});
    var r = await http.get(uri);
    return List<H28Data>.from(
        (jsonDecode(r.body) as List).map((e) => H28Data.fromMap(e)).toList());
  }

  Future<List<H43Data>> h43Data(List<String> address) async {
    var uri = Uri.http(
        '$_address', SOCKET_API_43_READ, {'address': address.join(',')});
    var r = await http.get(uri);
    return List<H43Data>.from(
        (jsonDecode(r.body) as List).map((e) => H43Data.fromMap(e)).toList());
  }

  Future<int> h43WriteData(String address, String data) async {
    var uri = Uri.http('$_address', SOCKET_API_43_WRITE);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'address': address, 'data': data}),
    );
    return r.statusCode;
  }
}
