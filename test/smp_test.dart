// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  final client = PlugClient('http://192.168.100.124');
  final smpApi = client.getSmpApi();

  test('State', () async {
    final state = await smpApi.getState();
    print(state);
  });

  test('Buffer', () async {
    // start
    await smpApi.buffer();

    // get
    final state = await smpApi.getBuffer();
    print(state);
  });

  test('Params', () async {
    // new parameter
    final ainParams = SmpAinParams(100, 1000);

    // send it
    await smpApi.setAinParams(ainParams);

    // read back
    print(await smpApi.getState());
  });
}
