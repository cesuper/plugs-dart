import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plugs/plug/Plug.dart';
import 'package:plugs/smp/SmpSnapshot.dart';
import 'package:plugs/smp/SmpTrigger.dart';
import 'package:plugs/smp/SmpTriggerResponse.dart';

import 'CpSensor.dart';
import 'const_smp.dart';

// API.SMP

class Smp extends Plug {
  Smp(String address) : super(address);

  /// Read Snapshot
  Future<SmpSnapshot> snapshot() async {
    var uri = Uri.http('$address', SMP_API);
    var r = await http.get(uri);
    return SmpSnapshot.fromJson(r.body);
  }

  /// Read Channels
  Future<List<CpSensor>> sensors() async {
    var uri = Uri.http('$address', SMP_API_SENSORS);
    var r = await http.get(uri);
    return List<CpSensor>.from(
        (jsonDecode(r.body) as List).map((e) => CpSensor.fromMap(e))).toList();
  }

  /// Set Sensors
  Future<int> setSensors(List<CpSensor> channels) async {
    var uri = Uri.http('$address', SMP_API_SENSORS);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(channels.map((e) => e.toMap()).toList()),
    );
    return r.statusCode;
  }

  /// Read buffer
  Future<SmpTriggerResponse> data() async {
    var uri = Uri.http('$address', SMP_API_TRIGGER_DATA);
    var r = await http.get(uri);
    return SmpTriggerResponse.fromJson(r.body);
  }

  /// Write Trigger
  Future<SmpTriggerResponse> trigger(SmpTrigger trigger) async {
    var uri = Uri.http('$address', SMP_API_TRIGGER);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: trigger.toJson(),
    );
    return SmpTriggerResponse.fromJson(r.body);
  }
}
