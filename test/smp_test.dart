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

  group('Buffer Group', () {
    test('buffer', () async {
      final buffer = await smpApi.buffer();
      print(buffer);
    });

    test('get buffer', () async {
      print(await smpApi.getBuffer());
    });
  });

  group('Params Group', () {
    test('set params', () async {
      // new parameter
      final params = SmpAinParams(100, 1000);
      await smpApi.setAinParams(params);
      print(await smpApi.getAinParams());
    });

    test('get params', () async {
      // read back
      print(await smpApi.getAinParams());
    });
  });
}
