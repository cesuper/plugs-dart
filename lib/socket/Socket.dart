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
  ///
  /// Use [family] to filter addresses based on family code. When not
  /// set addresses of all devices returned
  ///
  Future<List<String>> addresses({String family = '*'}) async {
    var uri = Uri.http('$_address', SOCKET_API, {'family': family});
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  Future<List<H28Data>> h28Data({String address = '*'}) async {
    var uri = Uri.http('$_address', SOCKET_API_28_READ, {'address': address});
    var r = await http.get(uri);
    return List<H28Data>.from(
        (jsonDecode(r.body) as List).map((e) => H28Data.fromMap(e)).toList());
  }

  /// Read the content from H43 devices.
  ///
  /// Use [address] to specify what devices to read.
  /// When not set all H43 devices selected to read
  Future<H43Data> readH43({String? address}) async {
    var uri = Uri.http(
      '$_address',
      SOCKET_API_43_READ,
      address == null ? null : {'address': address},
    );
    var r = await http.get(uri);

    return H43Data.fromJson(r.body);
  }

  Future<int> writeH43(String address, String content) async {
    var uri = Uri.http('$_address', SOCKET_API_43_WRITE);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'address': address, 'content': content}),
    );
    return r.statusCode;
  }
}
