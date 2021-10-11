// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'h43.dart';

class Socket {
  // network address
  final String _address;

  Socket(String address) : _address = address;

  ///
  /// Returns all connected 1Wire device addresses
  /// or empty array when not found
  ///
  Future<List<String>> addresses() async {
    var uri = Uri.http(_address, '/api/socket.cgi');
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  ///
  /// Read the content from H43 devices.
  ///
  /// Use [address] to specify what devices to read
  /// otherwise the first h43 device is selected.
  ///
  Future<H43> readH43(String address) async {
    var uri = Uri.http(_address, '/api/socket/43.cgi', {'address': address});
    var r = await http.get(uri);
    return H43.fromJson(r.body);
  }

  ///
  ///
  ///
  Future<int> writeH43(String content, String address) async {
    var uri = Uri.http(_address, '/api/socket/43.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'address': address, 'content': content}),
    );
    return r.statusCode;
  }
}
