import 'package:plugs/cp/cp_const.dart';
import 'package:plugs/cp/cp_plug.dart';

import 'package:test/test.dart';

void main() async {
  var plug = CpPlug('192.168.100.105:80', 8);

  test('Read Channels from Socket', () async {
    var channels = await plug.readChannels();

    print(channels);
  });

  test('Write Channels to Socket', () async {
    // channels to read
    var channels = cpChannels;

    await plug.writeChannels(channels);
  });

  test('Sampling test', () async {
    // get dummy channels
    var channels = cpChannels;

    var r = await plug.fetchData(const Duration(seconds: 3), channels);

    print(r.curves);
  });
}
