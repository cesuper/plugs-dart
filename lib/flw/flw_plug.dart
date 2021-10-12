import 'package:http/http.dart' as http;

import 'package:plugs/flw/flw_plug_cfg.dart';
import 'package:plugs/flw/flw_snapshot.dart';
import 'package:plugs/plug/plug.dart';

class FlwPlug extends Plug {
  //
  final int maxSesors = 9;

  //
  FlwPlug(String address) : super(address);

  ///
  ///
  ///
  Future<FlwPlugCfg> readConfig() async {
    var uri = Uri.http(address, '/api/flw/config.cgi');
    var r = await http.get(uri);
    return FlwPlugCfg.fromJson(r.body);
  }

  ///
  ///
  ///
  Future<int> writeConfig(FlwPlugCfg cfg) async {
    var uri = Uri.http(address, '/api/flw/config.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: cfg.toJson(),
    );
    return r.statusCode;
  }

  ///
  ///
  ///
  Future<FlwSnapshot> snapshot() async {
    var uri = Uri.http(address, '/api/flw.cgi');
    var r = await http.get(uri);
    return FlwSnapshot.fromJson(r.body);
  }
}
