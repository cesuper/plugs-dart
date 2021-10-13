import 'package:plugs/cp/cp_const.dart';
import 'package:plugs/cp/cp_plug.dart';

import 'package:test/test.dart';

void main() async {
  var plug = CpPlug('192.168.100.105:80', 8);

  test('Read Channels from Socket', () async {
    var sensors = await plug.getSensors();

    print(sensors);
  });

  // test('Write Channels to Socket', () async {
  //   // channels to read
  //   var channels = cpChannels;

  //   await plug.writeChannels(channels);
  // });

  test('Sampling test', () async {
    print(await plug.snapshot());
  });
}
