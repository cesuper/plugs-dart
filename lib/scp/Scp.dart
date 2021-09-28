import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plugs/plug/Plug.dart';
import 'package:plugs/scp/ScpSnapshot.dart';
import 'package:plugs/scp/ScpTriggerConfig.dart';
import 'package:plugs/scp/StartPinParams.dart';
import 'package:plugs/scp/StopPinParams.dart';

// API
const SCP_API = '/api/scp.cgi';
const SCP_API_CONFIG = '/api/scp/config.cgi';
const SCP_API_CONFIG_TRIGGER = '/api/scp/config/trigger.cgi';
const SCP_API_FIELD = '/api/scp/field.cgi';
const SCP_API_PIN_START = '/api/scp/pin/start.cgi';
const SCP_API_PIN_STOP = '/api/scp/pin/stop.cgi';

abstract class Scp extends Plug {
  // number of inputs
  final int noInputs;

  // number of outputs
  final int noOutputs;

  Scp(String address, this.noInputs, this.noOutputs) : super(address);

  /// Read Snapshot
  Future<SpcStateResponse> state() async {
    var uri = Uri.http('$address', SCP_API);
    var r = await http.get(uri);
    return SpcStateResponse.fromJson(r.body);
  }

  /// Read Field
  Future<bool> field() async {
    var uri = Uri.http('$address', SCP_API_FIELD);
    var r = await http.get(uri);
    return jsonDecode(r.body);
  }

  /// Write Field
  Future<int> setField(bool state) async {
    var uri = Uri.http('$address', SCP_API_FIELD);
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
    var uri = Uri.http('$address', SCP_API_PIN_START);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: StartPinParams(port, pin, delay, timeout).toJson(),
    );
    return r.statusCode;
  }

  /// Stop Pin
  Future<int> stopPin(int pin, {int port = 1}) async {
    var uri = Uri.http('$address', SCP_API_PIN_STOP);
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
    var uri = Uri.http('$address', SCP_API_CONFIG_TRIGGER);
    var r = await http.get(uri);
    return ScpTriggerConfig.fromJson(r.body);
  }

  /// set Trigger config
  Future<int> setTriggerConfig(ScpTriggerConfig config) async {
    var uri = Uri.http('$address', SCP_API_CONFIG_TRIGGER);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: config.toJson(),
    );
    return r.statusCode;
  }
}
