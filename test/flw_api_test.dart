// ignore_for_file: avoid_print

import 'package:plugs/api.dart';
import 'package:test/test.dart';

void main() async {
  //
  var client = PlugClient('http://192.168.100.101');
  final flwApi = client.getFlwApi();

  test('Read', () async {
    final flw = await flwApi.getFlw();
    print(flw);
  });

  test('Write', () async {
    //
    final flw = await flwApi.getFlw();
    print(flw);

    final newFlw = Flw(1500, flw.sensors);
    print(newFlw);

    // set new
    await flwApi.setFlw(flw);

    print(await flwApi.getFlw());
  });
}
