import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plugs/plug/Plug.dart';
import 'package:plugs/smp/SmpBufferedData.dart';
import 'package:plugs/smp/SmpInfo.dart';
import 'package:plugs/smp/SmpSnapshot.dart';
import 'package:plugs/smp/SmpTrigger.dart';

import 'SmpSensor.dart';
import 'const_smp.dart';

// API.SMP

class Smp extends Plug {
  Smp(String address) : super(address);

  /// Read Channels
  Future<List<SmpSensor>> sensors() async {
    var uri = Uri.http('$address', SMP_API_SENSORS);
    var r = await http.get(uri);
    return List<SmpSensor>.from(
        (jsonDecode(r.body) as List).map((e) => SmpSensor.fromMap(e))).toList();
  }

  /// Write Channels
  Future<int> setSensors(List<SmpSensor> channels) async {
    var uri = Uri.http('$address', SMP_API_SENSORS);
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
  Future<bool> triggerStatus() async {
    var uri = Uri.http('$address', SMP_API_TRIGGER_STATUS);
    var r = await http.get(uri);
    return jsonDecode(r.body);
  }

  /// Read buffer
  Future<SmpBufferedData> data() async {
    var uri = Uri.http('$address', SMP_API_TRIGGER_DATA);
    var r = await http.get(uri);
    return SmpBufferedData.fromJson(r.body);
  }

  /// Read Trigger
  Future<SmpTrigger> trigger() async {
    var uri = Uri.http('$address', SMP_API_TRIGGER);
    var r = await http.get(uri);
    return SmpTrigger.fromJson(r.body);
  }

  /// Write Trigger
  Future<int> setTrigger(SmpTrigger trigger) async {
    var uri = Uri.http('$address', SMP_API_TRIGGER);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: trigger.toJson(),
    );
    return r.statusCode;
  }
}
