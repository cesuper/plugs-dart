// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plugs/plug/plug.dart';
import 'package:plugs/scp/ScpSnapshot.dart';

import 'scp_trigger_config.dart';
import 'start_pin_params.dart';
import 'stop_pin_params.dart';

// API
const apiScp = '/api/scp.cgi';
const apiScpConfig = '/api/scp/config.cgi';
const apiScpConfigTrigger = '/api/scp/config/trigger.cgi';
const apiScpField = '/api/scp/field.cgi';
const apiScpPinStart = '/api/scp/pin/start.cgi';
const apiScpPinStop = '/api/scp/pin/stop.cgi';

abstract class Scp extends Plug {
  // number of inputs
  final int noInputs;

  // number of outputs
  final int noOutputs;

  Scp(String address, this.noInputs, this.noOutputs) : super(address);

  /// Read Snapshot
  Future<SpcStateResponse> state() async {
    var uri = Uri.http(address, apiScp);
    var r = await http.get(uri);
    return SpcStateResponse.fromJson(r.body);
  }

  /// Read Field
  Future<bool> field() async {
    var uri = Uri.http(address, apiScpField);
    var r = await http.get(uri);
    return jsonDecode(r.body);
  }

  /// Write Field
  Future<int> setField(bool state) async {
    var uri = Uri.http(address, apiScpField);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(state),
    );
    return r.statusCode;
  }

  /// Start Pin
  Future<int> startPin(int pin, int timeout,
      {int delay = 0, int port = 1}) async {
    var uri = Uri.http(address, apiScpPinStart);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: StartPinParams(port, pin, delay, timeout).toJson(),
    );
    return r.statusCode;
  }

  /// Stop Pin
  Future<int> stopPin(int pin, {int port = 1}) async {
    var uri = Uri.http(address, apiScpPinStop);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: StopPinParams(port, pin).toJson(),
    );
    return r.statusCode;
  }

  ///
  /// Trigger Config
  ///

  /// get trigger config
  Future<ScpTriggerConfig> triggerConfig() async {
    var uri = Uri.http(address, apiScpConfigTrigger);
    var r = await http.get(uri);
    return ScpTriggerConfig.fromJson(r.body);
  }

  /// set Trigger config
  Future<int> setTriggerConfig(ScpTriggerConfig config) async {
    var uri = Uri.http(address, apiScpConfigTrigger);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: config.toJson(),
    );
    return r.statusCode;
  }
}
