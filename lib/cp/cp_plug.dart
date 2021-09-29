import 'package:http/http.dart' as http;
import 'package:plugs/smp/smp.dart';

import 'cp_sampling_request.dart';
import 'cp_sampling_response.dart';

class CpPlug extends Smp {
  //
  static const String model = 'CP';

  //
  CpPlug(String address, int maxSensors) : super(address, maxSensors);

  /// Write Trigger
  Future<CpSamplingResponse> sample(CpSamplingRequest request) async {
    var uri = Uri.http(address, '/api/smp/sample.cgi');
    var r = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: request.toJson(),
    );

    return CpSamplingResponse.fromJson(r.body);
  }

  // todo read / write channels from socket

  // todo read / write mold name from socket

}
