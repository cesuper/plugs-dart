import 'package:http/http.dart' as http;
import 'package:plugs/cp/cp_curve.dart';
import 'package:plugs/cp/cp_socket_content.dart';
import 'package:plugs/plugs_const.dart';
import 'package:plugs/smp/smp.dart';

import 'cp_data.dart';
import 'cp_sampling_request.dart';
import 'cp_sampling_response.dart';
import 'cp_channel.dart';

class CpPlug extends Smp {
  //
  static const String model = modelCp;

  //
  CpPlug(String address, int maxSensors) : super(address, maxSensors);

  //

  ///
  ///
  ///
  Future<CpSamplingResponse> sample(CpSamplingRequest request) async {
    var uri = Uri.http(address, '/api/smp/sample.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: request.toJson(),
    );

    return CpSamplingResponse.fromJson(r.body);
  }

  ///
  /// todo handle errors
  ///
  Future<CpData> fetchData(Duration time, List<CpChannel> channels,
      {int freq = 100, int ts = 0}) async {
    // read data
    var r = await sample(
      CpSamplingRequest(1, freq, time.inMilliseconds, channels),
    );

    // todo check for error

    // convert to cpData
    var curves = <CpCurve>[];

    // create Curves from response
    // the order of values in the response equals to the
    // order of the values in the request. Based on this assimptution
    // we can use 'index' assign response to request
    for (int i = 0; i < channels.length; i++) {
      curves.add(CpCurve(channels[i], r.sensors[i].p));
    }

    // create ts if not provided
    return CpData(ts == 0 ? DateTime.now().millisecondsSinceEpoch : ts, curves);
  }

  ///
  /// todo handle errors
  ///
  Future<List<CpChannel>> readChannels() async {
    // todo handler socket errors
    // read content
    var socketData = await socket.readH43();

    // return parsed channels
    return CpSocketContent.fromJson(socketData.content).channels;
  }

  ///
  /// todo handle errors
  ///
  Future<void> writeChannels(List<CpChannel> channels) async {
    // write channels to socket
    await socket.writeH43(CpSocketContent(channels).toJson());
  }
}
