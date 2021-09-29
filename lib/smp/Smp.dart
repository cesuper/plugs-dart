// ignore_for_file: file_names

import 'package:plugs/plug/plug.dart';

// API.SMP

abstract class Smp extends Plug {
  // number of sensors
  final int maxSensors;

  Smp(String address, this.maxSensors) : super(address);

  /// Read Channels
  // Future<List<CpSensor>> sensors() async {
  //   var uri = Uri.http('$address', SMP_API_SENSORS);
  //   var r = await http.get(uri);
  //   return List<CpSensor>.from(
  //       (jsonDecode(r.body) as List).map((e) => CpSensor.fromMap(e))).toList();
  // }

  // /// Set Sensors
  // Future<int> setSensors(List<CpSensor> channels) async {
  //   var uri = Uri.http('$address', SMP_API_SENSORS);
  //   var r = await http.post(
  //     uri,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(channels.map((e) => e.toMap()).toList()),
  //   );
  //   return r.statusCode;
  // }

  // Future<String> readResponse(HttpClientResponse response) {
  //   final completer = Completer<String>();
  //   final contents = StringBuffer();
  //   response.transform(utf8.decoder).listen((data) {
  //     contents.write(data);
  //   }, onDone: () => completer.complete(contents.toString()));
  //   return completer.future;
  // }

}
