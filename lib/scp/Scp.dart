import 'package:http/http.dart' as http;
import 'package:plugs/plug/Plug.dart';

import 'TimedPinParam.dart';

// API
const CONST_SCP_API_IN_PIN_START = '/api/scp/in/<pin>/start.cgi';
const CONST_SCP_API_OUT_PIN_START = '/api/scp/out/<pin>/start.cgi';
const CONST_SCP_API_OUT_PIN_STOP = '/api/scp/out/<pin>/stop.cgi';

abstract class Scp extends Plug {
  Scp(String address) : super(address);

  ///
  Future<int> writePin(int index, TimedPinParam param) async {
    var path =
        CONST_SCP_API_OUT_PIN_START.replaceAll('<pin>', index.toString());

    var uri = Uri.http('$address', path);
    var response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: param.toJson(),
    );
    return response.statusCode;
  }
}
