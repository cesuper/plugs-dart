// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'h43.dart';
import 'socket_device_connect_data.dart';

const apiSocket = '/api/socket.cgi';
const apiSocketConnect = '/api/socket/connect.cgi';
const apiSocketRemove = '/api/socket/remove.cgi';

// h43

const apiSocket43 = '/api/socket/43.cgi';

class Socket {
  // network address
  final String _address;

  Socket(String address) : _address = address;

  ///
  Future<int> connect(List<SocketDeviceConnectData> devices) async {
    var uri = Uri.http(_address, apiSocketConnect);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(devices.map((e) => e.toMap()).toList()),
    );
    return r.statusCode;
  }

  ///
  Future<int> remove() async {
    var uri = Uri.http(_address, apiSocketRemove);
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
    var uri = Uri.http(_address, apiSocket, {'family': family});
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  /// Read the content from H43 devices.
  ///
  /// Use [address] to specify what devices to read
  /// otherwise the first h43 device is selected.
  ///
  Future<H43> readH43({String? address}) async {
    var uri = Uri.http(
      _address,
      apiSocket43,
      address == null ? null : {'address': address},
    );
    var r = await http.get(uri);

    return H43.fromJson(r.body);
  }

  ///
  Future<int> writeH43(String content, {String address = ''}) async {
    var uri = Uri.http(_address, apiSocket43);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'address': address, 'content': content}),
    );
    return r.statusCode;
  }
}
