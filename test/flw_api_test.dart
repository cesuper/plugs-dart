// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  var client = PlugClient('http://192.168.100.101');
  final sfpApi = client.getSfpApi();

  test('Settings', () async {
    final settings = await sfpApi.getSettings();
    print(settings);
  });

  test('Snapshot', () async {
    final snapshot = await sfpApi.getSnapshot();
    print(snapshot);
  });
}
