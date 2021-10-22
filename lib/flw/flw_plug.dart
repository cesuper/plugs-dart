import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plugs/flw/flw_sensor.dart';
import 'package:plugs/flw/flw_data.dart';
import 'package:plugs/plug/plug.dart';

class FlwPlug extends Plug {
  //
  // number of sensors
  final int maxSensors = 9;

  //
  FlwPlug(String address) : super(address);

  ///
  ///
  ///
  Future<List<FlwSensor>> getSensors() async {
    var uri = Uri.http(address, '/api/flw/sensors.cgi');
    var r = await http.get(uri);

    var jSensors = jsonDecode(r.body) as List;
    return List<FlwSensor>.from(jSensors.map((e) => FlwSensor.fromMap(e)))
        .toList();
  }

  ///
  ///
  ///
  Future<int> setSensors(List<FlwSensor> sensors) async {
    var uri = Uri.http(address, '/api/flw/sensors.cgi');
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
  Future<FlwData> snapshot() async {
    var uri = Uri.http(address, '/api/flw.cgi');
    var r = await http.get(uri);
    return FlwData.fromJson(r.body);
  }
}
