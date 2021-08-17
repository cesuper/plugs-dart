import 'package:http/http.dart' as http;
import 'package:plugs/socket/Socket.dart';

import 'Info.dart';

const CONST_PLUG_API = '/api/plug.cgi';
const CONST_PLUG_API_CONFIG = '/api/plug/config.cgi';
const CONST_PLUG_API_SNAPSHOT = '/api/plug/snapshot.cgi';

abstract class Plug {
  // plug network address with port
  final String address;

  final Socket socket;

  Plug(this.address) : socket = Socket(address);

  /// Read Info
  Future<Info> readPlug() async {
    var uri = Uri.http('$address', CONST_PLUG_API);
    var r = await http.get(uri);
    return Info.fromJson(r.body);
  }
}
