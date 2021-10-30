// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plugs/plug/plug.dart';

// API

abstract class Scp extends Plug {
  // number of inputs
  final int noInputs;

  // number of outputs
  final int noOutputs;

  Scp(String address, this.noInputs, this.noOutputs) : super(address);

  ///
  Future<bool> field() async {
    var uri = Uri.http(address, '/api/field.cgi');
    var r = await http.get(uri);
    return r.body == 'true';
  }

  ///
  Future<List<bool>> digitalInput() async {
    var uri = Uri.http(address, '/api/di.cgi');
    var r = await http.get(uri);
    return List<bool>.from(jsonDecode(r.body));
  }

  ///
  Future<List<bool>> digitalOutput() async {
    var uri = Uri.http(address, '/api/do.cgi');
    var r = await http.get(uri);
    return List<bool>.from(jsonDecode(r.body));
  }

  ///
  Future<void> startPin(int pin, int timeout, {int delay = 0}) async {
    var uri = Uri.http(address, '/api/do/start.cgi');
    await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'pin': pin, 'delay': delay, 'timeout': timeout}),
    );
  }

  ///
  Future<void> stopPin(int pin) async {
    var uri = Uri.http(address, '/api/do/stop.cgi');
    await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'pin': pin}),
    );
  }
}
