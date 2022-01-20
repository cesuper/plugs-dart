// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plugs/socket/socket.dart';

class SocketApi {
  // network address
  final String _address;

  SocketApi(String address) : _address = address;

  /// Returns all connected 1Wire device addresses
  /// or empty array when not found
  Future<Socket> getSocket() async {
    var uri = Uri.http(_address, '/api/socket.cgi');
    var response = await http.get(uri);

    return Socket.fromJson(response.body);
  }

  ///
  Future<String> readMemory() async {
    final uri = Uri.http(_address, '/api/socket/memory.cgi');
    final response = await http.get(uri);

    return response.body;
  }

  ///
  Future<void> writeMemory(Object content) async {
    var uri = Uri.http(_address, '/api/socket/memory.cgi');
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(content),
    );
  }
}
