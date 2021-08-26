import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plugs/plug/Plug.dart';
import 'package:plugs/smp/SmpBufferedData.dart';
import 'package:plugs/smp/SmpInfo.dart';
import 'package:plugs/smp/SmpSnapshot.dart';
import 'package:plugs/smp/SmpTrigger.dart';

import 'SmpChannel.dart';

const SMP_API = '/api/smp.cgi';
const SMP_API_INFO = '/api/smp/info.cgi';
const SMP_API_CHANNELS = '/api/smp/channels.cgi';
const SMP_API_CONFIG = '/api/smp/config.cgi';
const SMP_API_SMP_TRIGGER = '/api/smp/trigger.cgi';
const SMP_API_GENERATOR = '/api/smp/generator.cgi';
const SMP_API_GENERATOR_START = '/api/smp/generator/start.cgi';
const SMP_API_SMP_GENERATOR_STOP = '/api/smp/generator/stop.cgi';
const SMP_API_SMP_BUFFER = '/api/smp/buffer.cgi';
const SMP_API_SMP_BUFFER_STATUS = '/api/smp/buffer/status.cgi';

class Smp extends Plug {
  Smp(String address) : super(address);

  /// Read Channels
  Future<List<SmpChannel>> channels() async {
    var uri = Uri.http('$address', SMP_API_CHANNELS);
    var r = await http.get(uri);
    return List<SmpChannel>.from(
            (jsonDecode(r.body) as List).map((e) => SmpChannel.fromMap(e)))
        .toList();
  }

  /// Write Channels
  Future<int> setChannels(List<SmpChannel> channels) async {
    var uri = Uri.http('$address', SMP_API_CHANNELS);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(channels.map((e) => e.toMap()).toList()),
    );
    return r.statusCode;
  }

  /// Read Snapshot
  Future<SmpSnapshot> snapshot() async {
    var uri = Uri.http('$address', SMP_API);
    var r = await http.get(uri);
    return SmpSnapshot.fromJson(r.body);
  }

  /// Read info
  Future<SmpInfo> readSmpInfo() async {
    var uri = Uri.http('$address', SMP_API_INFO);
    var r = await http.get(uri);
    return SmpInfo.fromJson(r.body);
  }

  /// Read buffer status
  Future<bool> readBufferStatus() async {
    var uri = Uri.http('$address', SMP_API_SMP_BUFFER_STATUS);
    var r = await http.get(uri);
    return jsonDecode(r.body);
  }

  /// Read buffer
  Future<SmpBufferedData> readBuffer() async {
    var uri = Uri.http('$address', SMP_API_SMP_BUFFER);
    var r = await http.get(uri);
    return SmpBufferedData.fromJson(r.body);
  }

  /// Read Trigger
  Future<SmpTrigger> readTrigger() async {
    var uri = Uri.http('$address', SMP_API_SMP_TRIGGER);
    var r = await http.get(uri);
    return SmpTrigger.fromJson(r.body);
  }

  /// Write Trigger
  Future<int> writeTrigger(SmpTrigger trigger) async {
    var uri = Uri.http('$address', SMP_API_SMP_TRIGGER);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: trigger.toJson(),
    );
    return r.statusCode;
  }
}
