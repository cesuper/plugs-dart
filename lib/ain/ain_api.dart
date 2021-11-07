import 'dart:convert';

import 'package:http/http.dart';
import 'package:plugs/cp/smp_sensor.dart';
import 'package:plugs/cp/smp_settings.dart';
import 'package:plugs/cp/smp_snapshot.dart';

import '../flw/flw_sensor.dart';
import '../flw/flw_settings.dart';
import '../flw/flw_snapshot.dart';

import '../scp/scp_ain_settings.dart';
import '../scp/scp_ain_snapshot.dart';
import '../scp/scp_ain_sensor.dart';
import 'ain_sensor.dart';
import 'ain_settings.dart';
import 'ain_snapshot.dart';

//
const apiAin = '/api/ain.cgi';
const apiAinSettings = '/api/ain/settings.cgi';
const apiAinSensors = '/api/ain/sensors.cgi';
const apiAinBuffer = '/api/ain/buffer.cgi';

class AinApi {
  ///
  static Future<T> getSnapshot<T extends AinSnapshot>(String address,
      {bool isBuffered = false}) async {
    //
    var response =
        await get(Uri.http(address, isBuffered ? apiAinBuffer : apiAin));

    switch (T) {
      case FlwSnapshot:
        return FlwSnapshot.fromJson(response.body) as T;
      case ScpAinSnapshot:
        return ScpAinSnapshot.fromJson(response.body) as T;
      case SmpSnapshot:
        return SmpSnapshot.fromJson(response.body) as T;
      default:
        throw UnimplementedError();
    }
  }

  ///
  static Future<T> getSettings<T extends AinSettings>(String address) async {
    //
    var response = await get(Uri.http(address, apiAinSettings));

    switch (T) {
      case FlwSettings:
        return FlwSettings.fromJson(response.body) as T;
      case ScpAinSettings:
        return ScpAinSettings.fromJson(response.body) as T;
      case SmpSettings:
        return SmpSettings.fromJson(response.body) as T;
      default:
        throw UnimplementedError();
    }
  }

  ///
  static Future<int> setSettings(String address, AinSettings settings) async {
    var r = await post(
      Uri.http(address, apiAinSettings),
      headers: {'Content-Type': 'application/json'},
      body: settings.toJson(),
    );

    return r.statusCode;
  }

  ///
  static Future<List<T>> getSensors<T extends AinSensor>(String address) async {
    //
    var response = await get(Uri.http(address, apiAinSensors));

    var jSensors = jsonDecode(response.body) as List;
    return List<T>.from(jSensors.map((e) {
      switch (T) {
        case FlwSensor:
          return FlwSensor.fromMap(e);
        case ScpAinSensor:
          return ScpAinSensor.fromMap(e);
        case SmpSensor:
          return SmpSensor.fromMap(e);
        default:
          throw UnimplementedError();
      }
    }));
  }

  ///
  static Future<int> setSensors(String address, List<AinSensor> sensors) async {
    var r = await post(
      Uri.http(address, apiAinSensors),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(sensors.map((e) => e.toMap()).toList()),
    );

    return r.statusCode;
  }

  ///
  static Future<bool> buffer(String address, {int ts = 0}) async {
    var r = await post(
      Uri.http(address, apiAinBuffer),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ts': ts}),
    );

    return true;
  }
}