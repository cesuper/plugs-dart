// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plugs/socket/memory.dart';
import 'h43.dart';

class Socket {
  // network address
  final String _address;

  Socket(String address) : _address = address;

  /// Returns all connected 1Wire device addresses
  /// or empty array when not found
  Future<List<String>> addresses() async {
    var uri = Uri.http(_address, '/api/socket.cgi');
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  /// Return socket memory state
  Future<Memory> getMemory() async {
    final uri = Uri.http(_address, '/api/socket/memory/info.cgi');
    final r = await http.get(uri);
    return Memory.fromJson(r.body);
  }

  ///

  Future<String> readMemory() async {
    final uri = Uri.http(_address, '/api/socket/memory.cgi');
    final r = await http.get(uri);
    return r.body;
  }

  ///
  ///
  ///
  Future<int> writeMemory(String content, String address) async {
    var uri = Uri.http(_address, '/api/socket/memory.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'address': address, 'content': content}),
    );
    return r.statusCode;
  }
}
