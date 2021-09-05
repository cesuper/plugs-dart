import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

  Future<String> readResponse(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();
    response.transform(utf8.decoder).listen((data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  /// Write Trigger
  Future<SmpSamplingResponse> sample(SmpSamplingRequest request) async {
    // var uri = Uri.http('$address', SMP_API_SAMPLE);
    // var body = request.toJson();
    // final r = await HttpClient().post(uri.host, uri.port, SMP_API_SAMPLE);
    // r.headers.set(
    //   'Content-Length',
    //   body.length.toString(),
    //   preserveHeaderCase: true,
    // );
    // r.headers.set(
    //   'Content-Type',
    //   'application/json',
    //   preserveHeaderCase: true,
    // );
    // r.write(body);
    // var response = await readResponse(await r.close());
    // return SmpSamplingResponse.fromJson(response);

    var uri = Uri.http('$address', SMP_API_SAMPLE);
    var r = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: request.toJson(),
    );

    return SmpSamplingResponse.fromJson(r.body);
  }
}
