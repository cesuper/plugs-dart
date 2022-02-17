// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  final client = PlugClient('http://192.168.100.124');
  final api = client.getSmpApi();

  group('State', () {
    test('State', () async {
      final state = await api.getState();
      print(state);
    });

    test('Ain State', () async {
      final state = await api.getState();
      final ain = state.ain;
      print(ain);
    });
  });

  group('Params Group', () {
    test('set params', () async {
      // new parameter
      final params = SmpAinParams(100, 1000);
      await api.setAinParams(params);
      print(await api.getAinParams());
    });

    test('get params', () async {
      // read back
      print(await api.getAinParams());
    });
  });

  group('Buffer Group', () {
    test('buffer', () async {
      final buffer = await api.buffer();
      print(buffer);
    });

    test('get buffer', () async {
      print(await api.getBuffer());
    });
  });
}
