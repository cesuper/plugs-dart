import 'package:plugs/cp/cp_plug.dart';

import 'package:test/test.dart';

void main() async {
  var plug = CpPlug('192.168.100.105:80', 8);

  test('Sampling test', () async {
    // get dummy channels
    var channels = CpPlug.channels;

    var r = await plug.fetchData(const Duration(seconds: 3), channels);

    print(r.curves);
  });
}
