import 'dart:convert';

import 'package:http/http.dart';
import 'package:plugs/smp/smp_sensor_param.dart';
import 'package:plugs/smp/smp_settings.dart';
import 'package:plugs/smp/smp_snapshot.dart';

import '../flw/flw_sensor_param.dart';
import '../flw/flw_settings.dart';
import '../flw/flw_snapshot.dart';

import '../scp/scp_ain_settings.dart';
import '../scp/scp_ain_snapshot.dart';
import '../scp/scp_ain_sensor_param.dart';
import 'ain_sensor_param.dart';
import 'ain_settings.dart';
import 'ain_snapshot.dart';

//
const apiAin = '/api/ain.cgi';
const apiAinSettings = '/api/ain/settings.cgi';
const apiAinSensors = '/api/ain/sensors.cgi';
const apiAinBuffer = '/api/ain/buffer.cgi';

class AinApi {
  ///
  static T _tSnapshotFromJson<T extends AinSnapshot>(String source) {
    switch (T) {
      case FlwSnapshot:
        return FlwSnapshot.fromJson(source) as T;
      case ScpAinSnapshot:
        return ScpAinSnapshot.fromJson(source) as T;
      case SmpSnapshot:
        return SmpSnapshot.fromJson(source) as T;
      default:
        throw UnimplementedError();
    }
  }

  ///
  static Future<T> getSnapshot<T extends AinSnapshot>(String address,
      {bool isBuffered = false}) async {
    //
    var response =
        await get(Uri.http(address, isBuffered ? apiAinBuffer : apiAin));

    return AinApi._tSnapshotFromJson(response.body);
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
  static Future<List<T>> getSensors<T extends AinSensorParam>(
      String address) async {
    //
    var response = await get(Uri.http(address, apiAinSensors));

    var jSensors = jsonDecode(response.body) as List;
    return List<T>.from(jSensors.map((e) {
      switch (T) {
        case FlwSensorParam:
          return FlwSensorParam.fromMap(e);
        case ScpAinSensorParam:
          return ScpAinSensorParam.fromMap(e);
        case SmpSensorParam:
          return SmpSensorParam.fromMap(e);
        default:
          throw UnimplementedError();
      }
    }));
  }

  ///
  static Future<int> setSensors(
      String address, List<AinSensorParam> sensors) async {
    var r = await post(
      Uri.http(address, apiAinSensors),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(sensors.map((e) => e.toMap()).toList()),
    );

    return r.statusCode;
  }

  ///
  static Future<T> buffer<T extends AinSnapshot>(
    String address,
    Duration timeout, {
    int ts = 0,
  }) async {
    var response = await post(
      Uri.http(address, apiAinBuffer),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ts': ts}),
    ).timeout(timeout);

    return AinApi._tSnapshotFromJson<T>(response.body);
  }
}
