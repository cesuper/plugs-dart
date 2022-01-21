// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  var client = PlugClient('http://192.168.100.101');
  final flwApi = client.getFlwApi();

  test('Settings', () async {
    final settings = await flwApi.getSettings();
    print(settings);
  });

  test('Snapshot', () async {
    final flw = await flwApi.getFlw();
    print(flw);
  });
}
