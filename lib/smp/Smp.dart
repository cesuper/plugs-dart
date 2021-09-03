import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plugs/plug/Plug.dart';
import 'package:plugs/smp/SmpSamplingRequest.dart';

import 'CpSensor.dart';
import 'SmpSamplingResponse.dart';
import 'const_smp.dart';

// API.SMP

class Smp extends Plug {
  Smp(String address) : super(address);

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

  /// Write Trigger
  Future<SmpSamplingResponse> sample(SmpSamplingRequest request) async {
    var uri = Uri.http('$address', SMP_API_TRIGGER);
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: request.toJson(),
    );

    return SmpSamplingResponse.fromJson(r.body);
  }
}
