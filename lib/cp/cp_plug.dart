import 'package:http/http.dart' as http;
import 'package:plugs/cp/cp_curve.dart';
import 'package:plugs/cp/cp_socket_content.dart';
import 'package:plugs/smp/smp.dart';

import 'cp_data.dart';
import 'cp_sampling_request.dart';
import 'cp_sampling_response.dart';
import 'cp_channel.dart';

class CpPlug extends Smp {
  //
  static const String model = 'CP';

  // List of dummy channels
  static final channels = <CpChannel>[
    CpChannel('5OCUGBGR', 10.0, name: 'Ch 1', index: 0, cavity: 1, position: 1),
    CpChannel('5OETIN28', 10.0, name: 'Ch 2', index: 1, cavity: 1, position: 2),
    CpChannel('50OAGBHN', 10.0, name: 'Ch 3', index: 2, cavity: 1, position: 3),
    CpChannel('577KBN88', 10.0, name: 'Ch 4', index: 3, cavity: 2, position: 1),
    CpChannel('6M2OGBHP', 10.0, name: 'Ch 5', index: 4, cavity: 2, position: 2),
    CpChannel('64UF4NBU', 10.0, name: 'Ch 6', index: 5, cavity: 2, position: 3),
    CpChannel('5CWKBN8H', 10.0, name: 'Ch 7', index: 6, cavity: 3, position: 1),
  ];

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

    // try parse
    try {
      // return channels
      return CpSocketContent.fromJson(socketData.content).channels;
    } on FormatException {
      // return empty array when content is invalid
      return <CpChannel>[];
    }
  }

  ///
  /// todo handle errors
  ///
  Future<void> writeChannels(List<CpChannel> channels) async {
    // write channels to socket
    await socket.writeH43(CpSocketContent(channels).toJson());
  }
}
