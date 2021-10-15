import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plugs/cp/cp_data.dart';
import 'package:plugs/plugs_const.dart';
import 'package:plugs/smp/smp.dart';

import 'cp_sensor.dart';

class CpPlug extends Smp {
  //
  static const String model = modelCp;

  //
  CpPlug(String address, int maxSensors) : super(address, maxSensors);

  ///
  ///
  ///
  Future<CpData> setSample(int ts, int time) async {
    var uri = Uri.http(address, '/api/cp/sample.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ts': ts, 'time': time}),
    );
    return CpData.fromJson(r.body);
  }

  ///
  ///
  ///
  Future<CpData> getSample() async {
    var uri = Uri.http(address, '/api/cp/sample.cgi');
    var r = await http.get(uri);
    return CpData.fromJson(r.body);
  }

  ///
  ///
  ///
  Future<List<CpSensor>> getSensors() async {
    var uri = Uri.http(address, '/api/cp/sensors.cgi');
    var r = await http.get(uri);
    var jSensors = jsonDecode(r.body) as List;
    return List<CpSensor>.from(jSensors.map((e) => CpSensor.fromMap(e)))
        .toList();
  }

  ///
  ///
  ///
  Future<int> setSensors(List<CpSensor> sensors) async {
    var uri = Uri.http(address, '/api/cp/sensors.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(sensors.map((e) => e.toMap()).toList()),
    );
    return r.statusCode;
  }

  ///
  ///
  ///
  Future<CpData> snapshot() async {
    var uri = Uri.http(address, '/api/cp.cgi');
    var r = await http.get(uri);
    return CpData.fromJson(r.body);
  }
}
