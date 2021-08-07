import 'dart:convert';

import 'package:http/http.dart' as http;

const CONST_SOCKET_API = '/api/socket.cgi';
const CONST_SOCKET_API_28 = '/api/socket/28.cgi';
const CONST_SOCKET_API_43 = '/api/socket/43.cgi';

class Socket {
  // network address
  final String address;

  Socket(this.address);

  Future<List<String>> addresses() async {
    var uri = Uri.http('$address', CONST_SOCKET_API);
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  Future<List<String>> h28() async {
    var uri = Uri.http('$address', CONST_SOCKET_API_28);
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }

  Future<List<String>> h43() async {
    var uri = Uri.http('$address', CONST_SOCKET_API_43);
    var r = await http.get(uri);
    return List<String>.from(jsonDecode(r.body));
  }
}
