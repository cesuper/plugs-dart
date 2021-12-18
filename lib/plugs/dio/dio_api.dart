import 'dart:convert';

import 'package:http/http.dart';

const apiDi = '/api/di.cgi';
const apiDiField = '/api/di/field.cgi';
const apiDo = '/api/do.cgi';
const apiDoStart = '/api/do/start.cgi';
const apiDoStop = '/api/do/stop.cgi';

class DioApi {
  ///
  static Future<List<bool>> getInput(String address) async {
    var r = await get(Uri.http(address, apiDi));
    return List<bool>.from(jsonDecode(r.body));
  }

  ///
  static Future<bool> getField(String address) async {
    var r = await get(Uri.http(address, apiDiField));
    return r.body == 'true';
  }

  ///
  static Future<List<bool>> getOutput(String address) async {
    var r = await get(Uri.http(address, apiDo));
    return List<bool>.from(jsonDecode(r.body));
  }

  ///
  static Future<int> startPin(String address, int pin, int timeout,
      {int delay = 0}) async {
    var r = await post(
      Uri.http(address, apiDoStart),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'pin': pin, 'delay': delay, 'timeout': timeout}),
    );

    return r.statusCode;
  }

  ///
  static Future<int> stopPin(String address, int pin) async {
    var r = await post(
      Uri.http(address, apiDoStop),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'pin': pin}),
    );

    return r.statusCode;
  }
}
